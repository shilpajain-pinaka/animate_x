import 'dart:math' as math;
import 'dart:ui' as ui;

import 'package:flutter/material.dart';

import 'animation_x.dart';

/// Turns an [AnimationX] value + a progress value `t` (0..1) into a
/// transformed widget. This is the engine behind [AnimateX] — every one
/// of the 58 effects boils down to a combination of opacity, translation,
/// scale, rotation, skew, and blur, computed here.
class EffectBuilder {
  const EffectBuilder._();

  static Widget apply({
    required AnimationX effect,
    required double t,
    required Widget child,
    double amplitude = 40,
    String? text,
  }) {
    switch (effect) {
      // --- Fade ---------------------------------------------------
      case AnimationX.fadeIn:
        return _fx(child, opacity: t);
      case AnimationX.fadeOut:
        return _fx(child, opacity: 1 - t);
      case AnimationX.fadeInUp:
        return _fx(child, opacity: t, offset: Offset(0, amplitude * (1 - t)));
      case AnimationX.fadeInDown:
        return _fx(child, opacity: t, offset: Offset(0, -amplitude * (1 - t)));
      case AnimationX.fadeInLeft:
        return _fx(child, opacity: t, offset: Offset(amplitude * (1 - t), 0));
      case AnimationX.fadeInRight:
        return _fx(child, opacity: t, offset: Offset(-amplitude * (1 - t), 0));
      case AnimationX.fadeOutUp:
        return _fx(child, opacity: 1 - t, offset: Offset(0, -amplitude * t));
      case AnimationX.fadeOutDown:
        return _fx(child, opacity: 1 - t, offset: Offset(0, amplitude * t));
      case AnimationX.fadeOutLeft:
        return _fx(child, opacity: 1 - t, offset: Offset(-amplitude * t, 0));
      case AnimationX.fadeOutRight:
        return _fx(child, opacity: 1 - t, offset: Offset(amplitude * t, 0));

      // --- Slide ----------------------------------------------------
      case AnimationX.slideInUp:
        return _fx(child, offset: Offset(0, amplitude * 2 * (1 - t)));
      case AnimationX.slideInDown:
        return _fx(child, offset: Offset(0, -amplitude * 2 * (1 - t)));
      case AnimationX.slideInLeft:
        return _fx(child, offset: Offset(amplitude * 2 * (1 - t), 0));
      case AnimationX.slideInRight:
        return _fx(child, offset: Offset(-amplitude * 2 * (1 - t), 0));
      case AnimationX.slideOutUp:
        return _fx(child, offset: Offset(0, -amplitude * 2 * t));
      case AnimationX.slideOutDown:
        return _fx(child, offset: Offset(0, amplitude * 2 * t));
      case AnimationX.slideOutLeft:
        return _fx(child, offset: Offset(-amplitude * 2 * t, 0));
      case AnimationX.slideOutRight:
        return _fx(child, offset: Offset(amplitude * 2 * t, 0));

      // --- Scale / zoom -----------------------------------------------
      case AnimationX.scaleIn:
        return _fx(child, opacity: t, scale: t);
      case AnimationX.scaleOut:
        return _fx(child, opacity: 1 - t, scale: 1 - t);
      case AnimationX.zoomIn:
        return _fx(child, opacity: t, scale: 0.5 + 0.5 * t);
      case AnimationX.zoomOut:
        return _fx(child, opacity: 1 - t, scale: 1 + 0.5 * t);

      // --- Bounce ----------------------------------------------------
      case AnimationX.bounceIn:
        return _fx(child, opacity: t, scale: t);
      case AnimationX.bounceOut:
        return _fx(child, opacity: 1 - t, scale: 1 - t);
      case AnimationX.bounceInUp:
        return _fx(child, opacity: t, offset: Offset(0, amplitude * 2 * (1 - t)));
      case AnimationX.bounceInDown:
        return _fx(child, opacity: t, offset: Offset(0, -amplitude * 2 * (1 - t)));
      case AnimationX.bounceInLeft:
        return _fx(child, opacity: t, offset: Offset(amplitude * 2 * (1 - t), 0));
      case AnimationX.bounceInRight:
        return _fx(child, opacity: t, offset: Offset(-amplitude * 2 * (1 - t), 0));

      // --- Rotate / flip -----------------------------------------------
      case AnimationX.rotateIn:
        return _fx(child, opacity: t, rotation: (1 - t) * -math.pi);
      case AnimationX.rotateOut:
        return _fx(child, opacity: 1 - t, rotation: t * math.pi);
      case AnimationX.rotateInClockwise:
        return _fx(child, opacity: t, rotation: (1 - t) * -2 * math.pi);
      case AnimationX.rotateInCounterClockwise:
        return _fx(child, opacity: t, rotation: (1 - t) * 2 * math.pi);
      case AnimationX.flipInX:
        return _fx(child, opacity: t, rotationX: (1 - t) * math.pi / 2);
      case AnimationX.flipInY:
        return _fx(child, opacity: t, rotationY: (1 - t) * math.pi / 2);
      case AnimationX.flipOutX:
        return _fx(child, opacity: 1 - t, rotationX: t * math.pi / 2);
      case AnimationX.flipOutY:
        return _fx(child, opacity: 1 - t, rotationY: t * math.pi / 2);
      case AnimationX.spin:
        return _fx(child, rotation: t * 2 * math.pi);

      // --- Jump -----------------------------------------------------
      case AnimationX.jump:
        return _fx(child, offset: Offset(0, -amplitude * math.sin(math.pi * t)));
      case AnimationX.jumpIn:
        return _fx(
          child,
          opacity: t,
          offset: Offset(0, -amplitude * math.sin(math.pi * t)),
        );

      // --- Attention seekers -------------------------------------------
      case AnimationX.shake:
      case AnimationX.shakeX:
        return _fx(child, offset: Offset(_wave(t, 6) * amplitude * 0.3, 0));
      case AnimationX.shakeY:
        return _fx(child, offset: Offset(0, _wave(t, 6) * amplitude * 0.3));
      case AnimationX.wobble:
        return _fx(
          child,
          offset: Offset(_wave(t, 4) * amplitude * 0.4, 0),
          rotation: _wave(t, 4) * 0.08,
        );
      case AnimationX.swing:
        return _fx(child, rotation: _wave(t, 3) * 0.25);
      case AnimationX.tada:
        return _fx(
          child,
          scale: 1 + (_envelope(t) * 0.2),
          rotation: _wave(t, 5) * 0.05,
        );
      case AnimationX.jello:
        return _skew(child, _wave(t, 4) * 0.15 * (1 - t));
      case AnimationX.rubberBand:
        return _rubberBand(child, t);
      case AnimationX.heartbeat:
        return _fx(child, scale: 1 + _heartbeat(t) * 0.25);
      case AnimationX.pulse:
        return _fx(child, scale: 1 + _envelope(t) * 0.15);
      case AnimationX.flash:
        return _fx(child, opacity: 0.3 + 0.7 * _wave(t, 4).abs());

      // --- Blur / elastic --------------------------------------------
      case AnimationX.blurIn:
        return _fx(child, opacity: t, blurSigma: (1 - t) * 8);
      case AnimationX.blurOut:
        return _fx(child, opacity: 1 - t, blurSigma: t * 8);
      case AnimationX.elasticIn:
        return _fx(child, opacity: t, scale: t);
      case AnimationX.elasticOut:
        return _fx(child, opacity: 1 - t, scale: 1 - t);

      // --- Combos ---------------------------------------------------
      case AnimationX.slideFadeUp:
        return _fx(child, opacity: t, offset: Offset(0, amplitude * 1.5 * (1 - t)));
      case AnimationX.slideFadeDown:
        return _fx(child, opacity: t, offset: Offset(0, -amplitude * 1.5 * (1 - t)));

      // --- Specials ---------------------------------------------------
      case AnimationX.typewriter:
        return _typewriter(child, t, text);
      case AnimationX.shimmer:
        return _shimmer(child, t);
    }
  }

