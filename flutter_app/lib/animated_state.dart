import 'package:flutter/material.dart';

abstract class AnimatedState<T extends StatefulWidget>
    extends State<T> with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  Animation<double> _animation;

  final Tween<double> _badgePositionTween = Tween(
    begin: 0.5,
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

  buildAnimate() => _badgePositionTween.animate(_animation);

  @override
  void didUpdateWidget(T oldWidget) {
    if (shouldAnimate(oldWidget)) {
      _animationController.reset();
      _animationController.forward();
      onAnimationStarted();
    }
    super.didUpdateWidget(oldWidget);
  }

  bool shouldAnimate(T oldWidget);

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void onAnimationStarted() {}
}
