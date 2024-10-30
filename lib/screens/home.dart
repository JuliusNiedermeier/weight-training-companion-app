import 'package:atlas_flutter/screens/workout.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool selected = false;
  double modalHeight = 0;

  void showModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return const Center(child: Text("Modal Bottom Sheet"));
      },
    ).then(
      (value) {
        setState(() {
          selected = false;
        });
      },
    );

    setState(() {
      selected = true;
    });
  }

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
      body: SingleChildScrollView(
        child: Container(
          height: 5000,
          child: PageView(
            children: [
              Container(
                color: Colors.purple.shade100,
                child: const Text("Page One"),
              ),
              Container(
                color: Colors.purple.shade200,
                child: const Text("Page Two"),
              ),
              Container(
                color: Colors.purple.shade300,
                child: const Text("Page Three"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
