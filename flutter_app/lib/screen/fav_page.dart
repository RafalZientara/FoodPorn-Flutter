import 'package:flutter/material.dart';
import 'package:flutter_app/data/liker.dart';
import 'package:flutter_app/model/food.dart';
import 'package:flutter_app/tile/fav_tile_icon.dart';
import 'package:flutter_app/tile/food_tile.dart';

class FavPage extends StatefulWidget {
  static const routeName = "/favorites";

  @override
  State<StatefulWidget> createState() {
    return _FavPageState();
  }
}

class _FavPageState extends State<FavPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildListView(),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
        title: Container(
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text('Favorites'),
                ])));
  }

  Widget _buildListView() {
    return StreamBuilder<List<Food>>(
        initialData: [],
        stream: Liker.of(context).likesCounter.favoritesStream,
        builder: (context, snapshot) {
          return ListView.builder(
            itemCount: snapshot.data.length,
            itemBuilder: (context, index) {
              return FoodTile(
                food: snapshot.data[index],
              );
            },
          );
        });
  }

}
