import 'package:atlas_flutter/screens/workout.dart';
import 'package:flutter/material.dart';

// Make Row and actions the same hight?
// expandHeight: true

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const WorkoutScreen(),
            ),
          );
        },
        label: const Text("Start workout"),
        icon: const Icon(Icons.play_arrow),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 100, vertical: 100),
        child: Container(
          // Only specify, if the row should not fill the parent. By default this should be undefined
          // If the parent of Stack() has no explicitly set width or height, the stack will shrink to the biggest stack item
          // Otherwise the stack grows to the specified parent height and width
          // height: 50,
          // width: 100,
          color: Colors.grey.shade100,
          child: Stack(
            alignment: Alignment.center,
            // Always make row and actions the same size. The biggest size gets used!
            // fit: StackFit.expand,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  FractionalTranslation(
                    translation: const Offset(-1, 0),
                    child: Container(
                      color: Colors.amber,
                      width: 50,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  FractionalTranslation(
                    translation: const Offset(1, 0),
                    child: Container(
                      color: Colors.amber,
                      width: 50,
                    ),
                  ),
                ],
              ),
              // Fill stack size
              Container(
                color: Colors.red.withOpacity(0.5),
                // height: 30,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
