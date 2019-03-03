import 'package:flutter/material.dart';
import 'package:flutter_app/animated_state.dart';
import 'package:flutter_app/data/liker.dart';
import 'package:flutter_app/screen/food_page.dart';
import 'package:flutter_app/tile/fav_tile_icon.dart';
import 'package:flutter_app/model/food.dart';

class FoodTile extends StatefulWidget {
  final Food food;

  const FoodTile({
    Key key,
    @required this.food,
  })
      : assert(food != null),
        super(key: key);

  @override
  State<StatefulWidget> createState() {
    return FoodTileState();
  }
}

class FoodTileState extends AnimatedState<FoodTile> {

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).pushNamed(FoodPage.routeName);
      },
      child: Column(
        children: <Widget>[
          GestureDetector(
            onDoubleTap: () {
              changeLike();
            },
            child: Image.asset(widget.food.picture),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(widget.food.name),
                StreamBuilder<int>(
                    stream: Liker
                        .of(context)
                        .likesCounter
                        .likesCountStream
                        .distinct(),
                    builder: (context, snapshot) {
                      return FavTileIcon(
                          liked: widget.food.liked,
                          onPressed: () {
                            changeLike();
                            },
                      );
                    })
              ],
            ),
          )
        ],
      ),
    );
  }

  void changeLike() async {
    Liker
        .of(context)
        .likesCounter
        .changeLike(widget.food);
    String text = widget.food.liked
        ? "${widget.food.name} liked! :D"
        : "${widget.food.name} disliked! :(";
    Scaffold.of(context).showSnackBar(SnackBar(
      content: Text(text),
      duration: Duration(milliseconds: 500),
    ));
  }

  @override
  void onAnimationStarted() {
    super.onAnimationStarted();
    print("animation started");
    setState(() {
      widget.food.liked = widget.food.liked;
    });
  }

  @override
  bool shouldAnimate(FoodTile oldWidget) {
//    return false;
    print("check new tile");
    return oldWidget.food.liked != widget.food.liked;
  }
}
