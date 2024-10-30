import 'dart:async';

import 'package:atlas_flutter/widgets/modal_grip.dart';
import 'package:flutter/material.dart';

void showSetEditorModal(BuildContext context) {
  showModalBottomSheet(
    context: context,
    enableDrag: false,
    isScrollControlled: true,
    clipBehavior: Clip.hardEdge,
    builder: (context) => const SetEditor(),
  );
}

class SetEditor extends StatefulWidget {
  const SetEditor({super.key});

  @override
  State<SetEditor> createState() => _SetEditorState();
}

class _SetEditorState extends State<SetEditor>
    with SingleTickerProviderStateMixin {
  List<double> heights = [100, 200, 300, 400, 5000];
  int currentPageIndex = 0;
  double sheetMaxHeight = 600;
  double scrollContentHeight = 0;

  final scrollContentKey = GlobalKey();

  void setPageIndex(int index) async {
    await pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 500),
      curve: Curves.ease,
    );
    setState(() => currentPageIndex = index);
  }

  void updateMaxSheetHeight() {
    setState(() {
      double maxHeight = MediaQuery.of(context).size.height * 0.9;
      double? contentHeight = scrollContentKey.currentContext?.size?.height;

      scrollContentHeight = contentHeight ?? 0;

      if (contentHeight == null) {
        sheetMaxHeight = 0;
      } else {
        sheetMaxHeight = contentHeight < maxHeight ? contentHeight : maxHeight;
      }
    });
  }

// 1 Page lag. Es wird immer die Höhe für die zuvor verlassene Page gemessen
  void handlePageChange(int index) {
    setState(() {
      currentPageIndex = index;
    });

    // Timer(Duration(milliseconds: 250), () {
    //   setState(() {
    //     double maxHeight = MediaQuery.of(context).size.height * 0.9;
    //     double? contentHeight = scrollContentKey.currentContext?.size?.height;

    //     scrollContentHeight = contentHeight ?? 0;

    //     if (contentHeight == null) {
    //       sheetMaxHeight = 0;
    //     } else {
    //       sheetMaxHeight =
    //           contentHeight < maxHeight ? contentHeight : maxHeight;
    //     }
    //   });
    // });
  }

  late PageController pageController;

  @override
  void initState() {
    super.initState();

    pageController = PageController(
      initialPage: currentPageIndex,
    );
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      expand: false,
      builder: (context, scrollController) => SingleChildScrollView(
        clipBehavior: Clip.none,
        controller: scrollController,
        child: Container(
          key: scrollContentKey,
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(28),
            ),
          ),
          child: Column(
            children: [
              Text(scrollContentHeight.toString()),
              const ModalGrip(),
              // Text(
              //   "Benchpress",
              //   style: Theme.of(context).textTheme.titleMedium,
              // ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.all(16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SetEditorTab(
                      label: "Set",
                      value: "1",
                      selected: currentPageIndex == 0,
                      onPressed: () => setPageIndex(0),
                    ),
                    SetEditorTab(
                      label: "Weight",
                      value: "50",
                      selected: currentPageIndex == 1,
                      onPressed: () => setPageIndex(1),
                    ),
                    SetEditorTab(
                      label: "Reps",
                      value: "8",
                      selected: currentPageIndex == 2,
                      onPressed: () => setPageIndex(2),
                    ),
                    SetEditorTab(
                      label: "RPE",
                      value: "9.5",
                      selected: currentPageIndex == 3,
                      onPressed: () => setPageIndex(3),
                    ),
                    SetEditorTab(
                      label: "Rest",
                      value: "2:30",
                      selected: currentPageIndex == 4,
                      onPressed: () => setPageIndex(4),
                    ),
                  ],
                ),
              ),

              AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                curve: Curves.ease,
                height: heights[currentPageIndex],
                clipBehavior: Clip.hardEdge,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(28),
                  ),
                ),
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    print(constraints);
                    return PageView.builder(
                      controller: pageController,
                      onPageChanged: (index) => handlePageChange(index),
                      itemCount: 5,
                      itemBuilder: (context, index) => Padding(
                        padding: const EdgeInsets.all(16),
                        child: Text("Page $index"),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SetEditorTab extends StatelessWidget {
  final String label;
  final String value;
  final bool selected;
  final Function()? onPressed;

  const SetEditorTab({
    super.key,
    required this.label,
    required this.value,
    required this.selected,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: onPressed,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 4.0),
            child: Text(
              label,
              style: Theme.of(context).textTheme.labelMedium,
            ),
          ),
          AnimatedContainer(
            duration: const Duration(milliseconds: 250),
            curve: Curves.ease,
            padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 28),
            decoration: BoxDecoration(
              color: selected
                  ? Colors.green.shade100
                  : Colors.green.shade100.withOpacity(0),
              borderRadius: const BorderRadius.all(
                Radius.circular(100),
              ),
            ),
            child: Text(
              value,
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
        ],
      ),
    );
  }
}
