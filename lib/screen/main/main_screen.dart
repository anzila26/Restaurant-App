import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/provider/main/index_nav_provider.dart';
import 'package:restaurant_app/screen/favorite/favorite_screen.dart';
import 'package:restaurant_app/screen/home/list_restaurant_screen.dart';
import 'package:restaurant_app/screen/search/search_screen.dart';
import 'package:restaurant_app/screen/setting/setting_screen.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<IndexNavProvider>(builder: (context, value, child) {
        return switch (value.indexBottomNavBar) {
          0 => const ListRestaurantScreen(),
          1 => const SearchScreen(),
          2 => const FavoriteScreen(),
          _ => const SettingScreen(),
        };
      }),
      bottomNavigationBar: BottomNavigationBar(
        //method watch u/ dapet state dari provider (nilai yang up to date)
        currentIndex: context.watch<IndexNavProvider>().indexBottomNavBar,
        onTap: (index) {
          //method read u/ manggil method setIndextBottomNavBar
          context.read<IndexNavProvider>().setIndexBottomNavBar = index;
        },
        backgroundColor: Colors.blue,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
            tooltip: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: "Search",
            tooltip: "Search",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: "Favorite",
            tooltip: "Favorite",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: "Setting",
            tooltip: "Setting",
          ),
        ],
      ),
    );
  }
}
