import 'package:flutter/material.dart';
import 'image_widgets.dart';

class ImageDemoScreen extends StatefulWidget {
  const ImageDemoScreen({super.key});

  @override
  State<ImageDemoScreen> createState() => _ImageDemoScreenState();
}

class _ImageDemoScreenState extends State<ImageDemoScreen> {
  bool showAfter = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Image Optimization Demo')),
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
            child: showAfter ? const AfterImageGrid() : const BeforeImageGrid(),
          ),
        ],
      ),
    );
  }
}