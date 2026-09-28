import 'package:flutter/material.dart';
import 'state_widgets.dart';

class StateDemoScreen extends StatefulWidget {
  const StateDemoScreen({super.key});

  @override
  State<StateDemoScreen> createState() => _StateDemoScreenState();
}

class _StateDemoScreenState extends State<StateDemoScreen> {
  bool showAfter = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('State Management Demo')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SegmentedButton<bool>(
              segments: const [
                ButtonSegment(value: false, label: Text('Before')),
                ButtonSegment(value: true, label: Text('After')),
              ],
              selected: {showAfter},
              onSelectionChanged: (s) => setState(() => showAfter = s.first),
            ),
            const SizedBox(height: 24),
            showAfter ? const AfterState() : const BeforeState(),
          ],
        ),
      ),
    );
  }
}