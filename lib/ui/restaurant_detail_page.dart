import 'package:cafe_app/api/api_service.dart';
import 'package:cafe_app/api/restaurant_detail_provider.dart';
import 'package:cafe_app/common/enum.dart';
import 'package:cafe_app/common/navigation.dart';
import 'package:cafe_app/common/style.dart';
import 'package:cafe_app/model/post_customer_review.dart';
import 'package:cafe_app/widget/menu_list.dart';
import 'package:cafe_app/widget/restaurant_review_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RestaurantDetailPage extends StatefulWidget {
  static const routeName = '/restaurant_detail';
  final String id;

  RestaurantDetailPage({this.id});

  @override
  _RestaurantDetailPageState createState() => _RestaurantDetailPageState();
}

class _RestaurantDetailPageState extends State<RestaurantDetailPage>
    with TickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> _animation;
  final _formKey = GlobalKey<FormState>();
  final _nameReviewer = TextEditingController();
  final _reviewReviewer = TextEditingController();

  _startAnimate() {
    _controller = AnimationController(
        duration: Duration(milliseconds: 1000), vsync: this);
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeIn);
    _controller.forward();
  }

  @override
  void dispose() {
    _nameReviewer.dispose();
    _reviewReviewer.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    Provider.of<RestaurantDetailProvider>(context, listen: false)
        .fetchRestaurantDetail(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<RestaurantDetailProvider>(
      builder: (context, state, _) {
        if (state.state == ResultState.Loading) {
          return Center(child: CircularProgressIndicator());
        } else if (state.state == ResultState.HasData) {
          _startAnimate();
          return FadeTransition(
            opacity: _animation,
            child: Scaffold(
              body: Container(
                child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      Stack(
                        children: <Widget>[
                          ClipRRect(
                            borderRadius: BorderRadius.vertical(
                                bottom: Radius.circular(20)),
                            child: Hero(
                              tag: state.restaurant.id,
                              child: FadeInImage(
                                height: 270,
                                width: MediaQuery.of(context).size.width,
                                image: NetworkImage(state.restaurant.pictureId),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          SafeArea(
                            child: Container(
                              margin: EdgeInsets.only(left: 16),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(25),
                                  border: Border.all(
                                      color: Colors.white, width: 2)),
                              child: CircleAvatar(
                                backgroundColor: Colors.blueGrey[800],
                                child: IconButton(
                                    icon: Icon(
                                      Icons.arrow_back,
                                      color: Colors.white,
                                    ),
                                    onPressed: () {
                                      Navigation.back();
                                    }),
                              ),
                            ),
                          )
                        ],
                      ),
                      Container(
                        padding: EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(bottom: 4),
                              child: Text(
                                state.restaurant.name,
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                            ),
                            Row(
                              children: <Widget>[
                                Icon(
                                  Icons.location_city,
                                  size: 16,
                                ),
                                SizedBox(width: 5),
                                Text(state.restaurant.city),
                                SizedBox(width: 5),
                                Icon(
                                  Icons.star_border,
                                  size: 16,
                                ),
                                SizedBox(width: 5),
                                Text(state.restaurant.rating.toString())
                              ],
                            ),
                            Row(
                              children: <Widget>[
                                Icon(
                                  Icons.location_on,
                                  size: 16,
                                ),
                                SizedBox(width: 5),
                                Text(state.restaurant.address),
                              ],
                            ),
                            Padding(
                              padding:
                              const EdgeInsets.only(top: 16, bottom: 4),
                              child: Text(
                                'Description',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                            ),
                            Text(
                              state.restaurant.description,
                              style: TextStyle(wordSpacing: 3),
                              textAlign: TextAlign.justify,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text('Categories :',
                                  style:
                                  TextStyle(fontWeight: FontWeight.bold)),
                            ),
                            Container(
                                height: 50,
                                child: MenuList(
                                    menus: state.restaurant.categories)),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text('Foods menus :',
                                  style:
                                  TextStyle(fontWeight: FontWeight.bold)),
                            ),
                            Container(
                                height: 50,
                                child: MenuList(
                                    menus: state.restaurant.menus.foods)),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'Drinks menus :',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            Container(
                                height: 50,
                                child: MenuList(
                                    menus: state.restaurant.menus.drinks)),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'Customer reviews :',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            Container(
                                height: 65,
                                child: RestaurantReviewList(
                                  customerReviews:
                                  state.customerReviews,
                                )),
                            Padding(
                              padding: const EdgeInsets.only(
                                top: 8.0,
                                right: 8.0,
                                left: 8.0,
                              ),
                              child: Text(
                                'Post reviews :',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Form(
                                key: _formKey,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    TextFormField(
                                      controller: _nameReviewer,
                                      decoration: InputDecoration(
                                        labelText: 'Your name..',
                                      ),
                                      validator: (value) {
                                        if (value.length < 5) {
                                          return 'Please enter some text, min 5';
                                        }
                                        return null;
                                      },
                                    ),
                                    TextFormField(
                                      controller: _reviewReviewer,
                                      decoration: InputDecoration(
                                        labelText: 'Your review..',
                                      ),
                                      validator: (value) {
                                        if (value.length < 10) {
                                          return 'Please enter some text, min 10';
                                        }
                                        return null;
                                      },
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 16.0),
                                      child: RaisedButton(
                                        color: secondaryColor,
                                        onPressed: () async {
                                          // Validate returns true if the form is valid, or false
                                          // otherwise.
                                          if (_formKey.currentState.validate()){
                                            final body = PostCustomerReview(
                                                id: state.restaurant.id,
                                                name: _nameReviewer.text,
                                                review: _reviewReviewer.text);
                                            final customerReview = await ApiService().postReview(body);
                                            state.updateCostumerReviews(customerReview);
                                            _nameReviewer.clear();
                                            _reviewReviewer.clear();
                                          }
                                        },
                                        child: Text('Submit'),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        } else if (state.state == ResultState.NoData ||
            state.state == ResultState.Error) {
          return Center(child: Text(state.message));
        } else {
          return Center(child: Text(''));
        }
      },
    );
  }
}
