import 'package:flutter/material.dart';
import 'package:flutter_app/animated_state.dart';

class FavIcon extends StatefulWidget {
  final int itemCount;

  FavIcon({
    Key key,
    @required this.itemCount,
  })  : assert(itemCount >= 0),
        super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _FavIconState();
  }
}

class _FavIconState extends AnimatedState<FavIcon> {

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Stack(
        overflow: Overflow.visible,
        children: <Widget>[
          Center(
            child: ScaleTransition(
              scale: buildAnimate(),
              child: Icon(
                Icons.favorite,
                color: widget.itemCount>0 ? Colors.redAccent : Colors.grey,
              ),
            ),
          ),
          Positioned(
            top: 0,
            right: 0,
            left: 0,
            bottom: 0,
            child: Align(
              alignment: Alignment(0, 0),
              child: Text(widget.itemCount.toString(),
                  textAlign: TextAlign.center,
                  style: new TextStyle(
                    fontSize: 10.0,
                  )),
            ),
          ),
        ],
      ),
    );
  }

  @override
  bool shouldAnimate(FavIcon oldWidget) {
    return oldWidget.itemCount != widget.itemCount;
  }
}
