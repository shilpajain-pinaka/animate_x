import 'package:flutter/material.dart';

import 'animate_x_widget.dart';
import 'animation_x.dart';

/// A `ListView.builder` that animates each item in as it's built, with
/// each item's start delayed a little more than the one before it —
/// the classic "staggered list" effect. Works exactly like
/// `ListView.builder`, just add an [effect].
///
/// ```dart
/// AnimateXList(
///   itemCount: items.length,
///   effect: AnimationX.fadeInUp,
///   itemBuilder: (context, i) => ListTile(title: Text(items[i])),
/// )
/// ```
class AnimateXList extends StatelessWidget {
  final int itemCount;
  final IndexedWidgetBuilder itemBuilder;
  final AnimationX effect;
  final Duration itemDuration;
  final Duration staggerDelay;
  final Curve? curve;
  final Axis scrollDirection;
  final EdgeInsetsGeometry? padding;
  final ScrollController? controller;
  final bool shrinkWrap;
  final ScrollPhysics? physics;

  const AnimateXList({
    super.key,
    required this.itemCount,
    required this.itemBuilder,
    this.effect = AnimationX.fadeInUp,
    this.itemDuration = const Duration(milliseconds: 500),
    this.staggerDelay = const Duration(milliseconds: 80),
    this.curve,
    this.scrollDirection = Axis.vertical,
    this.padding,
    this.controller,
    this.shrinkWrap = false,
    this.physics,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: scrollDirection,
      padding: padding,
      controller: controller,
      shrinkWrap: shrinkWrap,
      physics: physics,
      itemCount: itemCount,
      itemBuilder: (context, index) {
        return AnimateX(
          key: ValueKey(index),
          effect: effect,
          duration: itemDuration,
          delay: staggerDelay * index,
          curve: curve,
          child: itemBuilder(context, index),
        );
      },
    );
  }
}

/// Stagger-animate an already-built list of widgets — useful inside a
/// [Column], a [GridView.count], a [Wrap], etc. where you're not using
/// a builder.
///
/// ```dart
/// Column(children: [tile1, tile2, tile3].animateStagger())
/// ```
extension AnimateXStagger on List<Widget> {
  List<Widget> animateStagger({
    AnimationX effect = AnimationX.fadeInUp,
    Duration itemDuration = const Duration(milliseconds: 500),
    Duration staggerDelay = const Duration(milliseconds: 80),
    Curve? curve,
  }) {
    return [
      for (int i = 0; i < length; i++)
        AnimateX(
          key: ValueKey(i),
          effect: effect,
          duration: itemDuration,
          delay: staggerDelay * i,
          curve: curve,
          child: this[i],
        ),
    ];
  }
}
