import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:presentation/themes/swatches/global_swatches.dart';

/// {@template ErrorSnackbar}
/// Widget for error snackbar
/// {@endtemplate}
class ErrorSnackbar {
  /// {@macro ErrorSnackbar}
  ErrorSnackbar(
    this.context, {
    this.position = StyledToastPosition.bottom,
  });

  /// A handle to the location of a widget in the widget tree.
  final BuildContext context;

  /// Position of the snackbar.
  final StyledToastPosition position;

  /// Shows an error toast.
  void show(
    String message, {
    StyledToastPosition position = StyledToastPosition.bottom,
  }) {
    showToastWidget(
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            color: lavaRed,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.close_outlined,
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
