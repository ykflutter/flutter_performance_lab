import 'package:flutter/material.dart';

/// Heavy static background: bahut saare items, kabhi change nahi hota.
class HeavyBackground extends StatelessWidget {
  const HeavyBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 10,
      physics: const NeverScrollableScrollPhysics(),
      children: List.generate(
        300,
        (i) => Container(
          margin: const EdgeInsets.all(2),
          decoration: BoxDecoration(
            color: Colors.primaries[i % Colors.primaries.length].withValues(alpha: 0.3),
            borderRadius: BorderRadius.circular(8),
            boxShadow: const [BoxShadow(blurRadius: 6, color: Colors.black26)],
          ),
        ),
      ),
    );
  }
}

class _SpinningBox extends StatefulWidget {
  const _SpinningBox();

  @override
  State<_SpinningBox> createState() => _SpinningBoxState();
}

class _SpinningBoxState extends State<_SpinningBox>
    with SingleTickerProviderStateMixin {
  late final AnimationController controller = AnimationController(
    vsync: this,
    duration: const Duration(seconds: 2),
  )..repeat();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RotationTransition(
      turns: controller,
      child: Container(width: 100, height: 100, color: Colors.deepPurple),
    );
  }
}

/// BEFORE: animation ke saath background bhi baar baar repaint hota hai.
class BeforeAnimation extends StatelessWidget {
  const BeforeAnimation({super.key});

  @override
  Widget build(BuildContext context) {
    return const Stack(
      alignment: Alignment.center,
      children: [
        HeavyBackground(),
        _SpinningBox(),
      ],
    );
  }
}

/// AFTER: RepaintBoundary background ko alag layer me rakhta hai,
/// isliye animation se uska repaint nahi hota.
class AfterAnimation extends StatelessWidget {
  const AfterAnimation({super.key});

  @override
  Widget build(BuildContext context) {
    return const Stack(
      alignment: Alignment.center,
      children: [
        RepaintBoundary(child: HeavyBackground()),
        RepaintBoundary(child: _SpinningBox()),
      ],
    );
  }
}