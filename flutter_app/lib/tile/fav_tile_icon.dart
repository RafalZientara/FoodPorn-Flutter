import 'package:flutter/material.dart';
import 'package:flutter_app/animated_state.dart';

class FavTileIcon extends StatefulWidget {
  final bool liked;
  final VoidCallback onPressed;

  FavTileIcon({
    Key key,
    this.onPressed,
    @required this.liked, void Function() onTap,
  })  : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _FavTileIconState();
  }
}

class _FavTileIconState extends AnimatedState<FavTileIcon> {

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
            child: ScaleTransition(
              scale: buildAnimate(),
              child: IconButton(
                onPressed: widget.onPressed,
                icon: Icon(
                  Icons.favorite,
                  color: widget.liked ? Colors.redAccent : Colors.grey,
                ),
              ),
            ),
          ),
      );
  }

  @override
  bool shouldAnimate(FavTileIcon oldWidget) {
    return oldWidget.liked != widget.liked;
  }
}
