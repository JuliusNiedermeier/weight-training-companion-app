import "package:flutter/material.dart";
import 'package:atlas_flutter/widgets/workout_excercise.dart';

class WorkoutScreen extends StatelessWidget {
  const WorkoutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Push day'),
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.check),
              onPressed: () {},
            ),
            IconButton(
              icon: const Icon(Icons.navigate_next),
              onPressed: () {},
            ),
          ],
        ),
        body: ListView(
          children: [
            WorkoutExcercise(),
            WorkoutExcercise(),
            WorkoutExcercise(),
            WorkoutExcercise(),
            WorkoutExcercise(),
            WorkoutExcercise(),
            WorkoutExcercise(),
            WorkoutExcercise(),
            WorkoutExcercise()
          ],
        ));
  }
}