  // ---------------------------------------------------------------------
  // Composers
  // ---------------------------------------------------------------------

  /// Applies opacity + translate + scale + rotation (+ optional 3D flip
  /// rotation and blur) to [child], in a sensible visual order.
  static Widget _fx(
    Widget child, {
    double opacity = 1,
    Offset offset = Offset.zero,
    double scale = 1,
    double rotation = 0,
    double rotationX = 0,
    double rotationY = 0,
    double blurSigma = 0,
  }) {
    Widget result = child;

    if (rotationX != 0 || rotationY != 0) {
      final matrix = Matrix4.identity()
        ..setEntry(3, 2, 0.001)
        ..rotateX(rotationX)
        ..rotateY(rotationY);
      result = Transform(alignment: Alignment.center, transform: matrix, child: result);
    }

    if (scale != 1) {
      result = Transform.scale(scale: scale, child: result);
    }

    if (rotation != 0) {
      result = Transform.rotate(angle: rotation, child: result);
    }

    if (offset != Offset.zero) {
      result = Transform.translate(offset: offset, child: result);
    }

    if (blurSigma > 0) {
      result = ImageFiltered(
        imageFilter: ui.ImageFilter.blur(sigmaX: blurSigma, sigmaY: blurSigma),
        child: result,
      );
    }

    if (opacity < 1) {
      result = Opacity(opacity: opacity.clamp(0.0, 1.0), child: result);
    }

    return result;
  }

