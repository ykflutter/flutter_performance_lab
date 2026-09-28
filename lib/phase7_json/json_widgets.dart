import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// Fake bada JSON string banata hai (200,000 items).
String generateBigJson() {
  final list = List.generate(
    200000,
    (i) => {'id': i, 'name': 'User $i', 'email': 'user$i@test.com'},
  );
  return jsonEncode(list);
}

/// Top-level function (compute ke liye zaroori).
int parseJson(String json) {
  final list = jsonDecode(json) as List;
  return list.length;
}

class JsonLoader extends StatefulWidget {
  const JsonLoader({super.key, required this.useIsolate});

  final bool useIsolate;

  @override
  State<JsonLoader> createState() => _JsonLoaderState();
}

class _JsonLoaderState extends State<JsonLoader> {
  String status = 'Tap "Load JSON"';

  Future<void> load() async {
    setState(() => status = 'Loading...');
    // UI ko "Loading..." draw karne ka mauka do
    await Future.delayed(const Duration(milliseconds: 100));

    final json = generateBigJson();
    final sw = Stopwatch()..start();

    final count = widget.useIsolate
        ? await compute(parseJson, json) // ✅ background isolate
        : parseJson(json); // ❌ UI thread

    sw.stop();
    if (!mounted) return;
    setState(() => status = 'Parsed $count items in ${sw.elapsedMilliseconds} ms');
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Ye spinner freeze hota hai to UI thread block hai
        const CircularProgressIndicator(),
        const SizedBox(height: 20),
        Text(status),
        const SizedBox(height: 12),
        ElevatedButton(
          onPressed: load,
          child: const Text('Load JSON'),
        ),
      ],
    );
  }
}