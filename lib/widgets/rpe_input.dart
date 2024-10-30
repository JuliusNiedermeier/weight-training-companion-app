import 'package:flutter/material.dart';

import 'package:flutter/services.dart';

class RPEInput extends StatefulWidget {
  const RPEInput({super.key});

  @override
  State<RPEInput> createState() => _RPEInputState();
}

class _RPEInputState extends State<RPEInput> {
  final List items = ["5", "6", "7", "8", "9", "10"];
  final stackKey = GlobalKey();

  double stackWidth = 0;

  int currentPrimaryIndex = 2;
  int currentSecondaryIndex = 0;

  List<Widget> buildChildren(
      int itemCount, Widget Function(int index) itemBuilder) {
    List<Widget> items = [];

    for (int i = 0; i < itemCount; i++) {
      items.add(itemBuilder(i));
    }

    return items;
  }

  int getIndexFromOffset({
    required double offset,
    required int itemCount,
    required double trackWidth,
  }) {
    return (offset / trackWidth * itemCount).ceil() - 1;
  }

  void handleDragUpdate(DragUpdateDetails details) {
    final stackWidth = stackKey.currentContext?.size?.width;
    if (stackWidth == null) return;
    setState(() {
      currentPrimaryIndex = getIndexFromOffset(
        offset: details.localPosition.dx,
        itemCount: items.length,
        trackWidth: stackWidth,
      );
    });
  }

  void handleLongPressStart(LongPressStartDetails details) {
    HapticFeedback.vibrate();
    final stackWidth = stackKey.currentContext?.size?.width;
    if (stackWidth == null) return;
    setState(() {
      currentSecondaryIndex = getIndexFromOffset(
        offset: details.localPosition.dx,
        itemCount: items.length,
        trackWidth: stackWidth,
      );
    });
  }

  void handleLongPressMoveUpdate(LongPressMoveUpdateDetails details) {
    final stackWidth = stackKey.currentContext?.size?.width;
    if (stackWidth == null) return;
    setState(() {
      currentSecondaryIndex = getIndexFromOffset(
        offset: details.localPosition.dx,
        itemCount: items.length,
        trackWidth: stackWidth,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragUpdate: handleDragUpdate,
      onLongPressStart: handleLongPressStart,
      onLongPressMoveUpdate: handleLongPressMoveUpdate,
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          color: Colors.grey.shade100,
          borderRadius: const BorderRadius.all(
            Radius.circular(100),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: LayoutBuilder(
            builder: (context, stackConstraints) {
              double pillWidth = stackConstraints.maxWidth / items.length;
              return Stack(
                key: stackKey,
                fit: StackFit.expand,
                children: [
                  AnimatedPositioned(
                    duration: const Duration(milliseconds: 100),
                    curve: Curves.ease,
                    top: 0,
                    bottom: 0,
                    left: currentSecondaryIndex * pillWidth,
                    width: pillWidth,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: Colors.green.shade100,
                      ),
                    ),
                  ),
                  AnimatedPositioned(
                    duration: const Duration(milliseconds: 100),
                    curve: Curves.ease,
                    top: 0,
                    bottom: 0,
                    left: currentPrimaryIndex * pillWidth,
                    width: pillWidth,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: Colors.black,
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: buildChildren(
                      items.length,
                      (index) => Flexible(
                        child: GestureDetector(
                          behavior: HitTestBehavior.translucent,
                          onTap: () => setState(() {
                            currentPrimaryIndex = index;
                          }),
                          child: Container(
                            alignment: Alignment.center,
                            // color: Colors.red,
                            child: AnimatedDefaultTextStyle(
                              duration: Duration(milliseconds: 250),
                              curve: Curves.ease,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium!
                                  .copyWith(
                                      color: index == currentPrimaryIndex
                                          ? Colors.white
                                          : index == currentSecondaryIndex
                                              ? Colors.green.shade800
                                              : Colors.black),
                              child: Text(
                                items[index],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
