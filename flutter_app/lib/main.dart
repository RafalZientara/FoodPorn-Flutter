import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_app/data/liker.dart';
import 'package:flutter_app/data/likes_counter.dart';
import 'package:flutter_app/fav_icon.dart';
import 'package:flutter_app/model/food.dart';
import 'package:flutter_app/screen/fav_page.dart';
import 'package:flutter_app/screen/food_page.dart';
import 'package:flutter_app/tile/food_tile.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Liker(
      likesCounter: LikesCounter(),
      child: MaterialApp(
        title: 'Food Porn',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: MyHomePage(title: 'Food Porn Home'),
        routes: <String, WidgetBuilder>{
          FoodPage.routeName: (context) => FoodPage(),
          FavPage.routeName: (context) => FavPage(),
        },
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  static const images = <String>[
    "assets/befsztyk.jpg",
    "assets/churros.jpg",
    "assets/fried-chicken.jpg",
    "assets/fries.jpg",
    "assets/hamburger.jpg",
    "assets/pizza.jpg",
  ];

  void _addRandomFood() {
    Random random = new Random();
    var randomInt = random.nextInt(1500100900);
    var food = Food("id$randomInt", randomInt, "Name", "description", false,
        random.nextInt(5000), images[random.nextInt(images.length)]);
    Liker.of(context).likesCounter.addFood(food);
  }

  @override
  void initState() {
    super.initState();
    loadFood();
  }

  void loadFood() async {
    var input =
        DefaultAssetBundle.of(context).loadString("assets/data/data.json");
    final parsed = json.decode(await input).cast<Map<String, dynamic>>();
    var list =
        parsed.map<Food>((json) => Food.fromJson(json)).toList() as List<Food>;
    Liker.of(context).likesCounter.setFoods(list);
  }

  @override
  Widget build(BuildContext context) {
    var liker = Liker.of(context);
    return Scaffold(
      appBar: buildAppBar(liker),
      body: buildListView(),
      floatingActionButton: FloatingActionButton(
        onPressed: _addRandomFood,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }

  AppBar buildAppBar(Liker liker) {
    return AppBar(
        title: Container(
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
          Text('Food porn'),
          StreamBuilder<int>(
              initialData: 0,
              stream: liker.likesCounter.likesCountStream,
              builder: (context, snapshot) {
                return FavIcon(itemCount: snapshot.data,
                  onPressed: () {
                    Navigator.of(context).pushNamed(FavPage.routeName);
                  },);
              }),
        ])));
  }

  Widget buildListView() {
    return StreamBuilder<List<Food>>(
        initialData: [],
        stream: Liker.of(context).likesCounter.allFoodsStream,
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
