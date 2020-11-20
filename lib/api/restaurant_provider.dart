import 'package:cafe_app/api/api_service.dart';
import 'package:cafe_app/common/enum.dart';
import 'package:cafe_app/model/restaurant.dart';
import 'package:cafe_app/model/restaurant_search_result.dart';
import 'package:cafe_app/model/restaurants_result.dart';
import 'package:flutter/cupertino.dart';

class RestaurantProvider extends ChangeNotifier {
  final ApiService apiService;

  RestaurantProvider({this.apiService}) {
    fetchRestaurants();
  }

  List<Restaurant> _tempRestaurants;
  List<Restaurant> _restaurants;
  ResultState _tempState;
  String _message = '';
  ResultState _state;
  String _keyword;

  List<Restaurant> get restaurants => _restaurants;

  String get message => _message;

  ResultState get state => _state;

  Future<dynamic> _fetchProvider(FetchType type) async {
    final _tryAllRestaurant = () async {
      final result = await apiService.getListRestaurant();
      if (result.restaurants.isEmpty) {
        _state = ResultState.NoData;
        _tempState = _state;
        notifyListeners();
        return _message = "No Restaurant Data";
      } else {
        _state = ResultState.HasData;
        _tempState = _state;
        _tempRestaurants = result.restaurants;
        notifyListeners();
        return _restaurants = result.restaurants;
      }
    };

    final _trySearchRestaurant = () async {
      final result = await apiService.getSearchRestaurant(_keyword);
      if (result.founded == 0) {
        _state = ResultState.NoData;
        notifyListeners();
        return _message = '$_keyword not found';
      } else {
        _state = ResultState.HasData;
        notifyListeners();
        return _restaurants = result.restaurants;
      }
    };

    try {
      _state = ResultState.Loading;
      notifyListeners();
      switch (type) {
        case FetchType.AllRestaurant:
          _tryAllRestaurant();
          break;
        case FetchType.SearchRestaurant:
          _trySearchRestaurant();
          break;
        default:
          _tryAllRestaurant();
          break;
      }
    } catch (e) {
      _state = ResultState.Error;
      notifyListeners();
      return _message = 'Error -> $e';
    }
  }

  Future<RestaurantsSearchResult> fetchRestaurantsSearch(String keyword) async {
    _keyword = keyword;
    return await _fetchProvider(FetchType.SearchRestaurant);
  }

  Future<RestaurantsResult> fetchRestaurants() async {
    return await _fetchProvider(FetchType.AllRestaurant);
  }

  resetRestaurant() {
    if (_tempState == ResultState.HasData) _restaurants = _tempRestaurants;
    fetchRestaurants();
  }

}
