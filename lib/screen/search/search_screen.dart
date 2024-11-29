import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/provider/search/restaurant_search_provider.dart';
import 'package:restaurant_app/screen/home/restaurant_card_widget.dart';
import 'package:restaurant_app/static/restaurant_search_result_state.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  void _onSearch() {
    final query = _searchController.text.trim();
    if (query.isNotEmpty) {
      context.read<RestaurantSearchProvider>().fetchRestaurantSearch(query);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Search Restaurant"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Column(
          children: [
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: 'Search',
                hintText: 'Enter restaurant name or categories',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                suffixIcon: IconButton(
                  onPressed: _onSearch,
                  icon: const Icon(Icons.search),
                ),
              ),
              onSubmitted: (_) => _onSearch,
            ),
            const SizedBox.square(dimension: 16),
            Expanded(
              child: Consumer<RestaurantSearchProvider>(
                builder: (context, value, child) {
                  return switch (value.resultState) {
                    RestaurantSearchLoadingState() => const Center(
                        child: CircularProgressIndicator(),
                      ),
                    RestaurantSearchLoadedState(data: var restaurantList) =>
                      GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 8,
                          mainAxisSpacing: 8,
                          childAspectRatio: 0.8,
                        ),
                        itemCount: restaurantList.length,
                        itemBuilder: (context, index) {
                          final restaurant = restaurantList[index];

                          return RestaurantCard(
                            restaurant: restaurant,
                            onTap: () {
                              Navigator.pushNamed(
                                context,
                                '/detail',
                                arguments: restaurant.id,
                              );
                            },
                          );
                        },
                      ),
                    RestaurantSearchErrorState(error: var message) => Center(
                        child: Text(message),
                      ),
                    _ => const Center(
                        child: Text('Start searching for restaurants!'),
                      ),
                  };
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
