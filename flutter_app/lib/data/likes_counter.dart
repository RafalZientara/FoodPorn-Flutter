import 'dart:async';

import 'package:flutter_app/model/food.dart';
import 'package:rxdart/rxdart.dart';

class LikesCounter {
  Food currentFood;
  final _allFoods = List<Food>();
  final _favFoods = List<Food>();

  final _allItemsSubject = BehaviorSubject<List<Food>>();
  final _favItemsSubject = BehaviorSubject<List<Food>>();
  final _likesBehaviorSubject = BehaviorSubject<int>();
  final _likesController = StreamController<Food>();

  Stream<int> get likesCountStream => _likesBehaviorSubject.stream;

  Sink<Food> get likeAdditionSink => _likesController.sink;

  ValueObservable<List<Food>> get favoritesStream => _favItemsSubject.stream;

  ValueObservable<List<Food>> get allFoodsStream => _allItemsSubject.stream;

  LikesCounter() {
    _likesController.stream.listen(changeLike);
    _allItemsSubject.add(_allFoods);
    _favItemsSubject.add(_favFoods);
    _likesBehaviorSubject.add(_favFoods.length);
  }

  void dispose() {
    _allItemsSubject.close();
    _likesBehaviorSubject.close();
    _likesController.close();
  }

  void changeLike(Food food) {
    if (!food.liked) {
      food.liked = true;
      _favFoods.add(food);
    } else {
      food.liked = false;
      _favFoods.remove(food);
    }
    _favItemsSubject.add(_favFoods);
    _likesBehaviorSubject.add(_favFoods.length);
  }

  void setFoods(List<Food> foods) {
    _allFoods.clear();
    _allFoods.addAll(foods);
    _allItemsSubject.add(_allFoods);
  }

  void addFood(Food food) {
    _allFoods.insert(0, food);
    _allItemsSubject.add(_allFoods);
  }
}
