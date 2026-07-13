/// Implemented internally by [AnimateX]'s state so an [AnimateXController]
/// can drive it from outside (a button press, a tap, an API callback...).
abstract class AnimateXBinding {
  void play();
  void reverse();
  void reset();
}

/// Optional controller for [AnimateX].
///
/// Create one, pass it to `AnimateX(controller: myController, ...)`, and
/// call [play], [reverse], or [reset] whenever you want — e.g. from a
/// button's `onPressed`, in response to a swipe, or after a network call
/// completes.
class AnimateXController {
  AnimateXBinding? _binding;

  void attach(AnimateXBinding binding) => _binding = binding;

  void detach(AnimateXBinding binding) {
    if (identical(_binding, binding)) {
      _binding = null;
    }
  }

  /// Plays the animation from the start (respecting any configured delay).
  void play() => _binding?.play();

  /// Plays the animation backwards from its current position.
  void reverse() => _binding?.reverse();

  /// Resets the animation to its initial (t = 0) state without playing.
  void reset() => _binding?.reset();
}
