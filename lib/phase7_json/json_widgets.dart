import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// Fake bada JSON string banata hai (top-level, compute ke liye).
String generateBigJson(int count) {
  final list = List.generate(
    count,
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
  String status = 'Preparing data...';
  String? json;

  @override
  void initState() {
    super.initState();
    prepareData();
  }

  // Test data background isolate me banta hai, UI freeze nahi hota
  Future<void> prepareData() async {
    final data = await compute(generateBigJson, 200000);
    if (!mounted) return;
    setState(() {
      json = data;
      status = 'Ready. Tap "Load JSON"';
    });
  }

  Future<void> load() async {
    final data = json;
    if (data == null) return;

    setState(() => status = 'Loading...');
    // UI ko "Loading..." draw karne ka mauka do
    await Future.delayed(const Duration(milliseconds: 100));

    final sw = Stopwatch()..start();

    final count = widget.useIsolate
        ? await compute(parseJson, data) // ✅ background isolate
        : parseJson(data); // ❌ UI thread

    sw.stop();
    if (!mounted) return;
    setState(() => status = 'Parsed $count items in ${sw.elapsedMilliseconds} ms');
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Ye spinner ruk jaye to UI thread block hai
        const CircularProgressIndicator(),
        const SizedBox(height: 20),
        Text(status),
        const SizedBox(height: 12),
        ElevatedButton(
          onPressed: json == null ? null : load,
          child: const Text('Load JSON'),
        ),
      ],
    );
  }
}