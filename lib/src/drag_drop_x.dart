import 'package:flutter/material.dart';

/// Makes [child] draggable, with a scaled-up, semi-transparent "ghost"
/// that follows the finger/cursor, and a dimmed placeholder left behind
/// while dragging. Pair with [DropZoneX].
///
/// ```dart
/// DragDropX<String>(data: item.id, child: Chip(label: Text(item.name)))
/// ```
class DragDropX<T extends Object> extends StatelessWidget {
  final Widget child;
  final T data;
  final double feedbackScale;

  const DragDropX({
    super.key,
    required this.child,
    required this.data,
    this.feedbackScale = 1.1,
  });

  @override
  Widget build(BuildContext context) {
    return Draggable<T>(
      data: data,
      feedback: Material(
        color: Colors.transparent,
        child: Transform.scale(
          scale: feedbackScale,
          child: Opacity(opacity: 0.85, child: child),
        ),
      ),
      childWhenDragging: Opacity(opacity: 0.3, child: child),
      child: child,
    );
  }
}

/// A drop target that rebuilds with `isHovering = true` while a matching
/// [DragDropX] is dragged over it, and calls [onAccept] on drop.
///
/// ```dart
/// DropZoneX<String>(
///   onAccept: (id) => moveItem(id),
///   builder: (context, isHovering) => Container(
///     color: isHovering ? Colors.blue.shade100 : Colors.grey.shade200,
///     child: const Text('Drop here'),
///   ),
/// )
/// ```
class DropZoneX<T extends Object> extends StatelessWidget {
  final Widget Function(BuildContext context, bool isHovering) builder;
  final void Function(T data) onAccept;

  const DropZoneX({
    super.key,
    required this.builder,
    required this.onAccept,
  });

  @override
  Widget build(BuildContext context) {
    return DragTarget<T>(
      onAcceptWithDetails: (details) => onAccept(details.data),
      builder: (context, candidateData, rejectedData) {
        return builder(context, candidateData.isNotEmpty);
      },
    );
  }
}
