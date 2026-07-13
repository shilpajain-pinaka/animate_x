/// Every animation the SDK knows how to play.
///
/// Pass any of these to [AnimateX]'s `effect` parameter and it will be
/// applied to whatever `child` you give it — [Text], [Image], a
/// [ListTile], a whole [Card], anything.
enum AnimationX {
  // --- Fade ---------------------------------------------------------
  fadeIn,
  fadeOut,
  fadeInUp,
  fadeInDown,
  fadeInLeft,
  fadeInRight,
  fadeOutUp,
  fadeOutDown,
  fadeOutLeft,
  fadeOutRight,

  // --- Slide ----------------------------------------------------------
  slideInUp,
  slideInDown,
  slideInLeft,
  slideInRight,
  slideOutUp,
  slideOutDown,
  slideOutLeft,
  slideOutRight,

  // --- Scale / Zoom ---------------------------------------------------
  scaleIn,
  scaleOut,
  zoomIn,
  zoomOut,

  // --- Bounce ----------------------------------------------------------
  bounceIn,
  bounceOut,
  bounceInUp,
  bounceInDown,
  bounceInLeft,
  bounceInRight,

  // --- Rotate / Flip ---------------------------------------------------
  rotateIn,
  rotateOut,
  rotateInClockwise,
  rotateInCounterClockwise,
  flipInX,
  flipInY,
  flipOutX,
  flipOutY,
  spin,

  // --- Jump --------------------------------------------------------------
  jump,
  jumpIn,

  // --- Attention seekers ---------------------------------------------
  shake,
  shakeX,
  shakeY,
  wobble,
  swing,
  tada,
  jello,
  rubberBand,
  heartbeat,
  pulse,
  flash,

  // --- Blur / elastic --------------------------------------------------
  blurIn,
  blurOut,
  elasticIn,
  elasticOut,

  // --- Combos ------------------------------------------------------------
  slideFadeUp,
  slideFadeDown,

  // --- Text / decorative specials ---------------------------------------
  typewriter,
  shimmer,
}
