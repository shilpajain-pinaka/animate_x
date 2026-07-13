import 'package:flutter/material.dart';

enum SwipeDirectionX { left, right, up, down }

/// Wraps [child] so the user can swipe it in a given direction. Drags
/// follow the finger and animate back if released early; if the drag
/// passes [threshold] in the right direction, [onSwiped] fires.
///
/// ```dart
/// SwipeX(
///   direction: SwipeDirectionX.left,
///   onSwiped: () => removeItem(item),
///   child: ListTile(title: Text(item.name)),
/// )
/// ```
class SwipeX extends StatefulWidget {
  final Widget child;
  final SwipeDirectionX direction;
  final VoidCallback? onSwiped;
  final double threshold;
  final Duration snapBackDuration;

  const SwipeX({
    super.key,
    required this.child,
    this.direction = SwipeDirectionX.left,
    this.onSwiped,
    this.threshold = 100,
    this.snapBackDuration = const Duration(milliseconds: 200),
  });

  @override
  State<SwipeX> createState() => _SwipeXState();
}

class _SwipeXState extends State<SwipeX> {
  Offset _drag = Offset.zero;

  Offset get _axisLock {
    switch (widget.direction) {
      case SwipeDirectionX.left:
      case SwipeDirectionX.right:
        return const Offset(1, 0);
      case SwipeDirectionX.up:
      case SwipeDirectionX.down:
        return const Offset(0, 1);
    }
  }

  bool _matchesDirection() {
    switch (widget.direction) {
      case SwipeDirectionX.left:
        return _drag.dx < 0;
      case SwipeDirectionX.right:
        return _drag.dx > 0;
      case SwipeDirectionX.up:
        return _drag.dy < 0;
      case SwipeDirectionX.down:
        return _drag.dy > 0;
    }
  }

  void _onPanUpdate(DragUpdateDetails details) {
    setState(() {
      _drag += Offset(
        details.delta.dx * _axisLock.dx,
        details.delta.dy * _axisLock.dy,
      );
    });
  }

  void _onPanEnd(DragEndDetails details) {
    final distance = _drag.dx.abs() + _drag.dy.abs();
    if (distance > widget.threshold && _matchesDirection()) {
      widget.onSwiped?.call();
    }
    setState(() => _drag = Offset.zero);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanUpdate: _onPanUpdate,
      onPanEnd: _onPanEnd,
      child: AnimatedContainer(
        duration: widget.snapBackDuration,
        curve: Curves.easeOut,
        transform: Matrix4.translationValues(_drag.dx, _drag.dy, 0),
        child: widget.child,
      ),
    );
  }
}
