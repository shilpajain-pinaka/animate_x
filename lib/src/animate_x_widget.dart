import 'package:flutter/material.dart';

import 'animate_x_controller.dart';
import 'animate_x_effects.dart';
import 'animation_x.dart';

/// Wrap ANY widget in this and pass an [effect] name — that's the whole
/// SDK. Works with [Text], [Image], list items, cards, buttons, icons...
/// anything that's a [Widget].
///
/// ```dart
/// AnimateX(effect: AnimationX.fadeInUp, child: Text('Hello'))
/// AnimateX(effect: AnimationX.zoomIn, child: Image.network(url))
/// ```
class AnimateX extends StatefulWidget {
  /// The widget to animate. Can be literally anything: Text, Image,
  /// Icon, Container, a whole Card, a ListTile, etc.
  final Widget child;

  /// Which of the 58 built-in animations to play.
  final AnimationX effect;

  /// How long a single play of the animation takes.
  final Duration duration;

  /// How long to wait before the animation starts. Handy for staggering
  /// items in a list (see [AnimateXList] for that already built in).
  final Duration delay;

  /// Easing curve. If omitted, a curve appropriate for the chosen
  /// [effect] is picked automatically (e.g. bounceOut for bounce/jump
  /// effects).
  final Curve? curve;

  /// Whether the animation starts playing as soon as it's built. Set to
  /// false and drive it with a [controller] if you want to trigger it
  /// manually (e.g. on tap, or when data arrives).
  final bool autoPlay;

  /// Loop the animation forever.
  final bool repeat;

  /// When [repeat] is true, alternate forward/backward instead of
  /// restarting from zero each time (nice for pulse/heartbeat/shimmer).
  final bool reverseRepeat;

  /// Called every time a forward play completes.
  final VoidCallback? onComplete;

  /// Optional external controller — call `.play()`, `.reverse()`, or
  /// `.reset()` on it from anywhere (a button, a callback, etc).
  final AnimateXController? controller;

  /// How far/strong the effect travels, in logical pixels (used by
  /// slide/fade/shake/jump/wobble-style effects). Default 40.
  final double amplitude;

  /// Text used by [AnimationX.typewriter] if [child] isn't itself a
  /// [Text] widget (or if you want to override its string).
  final String? text;

  const AnimateX({
    super.key,
    required this.child,
    required this.effect,
    this.duration = const Duration(milliseconds: 600),
    this.delay = Duration.zero,
    this.curve,
    this.autoPlay = true,
    this.repeat = false,
    this.reverseRepeat = false,
    this.onComplete,
    this.controller,
    this.amplitude = 40,
    this.text,
  });

  @override
  State<AnimateX> createState() => _AnimateXState();
}

class _AnimateXState extends State<AnimateX>
    with SingleTickerProviderStateMixin
    implements AnimateXBinding {
  late final AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.duration);
    _animation = CurvedAnimation(
      parent: _controller,
      curve: widget.curve ?? _defaultCurve(widget.effect),
    );

    widget.controller?.attach(this);

    _controller.addStatusListener(_onStatusChanged);

    if (widget.autoPlay) {
      play();
    }
  }

  @override
  void didUpdateWidget(covariant AnimateX oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.controller != widget.controller) {
      oldWidget.controller?.detach(this);
      widget.controller?.attach(this);
    }
    if (oldWidget.duration != widget.duration) {
      _controller.duration = widget.duration;
    }
    if (oldWidget.curve != widget.curve || oldWidget.effect != widget.effect) {
      _animation = CurvedAnimation(
        parent: _controller,
        curve: widget.curve ?? _defaultCurve(widget.effect),
      );
    }
  }

  void _onStatusChanged(AnimationStatus status) {
    if (status == AnimationStatus.completed) {
      widget.onComplete?.call();
      if (widget.repeat) {
        if (widget.reverseRepeat) {
          _controller.reverse();
        } else {
          _controller.forward(from: 0);
        }
      }
    } else if (status == AnimationStatus.dismissed &&
        widget.repeat &&
        widget.reverseRepeat) {
      _controller.forward();
    }
  }

  @override
  Future<void> play() async {
    if (widget.delay > Duration.zero) {
      await Future.delayed(widget.delay);
    }
    if (mounted) _controller.forward(from: 0);
  }

  @override
  void reverse() => _controller.reverse();

  @override
  void reset() => _controller.reset();

  Curve _defaultCurve(AnimationX effect) {
    switch (effect) {
      case AnimationX.bounceIn:
      case AnimationX.bounceOut:
      case AnimationX.bounceInUp:
      case AnimationX.bounceInDown:
      case AnimationX.bounceInLeft:
      case AnimationX.bounceInRight:
      case AnimationX.jump:
      case AnimationX.jumpIn:
        return Curves.bounceOut;
      case AnimationX.elasticIn:
      case AnimationX.elasticOut:
        return Curves.elasticOut;
      case AnimationX.shake:
      case AnimationX.shakeX:
      case AnimationX.shakeY:
      case AnimationX.wobble:
      case AnimationX.swing:
      case AnimationX.tada:
      case AnimationX.jello:
      case AnimationX.rubberBand:
      case AnimationX.heartbeat:
      case AnimationX.pulse:
      case AnimationX.flash:
      case AnimationX.spin:
      case AnimationX.shimmer:
        return Curves.linear;
      default:
        return Curves.easeOutCubic;
    }
  }

  @override
  void dispose() {
    widget.controller?.detach(this);
    _controller.removeStatusListener(_onStatusChanged);
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return EffectBuilder.apply(
          effect: widget.effect,
          t: _animation.value,
          amplitude: widget.amplitude,
          text: widget.text,
          child: child!,
        );
      },
      child: widget.child,
    );
  }
}
