import 'package:flutter/material.dart';
import '../models/history_entry.dart';
import '../widgets/history_badge.dart';

class HistoryScreen extends StatefulWidget {
  final List<HistoryEntry> history;
  final VoidCallback onClearHistory;

  const HistoryScreen({
    super.key,
    required this.history,
    required this.onClearHistory,
  });

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  late List<HistoryEntry> _localHistory;

  @override
  void initState() {
    super.initState();
    _localHistory = widget.history;
  }

  void _clear() {
    widget.onClearHistory();
    setState(() {
      _localHistory = const [];
    });
  }

  @override
  Widget build(BuildContext context) {
    debugPrint('build: HistoryScreen');
    return Scaffold(
      appBar: AppBar(
        title: const Text('Історія змін'),
        actions: [
          HistoryBadge(count: _localHistory.length),
        ],
      ),
      body: _localHistory.isEmpty
          ? const Center(child: Text('Історія порожня'))
          : ListView.builder(
              itemCount: _localHistory.length,
              itemBuilder: (context, index) {
                final item = _localHistory[index];
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
            onPressed: _localHistory.isEmpty ? null : _clear,
            icon: const Icon(Icons.delete_outline),
            label: const Text('Очистити історію'),
          ),
        ),
      ),
    );
  }
}