import 'package:flutter/foundation.dart';
import '../models/history_entry.dart';

class CounterNotifier extends ChangeNotifier {
  int _value = 0;
  final List<HistoryEntry> _history = [];

  int get value => _value;
  List<HistoryEntry> get history => List.unmodifiable(_history);

  void increment(int step) {
    final prev = _value;
    _value += step;
    _history.insert(
      0,
      HistoryEntry(
        timestamp: DateTime.now(),
        action: '+$step',
        previousValue: prev,
        newValue: _value,
      ),
    );
    notifyListeners();
  }

  bool decrement(int step) {
    if (_value - step < 0) {
      return false;
    }
    final prev = _value;
    _value -= step;
    _history.insert(
      0,
      HistoryEntry(
        timestamp: DateTime.now(),
        action: '-$step',
        previousValue: prev,
        newValue: _value,
      ),
    );
    notifyListeners();
    return true;
  }

  void reset() {
    if (_value == 0) return;
    final prev = _value;
    _value = 0;
    _history.insert(
      0,
      HistoryEntry(
        timestamp: DateTime.now(),
        action: 'Скинути',
        previousValue: prev,
        newValue: 0,
      ),
    );
    notifyListeners();
  }

  void clearHistory() {
    if (_history.isEmpty) return;
    _history.clear();
    notifyListeners();
  }
}