import 'package:flutter/material.dart';
import 'phase1_rebuild/rebuild_demo_screen.dart';
import 'phase2_list/list_demo_screen.dart';
import 'phase3_image/image_demo_screen.dart';
import 'phase4_build/build_demo_screen.dart';
import 'phase5_state/state_demo_screen.dart';
import 'phase6_animation/animation_demo_screen.dart';
import 'phase7_json/json_demo_screen.dart';

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

  void open(BuildContext context, Widget screen) {
    Navigator.push(context, MaterialPageRoute(builder: (_) => screen));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Flutter Performance Lab')),
      body: ListView(
        children: [
          ListTile(
            title: const Text('Phase 1: Widget Rebuilds'),
            onTap: () => open(context, const RebuildDemoScreen()),
          ),
          ListTile(
            title: const Text('Phase 2: List Performance'),
            onTap: () => open(context, const ListDemoScreen()),
          ),
          ListTile(
            title: const Text('Phase 3: Image Optimization'),
            onTap: () => open(context, const ImageDemoScreen()),
          ),
          ListTile(
            title: const Text('Phase 4: Expensive Build'),
            onTap: () => open(context, const BuildDemoScreen()),
          ),
          ListTile(
            title: const Text('Phase 5: State Management'),
            onTap: () => open(context, const StateDemoScreen()),
          ),
          ListTile(
            title: const Text('Phase 6: Animation'),
            onTap: () => open(context, const AnimationDemoScreen()),
          ),
          ListTile(
            title: const Text('Phase 7: JSON Parsing'),
            onTap: () => open(context, const JsonDemoScreen()),
          ),
        ],
      ),
    );
  }
}