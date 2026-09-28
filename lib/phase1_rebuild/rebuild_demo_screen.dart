import 'package:flutter/material.dart';

import 'widgets/before_rebuild_demo.dart';

class RebuildDemoScreen extends StatefulWidget {
  const RebuildDemoScreen({super.key});

  @override
  State<RebuildDemoScreen> createState() => _RebuildDemoScreenState();
}

class _RebuildDemoScreenState extends State<RebuildDemoScreen> {
  bool showAfter = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Widget Rebuild Demo')),
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
            showAfter ? const AfterCounter() : const BeforeCounter(),
          ],
        ),
      ),
    );
  }
}