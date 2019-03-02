import 'package:flutter/material.dart';
import 'package:flutter_app/data/liker.dart';
import 'package:flutter_app/model/food.dart';

class FoodTile extends StatefulWidget {
  final Food food;

//  final ValueChanged<dynamic> onTap;

  const FoodTile({
    Key key,
    @required this.food,
//    @required this.onTap,
  })  : assert(food != null),
//        assert(onTap != null),
        super(key: key);

  @override
  State<StatefulWidget> createState() {
    return FoodTileState();
  }
}

class FoodTileState extends State<FoodTile> {
  static const images = <String>[
    "assets/befsztyk.jpg",
    "assets/churros.jpg",
    "assets/fried-chicken.jpg",
    "assets/fries.jpg",
    "assets/hamburger.jpg",
    "assets/pizza.jpg",
  ];

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => {},
      child: Column(
        children: <Widget>[
          GestureDetector(
            onDoubleTap: () {
              likeFood();
            },
            child: Image.asset(images[widget.food.index % images.length]),
//            child: Image.network(widget.food.picture),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(widget.food.name),
                IconButton(
                  icon: Icon(Icons.favorite),
                  color:
                      (widget.food.liked) ? Colors.redAccent : Colors.blueGrey,
                  onPressed: () {
                    likeFood();
                  },
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  void likeFood() {
    setState(() {
      widget.food.liked = !widget.food.liked;
      Liker.of(context).likesCounter.addLike();
    });
  }
}
