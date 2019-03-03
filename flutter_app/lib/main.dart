import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_app/data/liker.dart';
import 'package:flutter_app/data/likes_counter.dart';
import 'package:flutter_app/food_tile.dart';
import 'package:flutter_app/model/food.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Liker(
      likesCounter: LikesCounter(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: MyHomePage(title: 'Flutter Demo Home Page'),
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
  void _addRandomFood() {
    var food = Food("id", 5, "name", "description", false, 1500, "picture");
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
          Row(
            children: <Widget>[
              Icon(
                Icons.favorite,
                color: Colors.redAccent,
              ),
              StreamBuilder<int>(
                  initialData: 0,
                  stream: liker.likesCounter.likesCountStream,
                  builder: (context, snapshot) {
                    return Text(snapshot.data.toString());
                  }),
            ],
          )
        ],
      )),
    );
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
