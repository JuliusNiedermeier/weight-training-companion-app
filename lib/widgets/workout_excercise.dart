import 'package:atlas_flutter/widgets/set_editor.dart';
import 'package:atlas_flutter/widgets/set_type_select.dart';
import 'package:atlas_flutter/widgets/workout_set_row.dart';
import 'package:flutter/material.dart';

const List<WorkoutSet> sets = [
  WorkoutSet(
    type: WorkoutSetType.warmup,
    weight: 5,
    reps: 20,
    rpe: 6,
    rest: Duration(seconds: 30),
  ),
  WorkoutSet(
    type: WorkoutSetType.normal,
    weight: 46.5,
    reps: 6,
    rpe: 9,
    rest: Duration(minutes: 2, seconds: 30),
  ),
  WorkoutSet(
    type: WorkoutSetType.normal,
    weight: 46.5,
    reps: 6,
    rpe: 9,
    rest: Duration(minutes: 2, seconds: 30),
  ),
  WorkoutSet(
    type: WorkoutSetType.normal,
    weight: 46.5,
    reps: 6,
    rpe: 9,
    rest: Duration(minutes: 1, seconds: 15),
  ),
];

void showModal(BuildContext context) {
  showModalBottomSheet(
    context: context,
    clipBehavior: Clip.hardEdge,
    backgroundColor: Colors.transparent,
    elevation: 0,
    enableDrag: false,
    isScrollControlled: true,
    builder: (context) => const SetTypeSelect(),
  );
}

class WorkoutExcercise extends StatelessWidget {
  const WorkoutExcercise({super.key});

  final double rowHeight = 50;

  final List<int> rows = const [1, 2, 3, 4];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
            padding: const EdgeInsets.only(
                top: 32, left: 16.0, right: 16.0, bottom: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Bench press",
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.more_vert),
                    )
                  ],
                ),
                Text("Notes..."),
              ],
            )),
        Column(
          children: [
            Container(
              height: 50,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  WorkoutExcerciseSetTableCell(
                    innerWidth: 60,
                    onPressed: () => showSetEditorModal(context),
                    child: Text(
                      "Set",
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                  ),
                  WorkoutExcerciseSetTableCell(
                    innerWidth: 60,
                    onPressed: () => showSetEditorModal(context),
                    child: Text(
                      "KG",
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                  ),
                  WorkoutExcerciseSetTableCell(
                    innerWidth: 70,
                    onPressed: () => showSetEditorModal(context),
                    child: Text(
                      "Reps",
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                  ),
                  WorkoutExcerciseSetTableCell(
                    innerWidth: 60,
                    onPressed: () => showSetEditorModal(context),
                    child: Text(
                      "RPE",
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                  ),
                ],
              ),
            ),
            ...sets.map(
              (set) => WorkoutSetRow(set: set),
            ),
          ],
        ),
      ],
    );
  }
}

class WorkoutExcerciseSetTableCell extends StatelessWidget {
  final double innerWidth;
  final Widget? child;
  final VoidCallback? onPressed;

  const WorkoutExcerciseSetTableCell({
    super.key,
    required this.innerWidth,
    this.onPressed,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onPressed,
      child: Container(
        alignment: Alignment.center,
        width: innerWidth,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: child,
      ),
    );
  }
}

class WorkoutExcerciseSetTableRow extends StatelessWidget {
  const WorkoutExcerciseSetTableRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
