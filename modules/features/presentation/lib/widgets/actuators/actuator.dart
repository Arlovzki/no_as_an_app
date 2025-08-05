import 'package:flutter/material.dart';
import 'package:presentation/presentation.dart';

/// An actuator provides information about the current state of a specific page
/// and an optional action button to trigger a certain task.
class Actuator extends StatelessWidget {
  /// An actuator that displays an icon.
  const Actuator.icon({
    required this.description,
    required this.title,
    required this.iconData,
    this.buttonText = 'Action',
    this.mainAxisSize = MainAxisSize.max,
    this.onPressed,
    this.descriptionWidget,
    super.key,
  }) : localImage = null;

  /// An actuator that displays a local image.
  const Actuator.image({
    required this.title,
    required this.localImage,
    this.description,
    this.buttonText = 'Action',
    this.mainAxisSize = MainAxisSize.max,
    this.onPressed,
    this.descriptionWidget,
    super.key,
  }) : iconData = null;

  /// The description text.
  final String? description;

  /// The description widget.
  final Widget? descriptionWidget;

  /// The main axis size of the actuator.
  final MainAxisSize mainAxisSize;

  /// The title text.
  final String title;

  /// The button text.
  final String buttonText;

  /// Called when the user interacts with this widget.
  final void Function()? onPressed;

  /// The icon data of the actuator.
  final IconData? iconData;

  /// The image path to be displayed in the actuator instead of the icon.
  final String? localImage;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Stack(
        children: [
          Center(
            child: Column(
              mainAxisSize: mainAxisSize,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (iconData != null)
                  Icon(
                    iconData,
                    size: 60,
                  )
                else
                  Image.asset(localImage!, width: 112),
                const SizedBox(height: 30),
                Text(
                  title,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 10),
                if (descriptionWidget != null)
                  descriptionWidget!
                else
                  Flexible(
                    child: Text(
                      description ?? '',
                      textAlign: TextAlign.center,
                    ),
                  ),
                const SizedBox(height: 20),
                if (onPressed != null)
                  ConstrainedBox(
                    constraints:
                        const BoxConstraints(minWidth: 250, maxWidth: 250),
                    child: RoundedElevatedButton(
                      onPressed: onPressed,
                      child: Text(
                        buttonText,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
