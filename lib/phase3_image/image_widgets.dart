import 'package:flutter/material.dart';

// Replace with any large image URL (e.g. a 4000x3000 photo).
const String imageUrl = 'https://picsum.photos/id/1015/4000/3000';

/// BEFORE: image decoded at its FULL original resolution (e.g. 4000x3000)
/// even though it's shown in a tiny 100x100 grid tile. Wastes huge memory.
class BeforeImageGrid extends StatelessWidget {
  const BeforeImageGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(8),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
      ),
      itemCount: 12,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(4),
          child: Image.network(
            imageUrl,
            fit: BoxFit.cover,
            // No cacheWidth/cacheHeight — decodes at full 4000x3000
            // for EVERY tile, even though tile is tiny on screen.
          ),
        );
      },
    );
  }
}

/// AFTER: cacheWidth/cacheHeight tell Flutter to decode the image at
/// the actual display size, not the original size. Massive memory saving.
class AfterImageGrid extends StatelessWidget {
  const AfterImageGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(8),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
      ),
      itemCount: 12,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(4),
          child: Image.network(
            imageUrl,
            fit: BoxFit.cover,
            cacheWidth: 200, // decode at ~200px instead of 4000px
            cacheHeight: 200,
          ),
        );
      },
    );
  }
}