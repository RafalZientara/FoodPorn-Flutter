import 'package:flutter/material.dart';
import 'package:flutter_app/data/liker.dart';
import 'package:flutter_app/model/food.dart';

class FoodTile extends StatefulWidget {
  final Food food;

  const FoodTile({
    Key key,
    @required this.food,
  })  : assert(food != null),
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
              changeLike();
            },
            child: Image.asset(images[widget.food.index % images.length]),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(widget.food.name),
                StreamBuilder<int>(
                  stream: Liker.of(context).likesCounter.likesCountStream,
                  builder: (context, snapshot) {
                    return IconButton(
                      icon: Icon(Icons.favorite),
                      color:
                          (widget.food.liked) ? Colors.redAccent : Colors.blueGrey,
                      onPressed: () {
                        changeLike();
                      },
                    );
                  }
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  void changeLike() async {
      Liker.of(context).likesCounter.changeLike(widget.food);
  }
}
