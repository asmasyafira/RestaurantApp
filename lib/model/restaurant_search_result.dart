import 'package:cafe_app/model/restaurant.dart';

class RestaurantsSearchResult {
  RestaurantsSearchResult({
    this.error,
    this.founded,
    this.restaurants,
  });

  final bool error;
  final int founded;
  final List<Restaurant> restaurants;

  factory RestaurantsSearchResult.fromJson(Map<String, dynamic> json) => RestaurantsSearchResult(
    error: json["error"],
    founded: json["founded"],
    restaurants: List<Restaurant>.from(json["restaurants"].map((x) => Restaurant.fromJson(x)))
      ..sort((a, b) => a.name.compareTo(b.name)),
      );
}