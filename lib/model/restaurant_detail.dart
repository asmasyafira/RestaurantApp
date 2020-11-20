import 'package:cafe_app/model/common.dart';
import 'package:cafe_app/model/customer_reviews.dart';
import 'package:cafe_app/model/menus.dart';
import 'package:cafe_app/model/restaurant.dart';

class RestaurantDetail extends Restaurant {
  RestaurantDetail({
    id,
    name,
    description,
    city,
    pictureId,
    rating,
    this.address,
    this.categories,
    this.menus,
    this.customerReviews,
  }) : super(
            id: id,
            name: name,
            description: description,
            city: city,
            pictureId: pictureId,
            rating: rating);

  final String address;
  final List<CommonName> categories;
  final Menus menus;
  final List<CustomerReviews> customerReviews;

  factory RestaurantDetail.fromJson(Map<String, dynamic> json) {
    final restaurant = Restaurant.fromJson(json);
    return RestaurantDetail(
      id: restaurant.id,
      name: restaurant.name,
      description: restaurant.description,
      city: restaurant.city,
      address: json["address"],
      pictureId: restaurant.pictureId,
      categories: List<CommonName>.from(
          json["categories"].map((x) => CommonName.fromJson(x))),
      menus: Menus.fromJson(json["menus"]),
      rating: restaurant.rating,
      customerReviews: List<CustomerReviews>.from(
          json["customerReviews"].map((x) => CustomerReviews.fromJson(x))),
    );
  }
}
