import 'package:flutter/material.dart';
import '../models/history_entry.dart';
import '../widgets/counter_display.dart';
import '../widgets/history_badge.dart';
import '../widgets/step_selector.dart';
import 'history_screen.dart';

class CounterScreen extends StatefulWidget {
  final int value;
  final List<HistoryEntry> history;
  final ValueChanged<int> onIncrement;
  final bool Function(int step) onDecrement;
  final VoidCallback onReset;
  final VoidCallback onClearHistory;

  const CounterScreen({
    super.key,
    required this.value,
    required this.history,
    required this.onIncrement,
    required this.onDecrement,
    required this.onReset,
    required this.onClearHistory,
  });

  @override
  State<CounterScreen> createState() => _CounterScreenState();
}

class _CounterScreenState extends State<CounterScreen> {
  int _step = 1;

  void _handleDecrement() {
    final success = widget.onDecrement(_step);
    if (!success && mounted) {
      ScaffoldMessenger.of(context)
        ..clearSnackBars()
        ..showSnackBar(
          SnackBar(
            content: Text(
              'Значення не може стати від’ємним (спроба відняти $_step від ${widget.value})',
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
            count: widget.history.length,
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute<void>(
                  builder: (_) => HistoryScreen(
                    history: widget.history,
                    onClearHistory: widget.onClearHistory,
                  ),
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
              CounterDisplay(value: widget.value),
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
                    onPressed: () => widget.onIncrement(_step),
                    icon: const Icon(Icons.add),
                    label: Text('+$_step'),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              TextButton.icon(
                onPressed: widget.onReset,
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