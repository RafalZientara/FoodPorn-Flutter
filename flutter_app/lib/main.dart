import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_app/model/Food.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Food Porn App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Food Porn'),
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
  final feed = List<int>.generate(10000, (i) => i);

//  var feed = List<Food>();
  static const images = <String>[
    "assets/befsztyk.jpg",
    "assets/churros.jpg",
    "assets/fried-chicken.jpg",
    "assets/fries.jpg",
    "assets/hamburger.jpg",
    "assets/pizza.jpg",
  ];

  void loadFood() async {
    var input =
        DefaultAssetBundle.of(context).loadString("assets/data/data.json");
    final parsed = json.decode(await input).cast<Map<String, dynamic>>();
    var list =
        parsed.map<Food>((json) => Food.fromJson(json)).toList() as List<Food>;
    print("lol mam jedzenie $list");
    setState(() {
//      feed.add(Food("Pizza!", "Pie pie pie!"));
//      feed.add(Food("Pizza!", "Pie pie pie!"));
//      feed.add(Food("Pizza!", "Pie pie pie!"));
//      feed.clear();
//      feed.addAll(list);
//      feed = list;
    });
  }

  @override
  void initState() {
    super.initState();
    print("initState");
    loadFood();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: feed.length == 0 ? buildLoadingScreen() : buildListView());
  }

  ListView buildListView() {
    return ListView.builder(
      itemCount: feed.length,
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () async => {
//            Navigator.of(context).push(buildLoadingScreen())
              },
          child: Column(
            children: <Widget>[
              GestureDetector(
                onDoubleTap: () {
                  likeFood(index);
                },
                  child: Image.asset(images[index % images.length])),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
//                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Text("Food nr $index"),
//                  Text("Food nr " + feed[index].name),
                    IconButton(
                      icon: Icon(Icons.favorite),
                      color:
                          (index % 2 == 0) ? Colors.redAccent : Colors.blueGrey,
                      onPressed: () {likeFood(index);},
                    )
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }

  void likeFood(int index) {
    setState(() {
      feed[index]++;
    });
  }

  Widget buildLoadingScreen() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }
}
