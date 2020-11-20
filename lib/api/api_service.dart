import 'dart:convert';
import 'package:cafe_app/model/customer_reviews.dart';
import 'package:cafe_app/model/post_customer_review.dart';
import 'package:cafe_app/model/post_customer_review_result.dart';
import 'package:cafe_app/model/restaurant_detail_result.dart';
import 'package:cafe_app/model/restaurant_search_result.dart';
import 'package:cafe_app/model/restaurants_result.dart';
import 'package:http/http.dart' as http;

class ApiService {
  final _baseUrl = "https://restaurant-api.dicoding.dev/";

  //ngefatch data list
  //list ..baseurl..+ /list
  //detail ..baseurl..+ detail/id
  //_getApi itu format utama buat semua endpointnya
  //ini di private karna yg pake cmn future detail ajdibawahnya
  Future<Map<String, dynamic>> _getApi(String endpoint) async {
    final response = await http.get(_baseUrl + endpoint);

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load data');
    }
  }

  // Future<Map<String, dynamic>> _postApi(String endpoint) async {} pake cara ini jg boleh
  //catch list resto
  //ini dipake sm kelas2 lain
  Future<RestaurantsResult> getListRestaurant() async {
    final json = await _getApi('list');
    return RestaurantsResult.fromJson(json);
  }

  Future<RestaurantDetailResult> getDetailRestaurant(String id) async {
    final urlExt = 'detail/$id'; //kyk gini dlu jg bisa
    final json = await _getApi('detail/$id');
    return RestaurantDetailResult.fromJson(json);
  }

  Future<RestaurantsSearchResult> getSearchRestaurant(String keyword) async {
    final json = await _getApi('search?q=$keyword');
    return RestaurantsSearchResult.fromJson(json);
  }

  Future<List<CustomerReviews>> postReview(PostCustomerReview body) async {
    final response = await http.post(
      _baseUrl + 'review',
      body: jsonEncode(body.toJson()),
      headers: {'Content-Type': 'application/json', 'X-Auth-Token': '12345'},
    );

    if (response.statusCode == 201) {
      final jsonResponse = json.decode(response.body);
      final result = PostCustomerReviewsResult.fromJson(jsonResponse);
      return result.customerReviews;
    } else {
      throw Exception('Failed to load data');
    }
  }
//baca data : decode
//ngambil data : encode
}
