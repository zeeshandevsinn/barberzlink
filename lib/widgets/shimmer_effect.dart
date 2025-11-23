// widgets/shimmer_effect.dart
import 'package:flutter/material.dart';

class ShimmerEffect extends StatefulWidget {
  final double width;
  final double height;
  final BoxShape shape;
  final BorderRadiusGeometry? borderRadius;

  const ShimmerEffect({
    Key? key,
    required this.width,
    required this.height,
    this.shape = BoxShape.rectangle,
    this.borderRadius,
  }) : super(key: key);

  static Widget rectangular({
    required double width,
    required double height,
    BorderRadiusGeometry? borderRadius,
  }) {
    return ShimmerEffect(
      width: width,
      height: height,
      shape: BoxShape.rectangle,
      borderRadius: borderRadius ?? BorderRadius.circular(4),
    );
  }

  static Widget circular({
    required double width,
    required double height,
  }) {
    return ShimmerEffect(
      width: width,
      height: height,
      shape: BoxShape.circle,
    );
  }

  @override
  State<ShimmerEffect> createState() => _ShimmerEffectState();
}

class _ShimmerEffectState extends State<ShimmerEffect>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1500),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Container(
          width: widget.width,
          height: widget.height,
          decoration: BoxDecoration(
            shape: widget.shape,
            borderRadius: widget.borderRadius,
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [
                Colors.grey[300]!,
                Colors.grey[100]!,
                Colors.grey[300]!,
              ],
              stops: [
                _controller.value - 0.5,
                _controller.value,
                _controller.value + 0.5,
              ].map((stop) => stop.clamp(0.0, 1.0)).toList(),
            ),
          ),
        );
      },
    );
  }
}
