import 'dart:ui';

import 'package:flutter/material.dart';

void main() {
  runApp(const DraggableExampleApp());
}

class DraggableExampleApp extends StatelessWidget {
  const DraggableExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Draggable Sample')),
        body: const DraggableExample(),
      ),
    );
  }
}

class DraggableExample extends StatefulWidget {
  const DraggableExample({super.key});

  @override
  State<DraggableExample> createState() => _DraggableExampleState();
}

class _DraggableExampleState extends State<DraggableExample> {
  int acceptedData = 0;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Draggable<int>(
          // Data is the value this Draggable stores.
          data: 10,
          feedback: Container(
            height: 100,
            width: 100,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/burger.png'),
                fit: BoxFit.fill,
              ),
              shape: BoxShape.circle,
            ),
          ),
          childWhenDragging: Container(
            height: 100.0,
            width: 100.0,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/burger.png'),
                fit: BoxFit.fill,
              ),
              shape: BoxShape.circle,
            ),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
              child: Container(
                decoration: BoxDecoration(color: Colors.white.withOpacity(0.0)),
              ),
            ),
          ),
          child: Container(
            height: 100.0,
            width: 100.0,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/burger.png'),
                fit: BoxFit.fill,
              ),
              shape: BoxShape.circle,
            ),
          ),
        ),
        DragTarget<int>(
          builder: (
            BuildContext context,
            List<dynamic> accepted,
            List<dynamic> rejected,
          ) {
            return Container(
              height: 100.0,
              width: 100.0,
              color: Colors.cyan,
              child: Center(
                child: Text('Value is updated to: $acceptedData'),
              ),
            );
          },
          onAccept: (int data) {
            setState(() {
              acceptedData += data;
            });
          },
        ),
      ],
    );
  }
}
