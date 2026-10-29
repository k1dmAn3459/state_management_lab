import 'package:flutter/material.dart';
import '../state/counter_scope.dart';
import '../widgets/counter_display.dart';
import '../widgets/history_badge.dart';
import '../widgets/step_selector.dart';
import 'history_screen.dart';

class CounterScreen extends StatefulWidget {
  const CounterScreen({super.key});

  @override
  State<CounterScreen> createState() => _CounterScreenState();
}

class _CounterScreenState extends State<CounterScreen> {
  int _step = 1;

  void _handleDecrement() {
    final notifier = CounterScope.of(context, listen: false);
    final success = notifier.decrement(_step);
    if (!success && mounted) {
      ScaffoldMessenger.of(context)
        ..clearSnackBars()
        ..showSnackBar(
          SnackBar(
            content: Text(
              'Значення не може стати від’ємним (поточне: ${notifier.value}, крок: $_step)',
            ),
          ),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    debugPrint('build: CounterScreen');
    return Scaffold(
      appBar: AppBar(
        title: const Text('Лічильник'),
        actions: [
          HistoryBadge(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute<void>(
                  builder: (_) => const HistoryScreen(),
                ),
              );
            },
          ),
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CounterDisplay(),
              const SizedBox(height: 32),
              StepSelector(
                selectedStep: _step,
                onStepChanged: (newStep) {
                  setState(() {
                    _step = newStep;
                  });
                },
              ),
              const SizedBox(height: 32),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FilledButton.tonalIcon(
                    onPressed: _handleDecrement,
                    icon: const Icon(Icons.remove),
                    label: Text('−$_step'),
                  ),
                  const SizedBox(width: 16),
                  FilledButton.icon(
                    onPressed: () =>
                        CounterScope.of(context, listen: false).increment(_step),
                    icon: const Icon(Icons.add),
                    label: Text('+$_step'),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              TextButton.icon(
                onPressed: () =>
                    CounterScope.of(context, listen: false).reset(),
                icon: const Icon(Icons.restart_alt),
                label: const Text('Скинути'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}