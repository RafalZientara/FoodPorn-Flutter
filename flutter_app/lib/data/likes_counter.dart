import 'dart:async';

import 'package:flutter_app/model/food.dart';
import 'package:rxdart/rxdart.dart';

class LikesCounter {
  final favoriteFoods = List<Food>();

  final items = BehaviorSubject<List<Food>>();
  final likesBehaviorSubject = BehaviorSubject<int>();
  final likesController = StreamController<Food>();

  Stream<int> get likesCount => likesBehaviorSubject.stream;

  Sink<Food> get likeAddition => likesController.sink;

  ValueObservable<List<Food>> get favorites => items.stream;

  LikesCounter() {
    likesController.stream.listen(changeLike);
  }

  void dispose() {
    items.close();
    likesBehaviorSubject.close();
    likesController.close();
  }

  void changeLike(Food food) {
    if (!food.liked) {
      food.liked = true;
      favoriteFoods.add(food);
    } else{
      food.liked = false;
      favoriteFoods.remove(food);
    }
    items.add(favoriteFoods);
    likesBehaviorSubject.add(favoriteFoods.length);
  }
}
