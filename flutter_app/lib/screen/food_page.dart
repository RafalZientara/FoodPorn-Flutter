import 'package:flutter/material.dart';
import 'package:flutter_app/data/liker.dart';
import 'package:flutter_app/model/food.dart';
import 'package:flutter_app/tile/fav_tile_icon.dart';

class FoodPage extends StatefulWidget {
  static const routeName = "/details";

  @override
  State<StatefulWidget> createState() {
    return _FoodPageState();
  }
}

class _FoodPageState extends State<FoodPage> {
  Food food;

  @override
  Widget build(BuildContext context) {
    food = Liker.of(context).likesCounter.currentFood;
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: _buildHeader,
        body: _buildContent(context),
      ),
    );
  }

  List<Widget> _buildHeader(BuildContext context, bool innerBoxIsScrolled) {
    return <Widget>[
      SliverAppBar(
        expandedHeight: 200.0,
        floating: false,
        pinned: true,
        flexibleSpace: FlexibleSpaceBar(
            centerTitle: true,
            background: Hero(
              tag: "${food.index}_picture",
              child: Image.asset(
                food.picture,
                fit: BoxFit.cover,
              ),
            )),
      ),
    ];
  }

  Center _buildContent(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  food.name,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                StreamBuilder<int>(
                    stream: Liker.of(context)
                        .likesCounter
                        .likesCountStream
                        .distinct(),
                    builder: (context, snapshot) {
                      return FavTileIcon(
                        liked: food.liked,
                        onPressed: () {
                          changeLike();
                        },
                      );
                    })
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("Calories: ${food.calories}",
                  style: TextStyle(fontWeight: FontWeight.bold)),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(food.description),
            ),
          ],
        ),
      ),
    );
  }

  void changeLike() {
    Liker.of(context).likesCounter.changeLike(food);
  }
}
