import 'package:flutter/material.dart';

/// Fake heavy work (20 million loop iterations).
int heavyCalculation() {
  int sum = 0;
  for (int i = 0; i < 20000000; i++) {
    sum += i % 7;
  }
  return sum;
}

/// BEFORE: heavy work inside build() — runs on EVERY setState.
class BeforeHeavy extends StatefulWidget {
  const BeforeHeavy({super.key});

  @override
  State<BeforeHeavy> createState() => _BeforeHeavyState();
}

class _BeforeHeavyState extends State<BeforeHeavy> {
  int counter = 0;

  @override
  Widget build(BuildContext context) {
    final sw = Stopwatch()..start();
    final result = heavyCalculation(); // ❌ har build pe chalta hai
    sw.stop();

    return Column(
      children: [
        Text('Result: $result'),
        Text('build() heavy work: ${sw.elapsedMilliseconds} ms'),
        const SizedBox(height: 20),
        Text('Counter: $counter', style: const TextStyle(fontSize: 32)),
        const SizedBox(height: 12),
        ElevatedButton(
          onPressed: () => setState(() => counter++),
          child: const Text('Increment'),
        ),
      ],
    );
  }
}

/// AFTER: heavy work sirf ek baar initState() me, result cached.
class AfterHeavy extends StatefulWidget {
  const AfterHeavy({super.key});

  @override
  State<AfterHeavy> createState() => _AfterHeavyState();
}

class _AfterHeavyState extends State<AfterHeavy> {
  int counter = 0;
  late final int result;
  late final int calcMs;

  @override
  void initState() {
    super.initState();
    final sw = Stopwatch()..start();
    result = heavyCalculation(); // ✅ sirf ek baar
    sw.stop();
    calcMs = sw.elapsedMilliseconds;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('Result: $result'),
        Text('Calculated once in initState: $calcMs ms'),
        const SizedBox(height: 20),
        Text('Counter: $counter', style: const TextStyle(fontSize: 32)),
        const SizedBox(height: 12),
        ElevatedButton(
          onPressed: () => setState(() => counter++),
          child: const Text('Increment'),
        ),
      ],
    );
  }
}