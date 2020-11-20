import 'package:cafe_app/api/api_service.dart';
import 'package:cafe_app/common/navigation.dart';
import 'package:cafe_app/ui/restaurant_detail_page.dart';
import 'package:cafe_app/widget/splashscreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'api/restaurant_detail_provider.dart';
import 'api/restaurant_provider.dart';
import 'common/style.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<RestaurantProvider>(
          create: (_) => RestaurantProvider(apiService: ApiService()),
        ),
        ChangeNotifierProvider<RestaurantDetailProvider>(
            create: (_) =>
                RestaurantDetailProvider(apiService: ApiService())),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
            brightness: Brightness.dark,
            primaryColor: primaryColor,
            accentColor: secondaryColor,
            textTheme: textTheme),
            navigatorKey: navigatorKey,
            initialRoute: SplashScreenPage.routeName,
        routes: {
          SplashScreenPage.routeName: (context) => SplashScreenPage(),
          RestaurantDetailPage.routeName: (context) => RestaurantDetailPage(
            id: ModalRoute.of(context).settings.arguments,
          )
        },
      ),
    );
  }
}
