import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/data/model/restaurant.dart';
import 'package:restaurant_app/data/model/restaurant_detail.dart';
import 'package:restaurant_app/provider/detail/favorite_icon_provider.dart';
import 'package:restaurant_app/provider/favorite/local_database_provider.dart';

class FavoriteIconWidget extends StatefulWidget {
  final RestaurantDetail restaurant;
  const FavoriteIconWidget({
    super.key,
    required this.restaurant,
  });

  @override
  State<FavoriteIconWidget> createState() => _FavoriteIconWidgetState();
}

class _FavoriteIconWidgetState extends State<FavoriteIconWidget> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() async {
      final localDatabaseProvider = context.read<LocalDatabaseProvider>();
      await localDatabaseProvider.loadRestaurantById(widget.restaurant.id);

      if (mounted) {
        final isFavorited =
            localDatabaseProvider.checkItemFavorite(widget.restaurant.id);

        if (localDatabaseProvider.restaurant != null) {
          context.read<FavoriteIconProvider>().isFavorited = isFavorited;
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () async {
        final localDatabaseProvider = context.read<LocalDatabaseProvider>();
        final favoriteIconProvider = context.read<FavoriteIconProvider>();
        final isFavorited = favoriteIconProvider.isFavorited;

        Restaurant restaurant = widget.restaurant.toRestaurant();

        if (!isFavorited) {
          await localDatabaseProvider.saveRestaurant(restaurant);
        } else {
          await localDatabaseProvider.removeRestaurantById(restaurant.id);
        }
        favoriteIconProvider.isFavorited = !isFavorited;
        localDatabaseProvider.loadAllRestaurant();
      },
      icon: Icon(
        context.watch<FavoriteIconProvider>().isFavorited
            ? Icons.favorite
            : Icons.favorite_outline,
      ),
    );
  }
}
