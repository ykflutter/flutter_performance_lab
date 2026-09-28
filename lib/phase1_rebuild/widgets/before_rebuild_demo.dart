import 'package:flutter/material.dart';

/// BEFORE: setState rebuilds counter + unrelated card together.
class BeforeCounter extends StatefulWidget {
  const BeforeCounter({super.key});

  @override
  State<BeforeCounter> createState() => _BeforeCounterState();
}

class _BeforeCounterState extends State<BeforeCounter> {
  int counter = 0;
  int cardBuilds = 0;

  @override
  Widget build(BuildContext context) {
    cardBuilds++;

    return Column(
      children: [
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Text('Unrelated card rebuilt: $cardBuilds times'),
          ),
        ),
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

/// AFTER: unrelated card is const, only counter rebuilds.
class AfterCounter extends StatelessWidget {
  const AfterCounter({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Card(
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Text('Unrelated card rebuilt: 0 times (const)'),
          ),
        ),
        SizedBox(height: 20),
        _CounterOnly(),
      ],
    );
  }
}

class _CounterOnly extends StatefulWidget {
  const _CounterOnly();

  @override
  State<_CounterOnly> createState() => _CounterOnlyState();
}

class _CounterOnlyState extends State<_CounterOnly> {
  int counter = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
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