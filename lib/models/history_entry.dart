import 'package:flutter/foundation.dart';

@immutable
class HistoryEntry {
  final DateTime timestamp;
  final String action;
  final int previousValue;
  final int newValue;

  const HistoryEntry({
    required this.timestamp,
    required this.action,
    required this.previousValue,
    required this.newValue,
  });

  String get formattedTime {
    final h = timestamp.hour.toString().padLeft(2, '0');
    final m = timestamp.minute.toString().padLeft(2, '0');
    final s = timestamp.second.toString().padLeft(2, '0');
    return '$h:$m:$s';
  }
}