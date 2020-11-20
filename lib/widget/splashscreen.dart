import 'package:cafe_app/common/style.dart';
import 'package:cafe_app/ui/list_restaurant_page.dart';
import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';

class SplashScreenPage extends StatelessWidget {
  static const routeName = '/splash_screen';

  @override
  Widget build(BuildContext context) {
    return SplashScreen(
      navigateAfterSeconds: RestaurantListPage(),
      seconds: 3,
      title: Text(
        'Cafe and Restaurant',
        style: TextStyle(
            fontWeight: FontWeight.bold, fontSize: 15, color: Colors.white),
      ),
      // image: Image.asset('image/restaurant.png'),
      photoSize: 50,
      loaderColor: secondaryColor,
      backgroundColor: primaryColor,
    );
  }
}
