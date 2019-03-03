
import 'package:flutter/material.dart';
import 'package:flutter_app/model/food.dart';

class FoodPage extends StatelessWidget {

  static const routeName = "/details";

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      children: <Widget>[
        Image.asset("assets/fried-chicken.jpg"),
        Image.asset("assets/fries.jpg"),
        Text("Blah blah blah"),
      ],
    );
  }


}
