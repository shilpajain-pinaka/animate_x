# Changelog

All notable changes to **animate_x** are documented here.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## 1.0.0

First stable release.

### Added

- **`AnimateX`** — one wrapper widget that plays any of the built-in
  animations on *any* child (`Text`, `Image`, `Icon`, `Card`, `ListTile`,
  a whole screen — anything).
- **58+ animations via the `AnimationX` enum**, grouped as:
  - Fade — `fadeIn`, `fadeOut`, `fadeInUp/Down/Left/Right`, `fadeOutUp/Down/Left/Right`
  - Slide — `slideInUp/Down/Left/Right`, `slideOutUp/Down/Left/Right`
  - Scale / Zoom — `scaleIn`, `scaleOut`, `zoomIn`, `zoomOut`
  - Bounce — `bounceIn`, `bounceOut`, `bounceInUp/Down/Left/Right`
  - Rotate / Flip — `rotateIn`, `rotateOut`, `rotateInClockwise`,
    `rotateInCounterClockwise`, `flipInX/Y`, `flipOutX/Y`, `spin`
  - Jump — `jump`, `jumpIn`
  - Attention seekers — `shake`, `shakeX`, `shakeY`, `wobble`, `swing`,
    `tada`, `jello`, `rubberBand`, `heartbeat`, `pulse`, `flash`
  - Blur / Elastic — `blurIn`, `blurOut`, `elasticIn`, `elasticOut`
  - Combos — `slideFadeUp`, `slideFadeDown`
  - Specials — `typewriter` (character-by-character text reveal),
    `shimmer` (moving highlight sweep for skeleton/loading states)
- **`AnimateXController`** — drive any `AnimateX` from outside with
  `play()`, `reverse()`, and `reset()`.
- **`AnimateXList`** — a `ListView.builder` that staggers each item in as
  it's built.
- **`animateStagger()`** list extension — stagger an existing
  `List<Widget>` inside a `Column`, `Wrap`, `GridView`, etc.
- **`SwipeX`** — swipe-to-action wrapper with finger-following drag,
  snap-back, and a directional threshold.
- **`DragDropX` / `DropZoneX`** — drag-and-drop helpers with a scaled
  ghost, a dimmed placeholder, and hover feedback.
- Per-effect configuration: `duration`, `delay`, `curve` (auto-picked per
  effect when omitted), `autoPlay`, `repeat`, `reverseRepeat`,
  `amplitude`, and an `onComplete` callback.
- Runnable `example/` app demonstrating text, images, a looping icon, a
  staggered list, swipe-to-dismiss, and drag & drop.