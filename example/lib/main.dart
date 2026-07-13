import 'package:animate_x/animate_x.dart';
import 'package:flutter/material.dart';

void main() => runApp(const DemoApp());

class DemoApp extends StatelessWidget {
  const DemoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'animate_x demo',
      theme: ThemeData(colorSchemeSeed: Colors.indigo, useMaterial3: true),
      home: const DemoHome(),
    );
  }
}

class DemoHome extends StatefulWidget {
  const DemoHome({super.key});

  @override
  State<DemoHome> createState() => _DemoHomeState();
}

class _DemoHomeState extends State<DemoHome> {
  final _titleController = AnimateXController();
  final _iconController = AnimateXController();

  final _items = List.generate(6, (i) => 'List item ${i + 1}');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('animate_x')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // 1. Text animation, replayable via controller.
          AnimateX(
            controller: _titleController,
            effect: AnimationX.bounceInDown,
            duration: const Duration(milliseconds: 700),
            child: const Text(
              'Welcome!',
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
            ),
          ),
          TextButton(
            onPressed: _titleController.play,
            child: const Text('Replay title'),
          ),
          const SizedBox(height: 24),

          // 2. Typewriter text.
          AnimateX(
            effect: AnimationX.typewriter,
            duration: const Duration(milliseconds: 1500),
            child: const Text(
              'Text that types itself out, letter by letter.',
              style: TextStyle(fontSize: 16),
            ),
          ),
          const SizedBox(height: 24),

          // 3. Image animation.
          AnimateX(
            effect: AnimationX.zoomIn,
            duration: const Duration(milliseconds: 800),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.network(
                'https://picsum.photos/seed/animatex/600/300',
                height: 180,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 24),

          // 4. Icon with a looping attention-seeker effect + controller.
          Center(
            child: AnimateX(
              controller: _iconController,
              effect: AnimationX.heartbeat,
              duration: const Duration(milliseconds: 900),
              repeat: true,
              child: const Icon(Icons.favorite, color: Colors.red, size: 56),
            ),
          ),
          const SizedBox(height: 24),

          // 5. Staggered list — every item animates in, one after another.
          const Text('Staggered list', style: TextStyle(fontWeight: FontWeight.bold)),
          SizedBox(
            height: 260,
            child: AnimateXList(
              itemCount: _items.length,
              effect: AnimationX.slideInLeft,
              staggerDelay: const Duration(milliseconds: 90),
              itemBuilder: (context, i) => Card(
                child: ListTile(leading: const Icon(Icons.check_circle), title: Text(_items[i])),
              ),
            ),
          ),
          const SizedBox(height: 24),

          // 6. Swipe to dismiss.
          const Text('Swipe to remove', style: TextStyle(fontWeight: FontWeight.bold)),
          SwipeX(
            direction: SwipeDirectionX.left,
            onSwiped: () => ScaffoldMessenger.of(context)
                .showSnackBar(const SnackBar(content: Text('Swiped!'))),
            child: Card(
              color: Colors.orange.shade100,
              child: const Padding(
                padding: EdgeInsets.all(16),
                child: Text('Swipe me left'),
              ),
            ),
          ),
          const SizedBox(height: 24),

          // 7. Drag and drop.
          const Text('Drag and drop', style: TextStyle(fontWeight: FontWeight.bold)),
          Row(
            children: [
              DragDropX<String>(
                data: 'token',
                child: Container(
                  width: 64,
                  height: 64,
                  decoration: BoxDecoration(
                    color: Colors.indigo,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  alignment: Alignment.center,
                  child: const Text('Drag', style: TextStyle(color: Colors.white)),
                ),
              ),
              const SizedBox(width: 24),
              Expanded(
                child: DropZoneX<String>(
                  onAccept: (data) => ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text('Dropped: $data'))),
                  builder: (context, isHovering) => Container(
                    height: 64,
                    decoration: BoxDecoration(
                      color: isHovering ? Colors.green.shade100 : Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.grey),
                    ),
                    alignment: Alignment.center,
                    child: const Text('Drop zone'),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
