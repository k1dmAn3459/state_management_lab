import 'package:flutter/material.dart';

class StepSelector extends StatelessWidget {
  final int selectedStep;
  final ValueChanged<int> onStepChanged;

  const StepSelector({
    super.key,
    required this.selectedStep,
    required this.onStepChanged,
  });

  static const List<int> steps = [1, 5, 10];

  @override
  Widget build(BuildContext context) {
    debugPrint('build: StepSelector');
    return SegmentedButton<int>(
      segments: steps
          .map((s) => ButtonSegment<int>(value: s, label: Text('Крок $s')))
          .toList(),
      selected: {selectedStep},
      onSelectionChanged: (selection) => onStepChanged(selection.first),
    );
  }
}