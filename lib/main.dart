import 'package:flutter/material.dart';
import 'models/history_entry.dart';
import 'screens/counter_screen.dart';

void main() {
  runApp(const CounterApp());
}

class CounterApp extends StatefulWidget {
  const CounterApp({super.key});

  @override
  State<CounterApp> createState() => _CounterAppState();
}

class _CounterAppState extends State<CounterApp> {
  int _value = 0;
  final List<HistoryEntry> _history = [];

  void _increment(int step) {
    setState(() {
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
    });
  }

  bool _decrement(int step) {
    if (_value - step < 0) {
      return false;
    }
    setState(() {
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
    });
    return true;
  }

  void _reset() {
    if (_value == 0) return;
    setState(() {
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
    });
  }

  void _clearHistory() {
    setState(() {
      _history.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Лічильник з історією',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: true,
      ),
      home: CounterScreen(
        value: _value,
        history: List.unmodifiable(_history),
        onIncrement: _increment,
        onDecrement: _decrement,
        onReset: _reset,
        onClearHistory: _clearHistory,
      ),
    );
  }
}