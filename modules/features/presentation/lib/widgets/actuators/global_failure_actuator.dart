import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:presentation/presentation.dart';

/// A widget to handle global failure scenarios.
class GlobalFailureActuator extends StatelessWidget {
  /// Constructs a [GlobalFailureActuator] widget.
  const GlobalFailureActuator({
    required this.failure,
    required this.onPressed,
    super.key,
  });

  /// The failure instance to be handled.
  final Failure failure;

  /// A callback function triggered when the actuator is pressed.
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    if (failure is NetworkFailure) {
      return NetworkFailureActuator(
        onPressed: onPressed,
      );
    }

    return FailureActuator(
      description: failure.message,
      onPressed: onPressed,
    );
  }
}
