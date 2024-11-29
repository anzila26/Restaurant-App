import 'package:restaurant_app/data/model/restaurant_detail.dart';

sealed class RestaurantDetailResultState {}

//menambahkan state lain u/ menangani beberapa kondisi proses asinkron
//sedang diam
class RestaurantDetailNoneState extends RestaurantDetailResultState {}

//sedang memuat atau loading
class RestaurantDetailLoadingState extends RestaurantDetailResultState {}

//berhasil dengan error
class RestaurantDetailErrorState extends RestaurantDetailResultState {
  final String error;

  RestaurantDetailErrorState(this.error);
}

//berhasil dengan nilai
class RestaurantDetailLoadedState extends RestaurantDetailResultState {
  final RestaurantDetail data;

  RestaurantDetailLoadedState(this.data);
}
