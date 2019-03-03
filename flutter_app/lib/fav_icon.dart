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

class _FavIconState extends State<FavIcon> with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  Animation<double> _animation;

  final Tween<double> _badgePositionTween = Tween(
    begin: 0.7,
    end: 1.5,
  );

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );
    _animation =
        CurvedAnimation(parent: _animationController, curve: Curves.elasticOut);
    _animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Stack(
        overflow: Overflow.visible,
        children: <Widget>[
          Center(
            child: ScaleTransition(
              scale: _badgePositionTween.animate(_animation),
              child: Icon(
                Icons.favorite,
                color: Colors.redAccent,
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
  void didUpdateWidget(FavIcon oldWidget) {
    if (widget.itemCount != oldWidget.itemCount) {
      _animationController.reset();
      _animationController.forward();
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}
