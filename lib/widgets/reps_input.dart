import 'package:flutter/material.dart';

class KeyDistance {
  final GlobalKey key;
  final double distance;
  const KeyDistance(this.key, this.distance);
}

class RepsInput extends StatefulWidget {
  const RepsInput({super.key});

  @override
  State<RepsInput> createState() => _RepsInputState();
}

class _RepsInputState extends State<RepsInput> {
  final int itemCount = 60;
  int currentIndex = 0;

  double posX = 0;
  double posY = 0;
  Size? currentSize;
  late double scrollOffset;

  final GlobalKey gridKey = GlobalKey();
  final List<GlobalKey> itemKeys = List.generate(60, (index) => GlobalKey());
  late KeyDistance nearestKey;
  late Iterable<Offset?> positions;

  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    // setState(() => scrollOffset = scrollController.offset);

    scrollController.addListener(() {
      setState(() => scrollOffset = scrollController.offset);
    });

    super.initState();
  }

  Size? getItemSize(GlobalKey key) => key.currentContext?.size;

  void handleTap(int index) {
    final Offset? position = getPosition(itemKeys[index]);
    print(position);
    if (position == null) return;
    setState(() {
      currentIndex = index;
      posX = position.dx;
      posY = position.dy;
      currentSize = getItemSize(itemKeys[index]);
    });
  }

  void handleLongPress(LongPressStartDetails details) {
    positions = itemKeys.map((key) => getPosition(key));
  }

  void handleLongPressMoveUpdate(LongPressMoveUpdateDetails details) {
    // positions.map((key) {
    //   // final Offset? position = getPosition(key);
    //   // if (position == null) return KeyDistance(key, double.infinity);
    //   return KeyDistance(
    //     key,
    //     getDistance(
    //       Offset(details.globalPosition.dx, details.globalPosition.dy),
    //       getPosition(key) ?? const Offset(double.infinity, double.infinity),
    //     ),
    //   );
    // }).reduce((prev, current) {
    //   if (current.distance < prev.distance) {
    //     return current;
    //   } else {
    //     return prev;
    //   }
    // });

    // print(itemKeys.indexOf(nearestKey.key));
  }

  Offset? getPosition(GlobalKey key) {
    final RenderBox? box = key.currentContext?.findRenderObject() as RenderBox?;
    if (box == null) return null;

    final Offset position = box.globalToLocal(
      Offset.zero,
      ancestor: gridKey.currentContext?.findRenderObject(),
    );

    return Offset(
      position.dx + box.size.width,
      position.dy + box.size.height,
    );
  }

  double getDistance(Offset a, Offset b) {
    return (a.dx - b.dx).abs() + (a.dy - b.dy).abs();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPressStart: handleLongPress,
      onLongPressMoveUpdate: handleLongPressMoveUpdate,
      child: Padding(
        padding: const EdgeInsets.all(40.0),
        child: GridView.builder(
          key: gridKey,
          controller: scrollController,
          itemCount: itemCount,
          // padding: const EdgeInsets.all(16),
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 50,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
          ),
          itemBuilder: (context, index) => GestureDetector(
            onTap: () => handleTap(index),
            child: Builder(
              builder: (context) {
                if (index == 0) {
                  return Stack(
                    children: [
                      Container(
                        // duration: const Duration(milliseconds: 250),
                        // curve: Curves.ease,
                        transform: Matrix4.translationValues(
                            -posX, -posY + scrollOffset, 0),
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(100),
                        ),
                      ),
                      GridItem(
                        key: itemKeys[index],
                        label: index.toString(),
                        selected: index == currentIndex,
                      ),
                    ],
                  );
                } else {
                  return GridItem(
                    key: itemKeys[index],
                    label: index.toString(),
                    selected: index == currentIndex,
                  );
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}

class GridItem extends StatelessWidget {
  final String label;
  final bool selected;

  const GridItem({
    super.key,
    required this.label,
    required this.selected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.green.withOpacity(0.1),
        borderRadius: BorderRadius.circular(100),
      ),
      child: Text(
        label,
        style: Theme.of(context)
            .textTheme
            .titleMedium
            ?.copyWith(color: selected ? Colors.white : Colors.black),
      ),
    );
  }
}
