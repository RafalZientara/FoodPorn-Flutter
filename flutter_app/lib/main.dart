import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_app/food_tile.dart';
import 'package:flutter_app/model/food.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
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
  final foods = List<Food>();

  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
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
    setState(() {
      foods.clear();
      foods.addAll(list);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: buildListView(),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }

  AppBar buildAppBar() {
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
              Text(_counter.toString()),
            ],
          )
        ],
      )),
    );
  }

  ListView buildListView() {
    return ListView.builder(
      itemCount: foods.length,
      itemBuilder: (context, index) {
        return FoodTile(
          food: foods[index],
        );
      },
    );
  }

  void likeFood(int index) {
    setState(() {
      foods[index].liked = !foods[index].liked;
//      foods[index].liked = !foods[index].liked;
    });
  }
}
