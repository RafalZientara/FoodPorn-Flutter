import 'package:flutter/material.dart';
import 'package:flutter_app/data/liker.dart';

class FoodPage extends StatelessWidget {
  static const routeName = "/details";

  @override
  Widget build(BuildContext context) {
    var food = Liker.of(context).likesCounter.currentFood;
    return Scaffold(
//        appBar: buildAppBar(liker),
        body:  Column(
          children: <Widget>[
            Image.asset(food.picture),
            Text("${food.name}"),
          ],
        ));
  }
}
