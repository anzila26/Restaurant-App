import 'package:restaurant_app/data/model/restaurant.dart';

sealed class RestaurantSearchResultState {}

//menambahkan state lain u/ menangani beberapa kondisi proses asinkron
//sedang diam
class RestaurantSearchNoneState extends RestaurantSearchResultState {}

//sedang memuat atau loading
class RestaurantSearchLoadingState extends RestaurantSearchResultState {}

//berhasil dengan error
class RestaurantSearchErrorState extends RestaurantSearchResultState {
  final String error;

  RestaurantSearchErrorState(this.error);
}

//berhasil dengan nilai
class RestaurantSearchLoadedState extends RestaurantSearchResultState {
  final List<Restaurant> data;

  RestaurantSearchLoadedState(this.data);
}
