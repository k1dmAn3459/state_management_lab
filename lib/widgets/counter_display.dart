import 'package:flutter/material.dart';
import '../state/counter_scope.dart';

class CounterDisplay extends StatelessWidget {
  const CounterDisplay({super.key});

  @override
  Widget build(BuildContext context) {
    debugPrint('build: CounterDisplay');
    final value = CounterScope.of(context).value;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'Поточне значення',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(height: 8),
        Text(
          '$value',
          style: Theme.of(context).textTheme.displayLarge?.copyWith(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.primary,
              ),
        ),
      ],
    );
  }
}