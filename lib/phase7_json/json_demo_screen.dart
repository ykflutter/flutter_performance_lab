import 'package:flutter/material.dart';
import 'json_widgets.dart';

class JsonDemoScreen extends StatefulWidget {
  const JsonDemoScreen({super.key});

  @override
  State<JsonDemoScreen> createState() => _JsonDemoScreenState();
}

class _JsonDemoScreenState extends State<JsonDemoScreen> {
  bool showAfter = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('JSON Parsing Demo')),
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
            // key: mode badalne pe widget fresh start ho
            showAfter
                ? const JsonLoader(key: ValueKey('after'), useIsolate: true)
                : const JsonLoader(key: ValueKey('before'), useIsolate: false),
          ],
        ),
      ),
    );
  }
}