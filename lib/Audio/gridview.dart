import 'dart:math';
import 'package:flutter/material.dart';

class CardTurnExample extends StatefulWidget {
  const CardTurnExample({Key? key}) : super(key: key);

  @override
  _CardTurnExampleState createState() => _CardTurnExampleState();
}

class _CardTurnExampleState extends State<CardTurnExample> {
  /// [_index] temporarily holds the index that is tapped (set by [GestureDetector]).
  int? _index;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: GridView.builder(
          gridDelegate:
              SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                _index = index;

                /// Important to call setState(){} here

                setState(() {});
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TurnAnimation(
                  runAnimation: _index == index,
                  child: Container(
                    color: Colors.red,
                    child: Center(child: Text(index.toString())),
                  ),
                ),
              ),
            );
          }),
    );
  }
}

/// Animation is separated into its own class for clarity.
/// It also means this logic can also be reused easily in your app.
class TurnAnimation extends StatefulWidget {
  const TurnAnimation(
      {required this.child, required this.runAnimation, Key? key})
      : super(key: key);

  final Widget child;
  final bool runAnimation;

  @override
  _TurnAnimationState createState() => _TurnAnimationState();
}

class _TurnAnimationState extends State<TurnAnimation>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    _controller =
        AnimationController(duration: Duration(milliseconds: 500), vsync: this);
    super.initState();
  }

  /// Important to set the [Controller.forward] in it's own local method, so it only runs
  /// when the passed in boolean is true
  _runAnimation() {
    if (widget.runAnimation) {
      _controller.forward();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _runAnimation();
    return AnimatedBuilder(
      animation: _controller,
      builder: (_, child) => Transform(
        alignment: Alignment.center,
        transform: Matrix4.identity()
          ..setEntry(3, 2, 0.001)
          ..rotateY(_controller.value * pi),
        child: widget.child,
      ),
    );
  }
}
