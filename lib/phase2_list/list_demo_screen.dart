import 'package:flutter/material.dart';
import 'list_widgets.dart';

class ListDemoScreen extends StatefulWidget {
  const ListDemoScreen({super.key});

  @override
  State<ListDemoScreen> createState() => _ListDemoScreenState();
}

class _ListDemoScreenState extends State<ListDemoScreen> {
  bool showAfter = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('List Performance Demo')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: SegmentedButton<bool>(
              segments: const [
                ButtonSegment(value: false, label: Text('Before')),
                ButtonSegment(value: true, label: Text('After')),
              ],
              selected: {showAfter},
              onSelectionChanged: (s) => setState(() => showAfter = s.first),
            ),
          ),
          Expanded(
            child: showAfter ? const AfterList() : const BeforeList(),
          ),
        ],
      ),
    );
  }
}