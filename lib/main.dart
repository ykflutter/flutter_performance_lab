import 'package:flutter/material.dart';

import 'phase1_rebuild/rebuild_demo_screen.dart';
import 'phase2_list/list_demo_screen.dart';
import 'phase3_image/image_demo_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Performance Lab',
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Performance Lab')),
      body: ListView(
        children: [
          ListTile(
            title: const Text('Phase 1: Widget Rebuilds'),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const RebuildDemoScreen()),
            ),
          ),
          ListTile(
            title: const Text('Phase 2: List Performance'),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const ListDemoScreen()),
            ),
          ),
          ListTile(
            title: const Text('Phase 3: Image Optimization'),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const ImageDemoScreen()),
            ),
          ),
        ],
      ),
    );
  }
}
