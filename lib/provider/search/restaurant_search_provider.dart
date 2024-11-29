import 'package:flutter/widgets.dart';
import 'package:restaurant_app/data/api/api_services.dart';
import 'package:restaurant_app/static/restaurant_search_result_state.dart';

class RestaurantSearchProvider extends ChangeNotifier {
  //membuat objek apiservices
  final ApiServices _apiServices;

  //membuat constructor
  RestaurantSearchProvider(this._apiServices);

  //menambahkan var state dan getternya agar mudah mengakses dari luar kelas
  RestaurantSearchResultState _resultState = RestaurantSearchNoneState();

  RestaurantSearchResultState get resultState => _resultState;

  //menambahkan try-catch sebagai blok u/ menangkap error
  //bila terjadi kesalahan pada prosesnya
  Future<void> fetchRestaurantSearch(String query) async {
    try {
      _resultState = RestaurantSearchLoadingState();
      notifyListeners();

      final result = await _apiServices.getRestaurantSearch(query);

      if (result.error) {
        _resultState = RestaurantSearchErrorState("No data found");
        notifyListeners();
      } else {
        _resultState = RestaurantSearchLoadedState(result.restaurants);
        notifyListeners();
      }
    } on Exception catch (e) {
      _resultState = RestaurantSearchErrorState(e.toString());
      notifyListeners();
    }
  }
}
