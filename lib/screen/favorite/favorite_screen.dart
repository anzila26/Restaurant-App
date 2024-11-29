import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/provider/favorite/local_database_provider.dart';
import 'package:restaurant_app/screen/home/restaurant_card_widget.dart';
import 'package:restaurant_app/static/navigation_route.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  @override
  void initState() {
    Future.microtask(() {
      context.read<LocalDatabaseProvider>().loadAllRestaurant();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Favorite Restaurant"),
      ),
      body: Consumer<LocalDatabaseProvider>(
        builder: (context, value, child) {
          final restaurantList = value.restaurantList ?? [];
          if (restaurantList.isEmpty) {
            return const Center(child: Text("No Favorited Restaurants"));
          }
          return ListView.builder(
            itemCount: restaurantList.length,
            itemBuilder: (context, index) {
              final restaurant = restaurantList[index];
              return RestaurantCard(
                restaurant: restaurant,
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    NavigationRoute.detailRoute.name,
                    arguments: restaurant.id,
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
