import 'package:atlas_flutter/widgets/rpe_input.dart';
import 'package:flutter/material.dart';

class RPEEditor extends StatelessWidget {
  const RPEEditor({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 16, right: 16, top: 64, bottom: 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Sehr starke Anstrengung",
            style: Theme.of(context).textTheme.titleMedium,
          ),
          Text(
            "Hätte vielleicht noch 2 Wiederholungen machen können.",
            style: Theme.of(context)
                .textTheme
                .bodyMedium!
                .copyWith(color: Colors.grey.shade600),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 32.0),
            child: RPEInput(),
          ),
          Text(
            "Wähle etwas mehr Gewicht.",
            style: Theme.of(context)
                .textTheme
                .bodyMedium!
                .copyWith(color: Colors.grey.shade600),
          ),
        ],
      ),
    );
  }
}
