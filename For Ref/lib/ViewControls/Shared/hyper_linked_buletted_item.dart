import 'package:flutter/material.dart';
import 'package:muslimlife/Shared/app_styles.dart';
import 'package:url_launcher/url_launcher.dart';

class HyperlinkedBulettedList extends StatelessWidget {
  final String headerText;
  final String bodyText;
  final String actionType;

  const HyperlinkedBulettedList({
    super.key,
    required this.headerText,
    required this.bodyText,
    required this.actionType,
  });

  @override
  Widget build(BuildContext context) => InkWell(
    onTap: performAction,
    child: RichText(
      text: TextSpan(
        text: '\u2022 ',
        style: AppStyles.BoldDark16TextStyle.copyWith(height: 1.3),
        children: <TextSpan>[
          TextSpan(text: '$headerText: ', style: AppStyles.RegularDark14TextStyle.copyWith(height: 1.3)),
          TextSpan(
            text: bodyText,
            style: AppStyles.BoldDark14TextStyle.copyWith(
              height: 1.3,
              color: Colors.blue,
              decoration: TextDecoration.underline,
            ),
          ),
        ],
      ),
    ),
  );

  Future<void> performAction() async {
    if (actionType == "email") {
      var emailLaunchUri = Uri(scheme: 'mailto', path: bodyText, query: 'subject=Muslim Life: Feedback / Suggestion!');

      try {
        await launchUrl(emailLaunchUri);
      } catch (ex) {}
    }

    if (actionType == "url") {
      try {
        await launchUrl(Uri.parse(bodyText), mode: LaunchMode.platformDefault);
      } catch (ex) {}
    }

    if (actionType == "twitter") {
      try {
        await launchUrl(Uri.parse('https://twitter.com/$bodyText'), mode: LaunchMode.externalApplication);
      } catch (ex) {}
    }
  }
}
