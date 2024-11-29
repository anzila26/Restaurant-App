import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/data/api/api_services.dart';
import 'package:restaurant_app/main.dart';
import 'package:restaurant_app/provider/home/restaurant_list_provider.dart';
import 'package:restaurant_app/provider/main/index_nav_provider.dart';
import 'package:restaurant_app/provider/setting/theme_provider.dart';
import 'package:restaurant_app/screen/home/list_restaurant_screen.dart';
import 'package:restaurant_app/screen/splash/splash_screen.dart';

void main() {
  testWidgets('menguji alur aplikasi dari splash screen ke daftar restoran',
      (tester) async {
    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => ThemeProvider()),
          ChangeNotifierProvider(create: (_) => IndexNavProvider()),
          Provider(create: (_) => ApiServices()),
          ChangeNotifierProvider(
              create: (context) =>
                  RestaurantListProvider(context.read<ApiServices>())),
        ],
        child: const MyApp(),
      ),
    );

    //memastikan splash screen muncul
    expect(find.byType(SplashScreen), findsOneWidget);

    //menunggu beberapa detik sampai timer selesai
    await tester.pumpAndSettle(const Duration(seconds: 4));

    //memastikan halaman langsung menuju ke home
    expect(find.byType(ListRestaurantScreen), findsOneWidget);

    //memastikan bahwa daftar restoran muncul
    expect(find.byType(ListView), findsOneWidget);

    // Memastikan nama restoran muncul dalam daftar
    expect(find.text('Melting Pot'), findsOneWidget);
  });
}
