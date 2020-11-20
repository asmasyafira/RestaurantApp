import 'package:cafe_app/common/navigation.dart';
import 'package:cafe_app/model/restaurant.dart';
import 'package:cafe_app/ui/restaurant_detail_page.dart';
import 'package:flutter/material.dart';

class RestaurantList extends StatelessWidget {
  final List<Restaurant> restaurants;

  RestaurantList({this.restaurants});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: restaurants.length,
        shrinkWrap: true,
        itemBuilder: (context, position) {
          final restaurant = restaurants[position];
          return ListTile(
            contentPadding:
                EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            leading: Container(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: Hero(
                  //dia punya banyak macam2 animasi
                  tag: restaurant.id,
                  child: FadeInImage(
                    placeholder: AssetImage('image/restaurant.png'),
                    image: NetworkImage(restaurant.pictureId),
                    height: 200,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              width: 60.0,
            ),
            title: Text(
              restaurant.name,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Icon(
                      Icons.location_city,
                      size: 14.0,
                    ),
                    SizedBox(
                      width: 5.0,
                    ),
                    Text(restaurant.city)
                  ],
                ),
                Row(
                  children: <Widget>[
                    Icon(
                      Icons.star,
                      size: 14.0,
                    ),
                    SizedBox(
                      width: 5.0,
                    ),
                    Text(restaurant.rating.toString())
                  ],
                ),
              ],
            ),
            onTap: (){
              Navigation.intentWithData(RestaurantDetailPage.routeName, restaurant.id.toString());
            },
          );
        });
  }
}
