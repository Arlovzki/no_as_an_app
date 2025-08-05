import 'package:flutter/material.dart';
import 'package:presentation/presentation.dart';

/// A widget to handle network failure scenarios.
class NetworkFailureActuator extends StatelessWidget {
  /// Constructs a [NetworkFailureActuator] widget.
  const NetworkFailureActuator({
    this.mainAxisSize = MainAxisSize.max,
    this.onPressed,
    super.key,
  });

  /// The axis size for the main axis of the actuator.
  final MainAxisSize mainAxisSize;

  /// A callback function triggered when the actuator is pressed.
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Actuator.image(
      descriptionWidget: const Text(
        'Sorry, connection could not be made.\nPlease check your internet\nconnection and try again.',
        textAlign: TextAlign.center,
      ),
      mainAxisSize: mainAxisSize,
      title: 'Network error',
      localImage: Assets.noNetworkErrorIcon.keyName,
      buttonText: 'Try Again',
      onPressed: onPressed,
    );
  }
}
