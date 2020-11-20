import 'package:cafe_app/model/common.dart';

class Menus {
  Menus({
    this.foods,
    this.drinks,
  });

  final List<CommonName> foods;
  final List<CommonName> drinks;

  factory Menus.fromJson(Map<String, dynamic> json) => Menus(
        foods:
            List<CommonName>.from(json["foods"].map((x) => CommonName.fromJson(x))),
        drinks: List<CommonName>.from(
            json["drinks"].map((x) => CommonName.fromJson(x))),
      );
}
