import 'package:cafe_app/model/customer_reviews.dart';
import 'package:flutter/material.dart';

class RestaurantReviewList extends StatelessWidget {
  final List<CustomerReviews> customerReviews;

  RestaurantReviewList({this.customerReviews});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemCount:
        customerReviews.length,
        itemBuilder: (context, index) {
          final review = customerReviews[index];
          return Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("${review.name} at ${review.date}"),
                  Text(review.review),
                ],
              ),
            ),
          );
        });
  }
}