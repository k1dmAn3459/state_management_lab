import 'package:flutter/material.dart';

class HistoryBadge extends StatelessWidget {
  final int count;
  final VoidCallback? onTap;

  const HistoryBadge({
    super.key,
    required this.count,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    debugPrint('build: HistoryBadge');
    return IconButton(
      onPressed: onTap,
      tooltip: 'Історія змін',
      icon: Badge(
        label: Text('$count'),
        isLabelVisible: count > 0,
        child: const Icon(Icons.history),
      ),
    );
  }
}