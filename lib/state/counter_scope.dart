import 'package:flutter/widgets.dart';
import 'counter_notifier.dart';

class CounterScope extends InheritedNotifier<CounterNotifier> {
  const CounterScope({
    super.key,
    required CounterNotifier super.notifier,
    required super.child,
  });

  static CounterNotifier of(BuildContext context, {bool listen = true}) {
    if (listen) {
      final scope = context.dependOnInheritedWidgetOfExactType<CounterScope>();
      assert(scope != null, 'CounterScope not found in context');
      return scope!.notifier!;
    } else {
      final scope = context.getInheritedWidgetOfExactType<CounterScope>();
      assert(scope != null, 'CounterScope not found in context');
      return scope!.notifier!;
    }
  }
}