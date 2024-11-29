import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:restaurant_app/screen/splash/splash_screen.dart';
import 'package:restaurant_app/static/navigation_route.dart';

void main() {
  late Widget widget;

  setUp(() {
    widget = MaterialApp(
      home: const SplashScreen(),
      routes: {
        NavigationRoute.spalashRoute.name: (context) => const SplashScreen(),
        NavigationRoute.mainRoute.name: (context) => const Placeholder(),
      },
    );
  });

  testWidgets('splash screen menampilkan logo', (tester) async {
    await tester.pumpWidget(widget);

    // memastikan widget selesai dibangun dengan menunggu beberapa detik
    await tester.pump(
        const Duration(seconds: 4)); // Mengatur waktu lebih lama (4 detik)

    final image = find.byType(Image);

    // memastikan ada widget image
    expect(image, findsOneWidget);
  });

  testWidgets('SplashScreen melakukan navigasi setelah 3 detik',
      (tester) async {
    await tester.pumpWidget(widget);

    // memastikan navigasi terjadi setelah 3 detik
    await tester.pump(const Duration(seconds: 3));

    // mengharapkan rute yang diarahkan adalah mainRoute
    expect(find.byType(Placeholder), findsOneWidget);
  });
}