  static Widget _skew(Widget child, double amount) {
    final matrix = Matrix4.identity()..setEntry(1, 0, amount);
    return Transform(alignment: Alignment.center, transform: matrix, child: child);
  }

  static Widget _rubberBand(Widget child, double t) {
    final wobble = math.sin(t * math.pi * 3) * (1 - t);
    final scaleX = 1 + wobble * 0.25;
    final scaleY = 1 - wobble * 0.25;
    return Transform(
      alignment: Alignment.center,
      transform: Matrix4.diagonal3Values(scaleX, scaleY, 1),
      child: child,
    );
  }

  static Widget _typewriter(Widget child, double t, String? text) {
    String source = text ?? '';
    TextStyle? style;
    TextAlign? align;

    if (source.isEmpty && child is Text) {
      source = child.data ?? '';
      style = child.style;
      align = child.textAlign;
    }

    if (source.isEmpty) {
      return Opacity(opacity: t, child: child);
    }

    final count = (source.length * t).round().clamp(0, source.length);
    return Text(source.substring(0, count), style: style, textAlign: align);
  }

  static Widget _shimmer(Widget child, double t) {
    return ShaderMask(
      blendMode: BlendMode.srcATop,
      shaderCallback: (bounds) {
        final dx = bounds.width * (t * 3 - 1);
        return LinearGradient(
          colors: const [Colors.transparent, Colors.white70, Colors.transparent],
          stops: const [0.35, 0.5, 0.65],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          transform: _SlideGradient(dx),
        ).createShader(bounds);
      },
      child: child,
    );
  }

  /// Decaying oscillation: starts big, settles to 0 by t = 1.
  static double _wave(double t, double cycles) {
    return math.sin(t * math.pi * cycles) * (1 - t);
  }

  /// Single hump: 0 -> 1 -> 0 across t.
  static double _envelope(double t) => math.sin(t * math.pi);

  /// Double-pulse envelope, used for the heartbeat effect.
  static double _heartbeat(double t) {
    return math.sin(t * 4 * math.pi).abs() * (1 - t);
  }
}

class _SlideGradient extends GradientTransform {
  final double dx;
  const _SlideGradient(this.dx);

  @override
  Matrix4? transform(Rect bounds, {TextDirection? textDirection}) {
    return Matrix4.translationValues(dx, 0, 0);
  }
}
