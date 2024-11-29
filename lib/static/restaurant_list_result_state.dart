import 'package:restaurant_app/data/model/restaurant.dart';

sealed class RestaurantListResultState {}

//menambahkan state lain u/ menangani beberapa kondisi proses asinkron
//sedang diam
class RestaurantListNoneState extends RestaurantListResultState {}

//sedang memuat atau loading
class RestaurantListLoadingState extends RestaurantListResultState {}

//berhasil dengan error
class RestaurantListErrorState extends RestaurantListResultState {
  final String error;

  RestaurantListErrorState(this.error);
}

//berhasil dengan nilai
class RestaurantListLoadedState extends RestaurantListResultState {
  final List<Restaurant> data;

  RestaurantListLoadedState(this.data);
}
