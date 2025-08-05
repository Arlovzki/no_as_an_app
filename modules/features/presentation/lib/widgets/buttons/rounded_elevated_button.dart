import 'package:flutter/material.dart';

/// {@template RoundedElevatedButton}
/// The standard elevated button of the app.
/// {@endtemplate}
class RoundedElevatedButton extends StatelessWidget {
  /// {@macro RoundedElevatedButton}
  const RoundedElevatedButton({
    required this.onPressed,
    required this.child,
    this.padding,
    this.tapTargetSize,
    this.color,
    this.disabledColor,
    this.borderRadius = 100,
    this.height,
    this.width,
    this.textStyle,
    this.borderSide,
    this.semanticLabel,
    super.key,
  });

  /// Called when the user interacts with this widget.
  final void Function()? onPressed;

  /// The widget inside of the button, mostly the child of this widget is a [Text].
  final Widget child;

  /// The spacing inside of the button.
  final EdgeInsets? padding;

  /// The minimum size of the area within which the button may be pressed.
  final MaterialTapTargetSize? tapTargetSize;

  /// The background color of the button.
  ///
  /// Defaults to the [ThemeData.primaryColor] if no color is provided.
  final Color? color;

  /// The background color of the disabled button.
  ///
  /// Defaults to the [Theme.of(context).buttonTheme.colorScheme?.background] if no color is provided.
  final Color? disabledColor;

  /// The border radius of the button, default is [100]
  final double borderRadius;

  /// The height of the button.
  final double? height;

  /// The width of the button.
  final double? width;

  /// The default text style of the [Text] child of this widget.
  final TextStyle? textStyle;

  /// The configuration of border of this widget.
  final BorderSide? borderSide;

  /// Semantics label
  final String? semanticLabel;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? double.maxFinite,
      height: height,
      child: Semantics(
        label: semanticLabel,
        button: true,
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            disabledForegroundColor: onPressed == null ? Colors.white : null,
            disabledBackgroundColor: disabledColor ??
                Theme.of(context).buttonTheme.colorScheme?.surface,
            backgroundColor: color,
            tapTargetSize: tapTargetSize,
            padding: padding ??
                const EdgeInsets.symmetric(
                  vertical: 14,
                  horizontal: 32,
                ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadius),
              side: borderSide ?? BorderSide.none,
            ),
            textStyle: textStyle,
          ),
          child: child,
        ),
      ),
    );
  }
}
