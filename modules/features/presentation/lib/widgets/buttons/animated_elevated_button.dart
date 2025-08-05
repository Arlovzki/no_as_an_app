import 'package:flutter/material.dart';

/// {@template AnimatedElevatedButton}
/// An elevated button that scales in and out when hovered.
/// {@endtemplate}
class AnimatedElevatedButton extends StatefulWidget {
  /// {@macro AnimatedElevatedButton}
  const AnimatedElevatedButton({
    required this.child,
    super.key,
    this.animationDuration = const Duration(milliseconds: 200),
    this.padding = const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
    this.color,
    this.onTap,
  });

  /// The duration of the scaling animation.
  final Duration animationDuration;

  /// The child widget contained by the button.
  final Widget child;

  /// The padding between the [child] widget and the button.
  final EdgeInsets padding;

  /// The color of the button.
  ///
  /// Defaults to the [ThemeData.primaryColor] if no color is provided.
  final Color? color;

  /// Called when the user taps this part of the material.
  final VoidCallback? onTap;

  @override
  State<AnimatedElevatedButton> createState() => _AnimatedElevatedButtonState();
}

class _AnimatedElevatedButtonState extends State<AnimatedElevatedButton> {
  bool onHover = false;

  @override
  Widget build(BuildContext context) {
    final borderRadius = BorderRadius.circular(104);

    return MouseRegion(
      onHover: (event) => setState(() => onHover = true),
      onExit: (event) => setState(() => onHover = false),
      child: AnimatedContainer(
        decoration: BoxDecoration(
          borderRadius: borderRadius,
          color: widget.color ?? Theme.of(context).primaryColor,
        ),
        duration: widget.animationDuration,
        transformAlignment: Alignment.center,
        transform: Matrix4.identity()..scale(onHover ? 1.1 : 1),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: borderRadius,
            onTap: widget.onTap,
            child: Padding(padding: widget.padding, child: widget.child),
          ),
        ),
      ),
    );
  }
}
