# animate_x

One Flutter SDK, 58+ animations, any widget. Wrap anything — `Text`,
`Image`, a `ListTile`, a `Card`, a whole screen — in `AnimateX`, pass a
name, done.

```dart
AnimateX(effect: AnimationX.fadeInUp, child: Text('Hello world'))
AnimateX(effect: AnimationX.zoomIn, child: Image.network(url))
AnimateX(effect: AnimationX.bounceInDown, child: Icon(Icons.star))
```

## Install

Copy the `animate_x/` folder into your project (or publish it to your
own pub server / a private git repo), then in your app's `pubspec.yaml`:

```yaml
dependencies:
  animate_x:
    path: ../animate_x   # or: git: { url: ..., path: animate_x }
```

```dart
import 'package:animate_x/animate_x.dart';
```

## The core widget

```dart
AnimateX(
  effect: AnimationX.slideInLeft,   // required — pick from the list below
  duration: Duration(milliseconds: 600),
  delay: Duration.zero,
  curve: null,                      // auto-picked per effect if omitted
  autoPlay: true,
  repeat: false,
  reverseRepeat: false,
  amplitude: 40,                    // travel distance / shake strength in px
  onComplete: () {},
  controller: myAnimateXController, // optional, to replay/reverse/reset
  child: const Text('Hi'),
)
```

Works identically no matter what `child` is — that's the point. It's
one wrapper widget, not fifty separate ones.

## Replaying / triggering manually

```dart
final controller = AnimateXController();

AnimateX(
  controller: controller,
  effect: AnimationX.tada,
  autoPlay: false,
  child: const Icon(Icons.celebration),
)

// later, e.g. in a button's onPressed:
controller.play();
controller.reverse();
controller.reset();
```

## Animated lists

```dart
AnimateXList(
  itemCount: items.length,
  effect: AnimationX.fadeInUp,
  staggerDelay: Duration(milliseconds: 80),
  itemBuilder: (context, i) => ListTile(title: Text(items[i])),
)
```

Already have a list of widgets (e.g. inside a `Column`)? Use the
extension instead:

```dart
Column(children: [tile1, tile2, tile3].animateStagger(effect: AnimationX.slideInLeft))
```

## Swipe

```dart
SwipeX(
  direction: SwipeDirectionX.left,
  onSwiped: () => removeItem(item),
  child: ListTile(title: Text(item.name)),
)
```

## Drag and drop

```dart
DragDropX<String>(data: item.id, child: Chip(label: Text(item.name)))

DropZoneX<String>(
  onAccept: (id) => moveItem(id),
  builder: (context, isHovering) => Container(
    color: isHovering ? Colors.blue.shade100 : Colors.grey.shade200,
    child: const Text('Drop here'),
  ),
)
```

## All 58 animations (`AnimationX`)

**Fade**
`fadeIn` · `fadeOut` · `fadeInUp` · `fadeInDown` · `fadeInLeft` · `fadeInRight` · `fadeOutUp` · `fadeOutDown` · `fadeOutLeft` · `fadeOutRight`

**Slide**
`slideInUp` · `slideInDown` · `slideInLeft` · `slideInRight` · `slideOutUp` · `slideOutDown` · `slideOutLeft` · `slideOutRight`

**Scale / Zoom**
`scaleIn` · `scaleOut` · `zoomIn` · `zoomOut`

**Bounce**
`bounceIn` · `bounceOut` · `bounceInUp` · `bounceInDown` · `bounceInLeft` · `bounceInRight`

**Rotate / Flip**
`rotateIn` · `rotateOut` · `rotateInClockwise` · `rotateInCounterClockwise` · `flipInX` · `flipInY` · `flipOutX` · `flipOutY` · `spin`

**Jump**
`jump` · `jumpIn`

**Attention seekers**
`shake` · `shakeX` · `shakeY` · `wobble` · `swing` · `tada` · `jello` · `rubberBand` · `heartbeat` · `pulse` · `flash`

**Blur / Elastic**
`blurIn` · `blurOut` · `elasticIn` · `elasticOut`

**Combos**
`slideFadeUp` · `slideFadeDown`

**Text / decorative specials**
`typewriter` (reveals a `Text` character by character) · `shimmer` (moving highlight sweep, great for skeleton/loading states)

## Notes

- `typewriter` reads the string straight off a `Text` child automatically; pass `text:` explicitly if the child isn't a `Text`.
- `repeat: true` + `reverseRepeat: true` is the right combo for continuous effects like `pulse`, `heartbeat`, or `shimmer`.
- `amplitude` controls how far slide/fade/shake/jump/wobble effects travel — bump it up for a punchier feel.
- See `example/lib/main.dart` for a full demo covering text, images, a staggered list, swipe-to-dismiss, and drag & drop.
