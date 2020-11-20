import 'package:cafe_app/model/common.dart';
import 'package:cafe_app/model/restaurant_detail.dart';

class RestaurantDetailResult extends CommonResult {
  RestaurantDetailResult({
    error,
    message,
    this.restaurant,
  }) : super(error: error, message: message);

  final RestaurantDetail restaurant;

  factory RestaurantDetailResult.fromJson(Map<String, dynamic> json) {
    final resultApi = CommonResult.fromJson(json);
      return RestaurantDetailResult(
        error: resultApi.error,
        message: resultApi.message,
        restaurant: RestaurantDetail.fromJson(json["restaurant"]),
      );}
}
