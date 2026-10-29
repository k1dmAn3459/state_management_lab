import 'package:flutter/material.dart';
import '../state/counter_scope.dart';
import '../widgets/history_badge.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    debugPrint('build: HistoryScreen');
    final notifier = CounterScope.of(context);
    final history = notifier.history;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Історія змін'),
        actions: const [
          HistoryBadge(),
        ],
      ),
      body: history.isEmpty
          ? const Center(child: Text('Історія порожня'))
          : ListView.builder(
              itemCount: history.length,
              itemBuilder: (context, index) {
                final item = history[index];
                return ListTile(
                  leading: CircleAvatar(child: Text(item.action)),
                  title: Text(
                    'Було: ${item.previousValue} → Стало: ${item.newValue}',
                  ),
                  subtitle: Text('Час: ${item.formattedTime}'),
                );
              },
            ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: FilledButton.tonalIcon(
            onPressed: history.isEmpty ? null : notifier.clearHistory,
            icon: const Icon(Icons.delete_outline),
            label: const Text('Очистити історію'),
          ),
        ),
      ),
    );
  }
}