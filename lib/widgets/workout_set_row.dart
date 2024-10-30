import 'package:flutter/services.dart';
import 'package:atlas_flutter/widgets/swipe_action.dart';
import 'package:flutter/material.dart';

enum WorkoutSetType { normal, warmup, superset, drop }

class WorkoutSet {
  const WorkoutSet({
    required this.type,
    required this.weight,
    required this.reps,
    required this.rpe,
    required this.rest,
  });

  final WorkoutSetType type;
  final double weight;
  final int reps;
  final double rpe;
  final Duration rest;
}

class WorkoutSetRow extends StatefulWidget {
  const WorkoutSetRow({
    super.key,
    required this.set,
  });

  final WorkoutSet set;

  @override
  State<WorkoutSetRow> createState() => _WorkoutSetRow();
}

class _WorkoutSetRow extends State<WorkoutSetRow> {
  bool interacting = false;
  bool complete = false;

  @override
  Widget build(BuildContext context) {
    TextStyle? cellTextStyle = complete
        ? Theme.of(context)
            .textTheme
            .titleMedium
            ?.copyWith(color: Colors.teal.shade100)
        : Theme.of(context).textTheme.titleMedium;
    Duration animationDuration = const Duration(milliseconds: 250);

    return SizedBox(
      height: 58,
      child: AnimatedPadding(
        duration: animationDuration,
        curve: Curves.ease,
        padding: interacting
            ? const EdgeInsets.symmetric(vertical: 8)
            : EdgeInsets.zero,
        child: SwipeAction(
          movementDuration: animationDuration,
          onInteractionStart: () => setState(() {
            interacting = true;
          }),
          onInteractionEnd: () => setState(() {
            interacting = false;
          }),
          start: ActionPane(
            threshold: 150,
            onThresholdPassed: (active) {
              HapticFeedback.vibrate();
              setState(() {
                complete = active;
              });
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Container(
                height: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.teal.shade800,
                  borderRadius: BorderRadius.circular(100),
                ),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Icon(
                        Icons.check,
                        color: Colors.teal.shade100,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 16),
                      child: Text(
                        "2:30",
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium
                            ?.copyWith(color: Colors.teal.shade200),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          end: ActionPane(
            threshold: 150,
            snap: true,
            onThresholdPassed: (active) {
              HapticFeedback.vibrate();
              setState(() {
                complete = active;
              });
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Text(
                "Remove",
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
          ),
          child: AnimatedContainer(
            duration: animationDuration,
            curve: Curves.ease,
            decoration: BoxDecoration(
              color: complete ? Colors.teal.shade800 : Colors.grey.shade100,
              borderRadius:
                  interacting ? BorderRadius.circular(100) : BorderRadius.zero,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                WorkoutExcerciseSetTableCell(
                  innerWidth: 60,
                  child: Text(
                    "50",
                    style: cellTextStyle,
                  ),
                ),
                WorkoutExcerciseSetTableCell(
                  innerWidth: 60,
                  child: Text(
                    "50",
                    style: cellTextStyle,
                  ),
                ),
                WorkoutExcerciseSetTableCell(
                  innerWidth: 70,
                  child: Text(
                    "50",
                    style: cellTextStyle,
                  ),
                ),
                WorkoutExcerciseSetTableCell(
                  innerWidth: 60,
                  child: Text(
                    "50",
                    style: cellTextStyle,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
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
