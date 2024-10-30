import 'package:flutter/material.dart';

class SetType {
  const SetType({
    required this.title,
    required this.description,
    required this.icon,
  });

  final String title;
  final String description;
  final Icon icon;
}

class SetTypeSelect extends StatelessWidget {
  const SetTypeSelect({super.key});

  final List<SetType> setTypes = const [
    SetType(
      title: "Warm-up set",
      description:
          "Lighter sets performed before the main workout sets, to prepare the muscles and joints for the heavier workload.",
      icon: Icon(
        Icons.tips_and_updates_outlined,
        color: Colors.orange,
      ),
    ),
    SetType(
      title: "Work set",
      description:
          "Lighter sets performed before the main workout sets, to prepare the muscles and joints for the heavier workload.",
      icon: Icon(
        Icons.workspaces_filled,
        color: Colors.grey,
      ),
    ),
    SetType(
      title: "Failure",
      description:
          "Lighter sets performed before the main workout sets, to prepare the muscles and joints for the heavier workload.",
      icon: Icon(
        Icons.bolt,
        color: Colors.red,
      ),
    ),
    SetType(
      title: "Super set",
      description:
          "Lighter sets performed before the main workout sets, to prepare the muscles and joints for the heavier workload.",
      icon: Icon(
        Icons.list,
        color: Colors.blue,
      ),
    ),
    SetType(
      title: "Drop set",
      description:
          "Lighter sets performed before the main workout sets, to prepare the muscles and joints for the heavier workload.",
      icon: Icon(
        Icons.move_down_rounded,
        color: Colors.green,
      ),
    ),
    SetType(
      title: "Drop set",
      description:
          "Lighter sets performed before the main workout sets, to prepare the muscles and joints for the heavier workload.",
      icon: Icon(
        Icons.move_down_rounded,
        color: Colors.green,
      ),
    ),
    SetType(
      title: "Drop set",
      description:
          "Lighter sets performed before the main workout sets, to prepare the muscles and joints for the heavier workload.",
      icon: Icon(
        Icons.move_down_rounded,
        color: Colors.green,
      ),
    ),
    SetType(
      title: "Drop set",
      description:
          "Lighter sets performed before the main workout sets, to prepare the muscles and joints for the heavier workload.",
      icon: Icon(
        Icons.move_down_rounded,
        color: Colors.green,
      ),
    ),
    SetType(
      title: "Drop set",
      description:
          "Lighter sets performed before the main workout sets, to prepare the muscles and joints for the heavier workload.",
      icon: Icon(
        Icons.move_down_rounded,
        color: Colors.green,
      ),
    ),
    SetType(
      title: "Drop set",
      description:
          "Lighter sets performed before the main workout sets, to prepare the muscles and joints for the heavier workload.",
      icon: Icon(
        Icons.move_down_rounded,
        color: Colors.green,
      ),
    ),
    SetType(
      title: "Drop set",
      description:
          "Lighter sets performed before the main workout sets, to prepare the muscles and joints for the heavier workload.",
      icon: Icon(
        Icons.move_down_rounded,
        color: Colors.green,
      ),
    ),
    SetType(
      title: "Drop set",
      description:
          "Lighter sets performed before the main workout sets, to prepare the muscles and joints for the heavier workload.",
      icon: Icon(
        Icons.move_down_rounded,
        color: Colors.green,
      ),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.4,
      minChildSize: 0.3,
      maxChildSize: 0.9,
      builder: (context, controller) => CustomScrollView(
        controller: controller,
        slivers: [
          SliverPersistentHeader(
            pinned: true,
            delegate: PersistentBottomSheetHeader(
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(30),
                  ),
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      child: Container(
                        height: 4,
                        width: 50,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                    ),
                    Text(
                      "Select set type",
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ],
                ),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              ...setTypes.map(
                (setType) => Padding(
                  padding: const EdgeInsets.only(bottom: 32),
                  child: ListTile(
                    leading: setType.icon,
                    title: Text(setType.title),
                    subtitle: Text(setType.description),
                    trailing: const Icon(Icons.check),
                  ),
                ),
              ),
            ]),
          )
        ],
      ),
    );
  }
}

class PersistentBottomSheetHeader extends SliverPersistentHeaderDelegate {
  const PersistentBottomSheetHeader({required this.child});

  final Widget child;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return SizedBox.expand(child: child);
  }

  @override
  double get maxExtent => 110;

  @override
  double get minExtent => 80;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}
