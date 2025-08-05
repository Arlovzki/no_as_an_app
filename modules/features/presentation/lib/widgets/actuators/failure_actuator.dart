import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:presentation/presentation.dart';
import 'package:url_launcher/url_launcher.dart';

/// {@template FailureActuator}
/// A substitute widget rendered when some widget fails to load.
///
/// This provides an actionable button that can trigger an alternative action.
/// {@endtemplate}
class FailureActuator extends StatelessWidget {
  /// {@macro FailureActuator}
  const FailureActuator({
    required this.description,
    this.iconData = FontAwesomeIcons.exclamation,
    this.mainAxisSize = MainAxisSize.max,
    this.title = 'Something went wrong',
    this.buttonText = 'Try Again',
    this.onPressed,
    super.key,
  });

  /// The description text.
  final String description;

  /// The icon data of the actuator.
  final IconData iconData;

  /// The main axis size of the actuator.
  final MainAxisSize mainAxisSize;

  /// The title text.
  final String title;

  /// The button text.
  final String buttonText;

  /// Called when the user interacts with this widget.
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    const String supportEmail = 'customercare@petpal.ph';

    return Actuator.image(
      descriptionWidget: Text.rich(
        textAlign: TextAlign.center,
        TextSpan(
          children: [
            const TextSpan(
              text:
                  'Sorry, there was a server error while\nprocessing your request. Please try again later or contact us at ',
            ),
            TextSpan(
              text: supportEmail,
              recognizer: TapGestureRecognizer()
                ..onTap = () async {
                  await launchUrl(
                    Uri.parse(
                      'mailto:$supportEmail',
                    ),
                  );
                },
            ),
          ],
        ),
      ),
      mainAxisSize: mainAxisSize,
      title: title,
      localImage: Assets.warningErrorIcon.keyName,
      buttonText: buttonText,
      onPressed: onPressed,
    );
  }
}
