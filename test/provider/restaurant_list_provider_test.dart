import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:restaurant_app/data/api/api_services.dart';
import 'package:restaurant_app/data/model/restaurant.dart';
import 'package:restaurant_app/data/model/restaurant_list_response.dart';
import 'package:restaurant_app/provider/home/restaurant_list_provider.dart';
import 'package:restaurant_app/static/restaurant_list_result_state.dart';

class MockApiServices extends Mock implements ApiServices {}

void main() {
  late MockApiServices apiServices;
  late RestaurantListProvider restaurantListProvider;

  setUp(() {
    apiServices = MockApiServices();
    restaurantListProvider = RestaurantListProvider(apiServices);
  });

  group("restaurant list provider", () {
    test('memastikan state awal provider harus didefinisikan', () {
      expect(
          restaurantListProvider.resultState, isA<RestaurantListNoneState>());
    });

    test(
        'memastikan harus mengembalikan daftar restoran ketika pengambilan data api berhasil',
        () async {
      //mock data sukses
      final mockResponse = RestaurantListResponse(
        error: false,
        message: 'success',
        count: 1,
        restaurants: [
          Restaurant(
            id: 'rqdv5juczeskfw1e867',
            name: 'Melting Pot',
            description:
                'Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. ...',
            pictureId: '14',
            city: 'Medan',
            rating: 4.2,
          ),
        ],
      );

      when(apiServices.getRestaurantList).thenAnswer((_) async => mockResponse);

      await restaurantListProvider.fetchRestaurantList();
      expect(
          restaurantListProvider.resultState, isA<RestaurantListLoadedState>());
      final loadedState =
          restaurantListProvider.resultState as RestaurantListLoadedState;
      expect(loadedState.data, mockResponse.restaurants);
    });

    test('mengambalikan kesalahan ketika pengambilan data api gagal', () async {
      when(apiServices.getRestaurantList).thenThrow(Exception('API Error'));

      await restaurantListProvider.fetchRestaurantList();
      expect(
          restaurantListProvider.resultState, isA<RestaurantListErrorState>());
      final errorState =
          restaurantListProvider.resultState as RestaurantListErrorState;
      expect(errorState.error, 'Exception: API Error');
    });
  });
}
