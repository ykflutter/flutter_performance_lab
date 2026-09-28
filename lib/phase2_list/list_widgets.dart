import 'package:flutter/material.dart';

const int itemCount = 1000;

/// BEFORE: plain ListView — ALL 1000 items build immediately,
/// even the ones far off-screen. Watch the console print count.
class BeforeList extends StatelessWidget {
  const BeforeList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: List.generate(itemCount, (index) {
        debugPrint('Item $index built'); // will print 0 to 999 immediately
        return ListTile(
          leading: CircleAvatar(child: Text('$index')),
          title: Text('Item #$index'),
        );
      }),
    );
  }
}

/// AFTER: ListView.builder — only items visible on screen (plus a small
/// buffer) get built. Scroll down slowly and watch console print numbers
/// appear only as new items come into view.
class AfterList extends StatelessWidget {
  const AfterList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: itemCount,
      itemBuilder: (context, index) {
        debugPrint('Item $index built'); // prints only ~10-15 at a time
        return ListTile(
          leading: CircleAvatar(child: Text('$index')),
          title: Text('Item #$index'),
        );
      },
    );
  }
}