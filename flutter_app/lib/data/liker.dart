import 'package:flutter/material.dart';
import 'package:flutter_app/data/likes_counter.dart';

class Liker extends InheritedWidget {
  final LikesCounter likesCounter;

  Liker({
    Key key,
    @required this.likesCounter,
    @required Widget child,
  }) : super(key: key, child: child);

  @override
  bool updateShouldNotify(Liker oldWidget) {
    return oldWidget.likesCounter.likesCount != likesCounter.likesCount;
  }

  static Liker of(BuildContext context) =>
      context.inheritFromWidgetOfExactType(Liker);
}
