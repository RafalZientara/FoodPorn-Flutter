import 'package:flutter/material.dart';

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

class _FavIconState extends State<FavIcon> {
  AnimationController _animationController;
  Animation<double> _animation;

  final Tween<Offset> _badgePositionTween = Tween(
    begin: const Offset(-0.5, 0.9),
    end: const Offset(0.0, 0.0),
  );

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Stack(
        overflow: Overflow.visible,
        children: <Widget>[
          Center(
            child: Icon(
              Icons.favorite,
              color: Colors.redAccent,
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
}
