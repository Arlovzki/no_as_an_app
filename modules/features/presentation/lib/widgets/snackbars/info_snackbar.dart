import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';

/// {@template InfoSnackbar}
/// Widget for info snackbar
/// {@endtemplate}
class InfoSnackbar {
  /// {@macro InfoSnackbar}
  InfoSnackbar(
    this.context, {
    this.position = StyledToastPosition.bottom,
  });

  /// A handle to the location of a widget in the widget tree.
  final BuildContext context;

  /// Position of the snackbar.
  final StyledToastPosition position;

  /// Shows an info toast.
  void show(
    String message, {
    StyledToastPosition position = StyledToastPosition.bottom,
  }) {
    showToastWidget(
      Padding(
        padding: const EdgeInsets.only(bottom: 20, left: 30, right: 30),
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            color: Colors.green,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.check_circle_outline,
                    color: Colors.white,
                  ),
                  const SizedBox(width: 4),
                  Flexible(
                    child: Text(
                      message,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      softWrap: false,
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      animationBuilder: (context, controller, duration, child) {
        return child;
      },
      position: position,
      context: context,
    );
  }
}
