import 'package:cafe_app/model/common.dart';
import 'package:flutter/material.dart';

class MenuList extends StatelessWidget {
  final List<CommonName> menus;

  MenuList({this.menus});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: this.menus.length,
        itemBuilder: (context, position) {
          final menu = this.menus[position];
          return Card(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Center(
                child: Text(
                  menu.name,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          );
        });
  }
}
