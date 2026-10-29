import 'package:flutter/material.dart';
import '../state/counter_scope.dart';

class HistoryBadge extends StatelessWidget {
  final VoidCallback? onTap;

  const HistoryBadge({super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    debugPrint('build: HistoryBadge');
    final history = CounterScope.of(context).history;

    return IconButton(
      onPressed: onTap,
      tooltip: 'Історія змін',
      icon: Badge(
        label: Text('${history.length}'),
        isLabelVisible: history.isNotEmpty,
        child: const Icon(Icons.history),
      ),
    );
  }
}