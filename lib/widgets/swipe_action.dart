import 'package:flutter/material.dart';

class ActionPane extends StatelessWidget {
  const ActionPane({
    super.key,
    required this.child,
    this.snap = false,
    this.threshold = 50,
    this.onSnap,
    this.onThresholdPassed,
  });

  final Widget child;
  final double? threshold;
  final bool? snap;
  final void Function()? onSnap;
  final void Function(bool active)? onThresholdPassed;

  @override
  Widget build(BuildContext context) {
    return child;
  }
}

class SwipeAction extends StatefulWidget {
  final Widget child;
  final ActionPane? start;
  final ActionPane? end;
  final Duration movementDuration;
  final void Function()? onInteractionStart;
  final void Function()? onInteractionEnd;

  const SwipeAction({
    super.key,
    required this.child,
    this.start,
    this.end,
    this.movementDuration = const Duration(milliseconds: 250),
    this.onInteractionStart,
    this.onInteractionEnd,
  });

  @override
  State<SwipeAction> createState() => _SwipeAction();
}

enum ThresholdState { start, end, none }

class _SwipeAction extends State<SwipeAction> {
  bool dragging = false;
  double xOffset = 0;

  GlobalKey startActionKey = GlobalKey();
  GlobalKey endActionKey = GlobalKey();

  ThresholdState thresholdPassed = ThresholdState.none;

  void onDragStart(DragStartDetails details) {
    setState(() {
      dragging = true;
    });

    widget.onInteractionStart?.call();
  }

  void onDragUpdate(DragUpdateDetails details) {
    setState(() {
      xOffset += details.delta.dx;

      if (xOffset > (widget.start?.threshold ?? double.infinity)) {
        if (thresholdPassed != ThresholdState.start) {
          widget.start?.onThresholdPassed?.call(true);
          thresholdPassed = ThresholdState.start;
        }
      } else if (xOffset < (widget.end?.threshold ?? double.infinity) * -1) {
        if (thresholdPassed != ThresholdState.end) {
          widget.end?.onThresholdPassed?.call(true);
          thresholdPassed = ThresholdState.end;
        }
      } else {
        if (thresholdPassed == ThresholdState.start) {
          widget.start?.onThresholdPassed?.call(false);
        } else if (thresholdPassed == ThresholdState.end) {
          widget.end?.onThresholdPassed?.call(false);
        }

        thresholdPassed = ThresholdState.none;
      }
    });
  }

  void onDragEnd(DragEndDetails details) {
    setState(() {
      dragging = false;

      if (thresholdPassed == ThresholdState.start) {
        widget.start?.onSnap?.call();

        if (widget.start?.snap == true) {
          xOffset = startActionKey.currentContext!.size!.width;
        } else {
          xOffset = 0;
          thresholdPassed = ThresholdState.none;
          widget.start?.onThresholdPassed?.call(false);
          widget.onInteractionEnd?.call();
        }
      } else if (thresholdPassed == ThresholdState.end) {
        widget.end?.onSnap?.call();

        if (widget.end?.snap == true) {
          xOffset = endActionKey.currentContext!.size!.width * -1;
        } else {
          xOffset = 0;
          thresholdPassed = ThresholdState.none;
          widget.start?.onThresholdPassed?.call(false);
          widget.onInteractionEnd?.call();
        }
      } else {
        xOffset = 0;
        widget.onInteractionEnd?.call();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragStart: onDragStart,
      onHorizontalDragUpdate: onDragUpdate,
      onHorizontalDragEnd: onDragEnd,
      // behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: dragging ? Duration.zero : widget.movementDuration,
        curve: Curves.ease,
        transform: Matrix4.translationValues(xOffset, 0, 0),
        child: Stack(
          alignment: Alignment.center,
          // fit: StackFit.expand,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                FractionalTranslation(
                  key: startActionKey,
                  translation: const Offset(-1, 0),
                  child: widget.start,
                ),
                FractionalTranslation(
                  key: endActionKey,
                  translation: const Offset(1, 0),
                  child: widget.end,
                ),
              ],
            ),
            widget.child,
          ],
        ),
      ),
    );
  }
}
