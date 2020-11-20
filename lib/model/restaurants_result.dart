import 'package:cafe_app/model/common.dart';
import 'package:cafe_app/model/restaurant.dart';

class RestaurantsResult extends CommonResult {
  RestaurantsResult({
    error,
    message,
    this.count,
    this.restaurants,
  }) : super(error: error, message: message);

  final int count;
  final List<Restaurant> restaurants;

  factory RestaurantsResult.fromJson(Map<String, dynamic> json) {
    final resultApi = CommonResult.fromJson(json);
    return RestaurantsResult(
        error: resultApi.error,
        message: resultApi.message,
        count: json["count"],
        restaurants: List<Restaurant>.from(
            json["restaurants"].map((x) => Restaurant.fromJson(x)))
          ..sort((a, b) => a.name.compareTo(b.name)),
    );
  }
}
