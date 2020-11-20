import 'package:cafe_app/api/restaurant_provider.dart';
import 'package:cafe_app/common/enum.dart';
import 'package:cafe_app/widget/restaurant_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_search_bar/flutter_search_bar.dart';
import 'package:provider/provider.dart';

class RestaurantListPage extends StatefulWidget {
  @override
  _RestaurantListPageState createState() => _RestaurantListPageState();
}

class _RestaurantListPageState extends State<RestaurantListPage>
    with TickerProviderStateMixin {
  SearchBar _searchBar;
  RestaurantProvider _rp;
  AnimationController _controller;
  Animation<double> _animation;

  _RestaurantListPageState() {
    _searchBar = SearchBar(
        inBar: true,
        hintText: 'Masukan nama restaurant',
        setState: setState,
        buildDefaultAppBar: _buildAppBar,
        onCleared: () => {this._rp.resetRestaurant()},
        onClosed: () => {this._rp.resetRestaurant()},
        onChanged: (keyword) => {this._rp.fetchRestaurantsSearch(keyword)},
        onSubmitted: (keyword) => {
          if (this._rp.state != ResultState.HasData)
            this._rp.resetRestaurant()
        });
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      title: Row(
        children: [
          Text(
            'F-Restaurants',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      ),
      actions: [
        IconButton(
            icon: Icon(
              Icons.refresh,
              color: Colors.white,
            ),
            onPressed: () {
              this._rp.resetRestaurant();
            }),
        _searchBar.getSearchAction(context)
      ],
    );
  }

  _startAnimate() {
    _controller = AnimationController(
        duration: Duration(milliseconds: 1000), vsync: this);
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeIn);
    _controller.forward();
  }
  @override
  void initState() {
    super.initState();
    Provider.of<RestaurantProvider>(context, listen: false).fetchRestaurants();
  }

  @override
  Widget build(BuildContext context) {
    this._rp = Provider.of<RestaurantProvider>(context);
    return Scaffold(
      appBar: _searchBar.build(context),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Consumer<RestaurantProvider>(
              builder: (context, state, _) {
                if (state.state == ResultState.Loading) {
                  return Center(
                      child: CircularProgressIndicator());
                } else if (state.state == ResultState.HasData) {
                  _startAnimate();
                  return FadeTransition(
                    opacity: _animation,
                    child: RestaurantList(
                      restaurants: state.restaurants,
                    ),
                  );
                } else if (state.state == ResultState.NoData ||
                    state.state == ResultState.Error) {
                  return Center(child: Text(state.message));
                } else {
                  return Center(child: Text(''));
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
