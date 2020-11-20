import 'package:cafe_app/common/enum.dart';
import 'package:cafe_app/model/customer_reviews.dart';
import 'package:cafe_app/model/restaurant_detail.dart';
import 'package:flutter/material.dart';

import 'api_service.dart';

class RestaurantDetailProvider extends ChangeNotifier {
  final ApiService apiService;

  RestaurantDetailProvider({
    @required this.apiService,
  });

  RestaurantDetail _restaurant;
  String _message = '';
  ResultState _state;
  List<CustomerReviews> _customerReviews;

  RestaurantDetail get restaurant => _restaurant;

  String get message => _message;

  ResultState get state => _state;

  List<CustomerReviews> get customerReviews => _customerReviews;

  Future<dynamic> fetchRestaurantDetail(String id) async {
    try {
      _state = ResultState.Loading;
      notifyListeners();
      final result = await apiService.getDetailRestaurant(id);
      print(result);
      if (result.error) {
        _state = ResultState.NoData;
        notifyListeners();
        return _message = result.message;
      } else {
        _state = ResultState.HasData;
        _customerReviews = result.restaurant.customerReviews;
        notifyListeners();
        return _restaurant = result.restaurant;
      }
    } catch (e) {
      _state = ResultState.Error;
      notifyListeners();
      return _message = 'Errors -> $e';
    }
  }

  updateCostumerReviews(List<CustomerReviews> customerReviews) {
    _customerReviews = customerReviews;
    notifyListeners();
  }
}
