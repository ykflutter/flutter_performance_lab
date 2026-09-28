import 'package:flutter/material.dart';

/// BEFORE: setState poori screen rebuild karta hai (Header + Footer bhi).
class BeforeState extends StatefulWidget {
  const BeforeState({super.key});

  @override
  State<BeforeState> createState() => _BeforeStateState();
}

class _BeforeStateState extends State<BeforeState> {
  int counter = 0;
  int screenBuilds = 0;

  @override
  Widget build(BuildContext context) {
    screenBuilds++;
    return Column(
      children: [
        Text('Whole screen builds: $screenBuilds'),
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

/// AFTER: ValueNotifier + ValueListenableBuilder, sirf Text rebuild hota hai.
class AfterState extends StatefulWidget {
  const AfterState({super.key});

  @override
  State<AfterState> createState() => _AfterStateState();
}

class _AfterStateState extends State<AfterState> {
  final ValueNotifier<int> counter = ValueNotifier(0);
  int screenBuilds = 0;

  @override
  void dispose() {
    counter.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    screenBuilds++;
    return Column(
      children: [
        Text('Whole screen builds: $screenBuilds'), // tap pe nahi badhega
        const SizedBox(height: 20),
        ValueListenableBuilder<int>(
          valueListenable: counter,
          builder: (context, value, _) {
            return Text('Counter: $value', style: const TextStyle(fontSize: 32));
          },
        ),
        const SizedBox(height: 12),
        ElevatedButton(
          onPressed: () => counter.value++,
          child: const Text('Increment'),
        ),
      ],
    );
  }
}