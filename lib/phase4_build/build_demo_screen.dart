import 'package:flutter/material.dart';
import 'build_widgets.dart';

class BuildDemoScreen extends StatefulWidget {
  const BuildDemoScreen({super.key});

  @override
  State<BuildDemoScreen> createState() => _BuildDemoScreenState();
}

class _BuildDemoScreenState extends State<BuildDemoScreen> {
  bool showAfter = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Expensive Build Demo')),
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
            showAfter ? const AfterHeavy() : const BeforeHeavy(),
          ],
        ),
      ),
    );
  }
}