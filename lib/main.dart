import 'package:flutter/material.dart';
import 'screens/counter_screen.dart';
import 'state/counter_notifier.dart';
import 'state/counter_scope.dart';

void main() {
  runApp(const CounterApp());
}

class CounterApp extends StatefulWidget {
  const CounterApp({super.key});

  @override
  State<CounterApp> createState() => _CounterAppState();
}

class _CounterAppState extends State<CounterApp> {
  final CounterNotifier _counterNotifier = CounterNotifier();

  @override
  void dispose() {
    _counterNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CounterScope(
      notifier: _counterNotifier,
      child: MaterialApp(
        title: 'Лічильник з історією',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
          useMaterial3: true,
        ),
        home: const CounterScreen(),
      ),
    );
  }
}