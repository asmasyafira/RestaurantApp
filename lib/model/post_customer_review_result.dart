import 'package:cafe_app/model/common.dart';
import 'package:cafe_app/model/customer_reviews.dart';

class PostCustomerReviewsResult extends CommonResult {
  PostCustomerReviewsResult({
    error,
    message,
    this.customerReviews,
  }) : super(error: error, message: message);

  final List<CustomerReviews> customerReviews;

  factory PostCustomerReviewsResult.fromJson(Map<String, dynamic> json) {
    final resultApi = CommonResult.fromJson(json);
    return PostCustomerReviewsResult(
      error: resultApi.error,
      message: resultApi.message,
      customerReviews: List<CustomerReviews>.from(
          json["customerReviews"].map((x) => CustomerReviews.fromJson(x))),
    );
  }
}
