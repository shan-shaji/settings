import 'package:flutter/material.dart';
import 'package:settings/l10n/l10n.dart';
import 'package:yaru_widgets/yaru_widgets.dart';

class AppsPage extends StatelessWidget {
  const AppsPage({Key? key}) : super(key: key);

  static Widget create(BuildContext context) => const AppsPage();

  static Widget createTitle(BuildContext context) =>
      Text(context.l10n.appsPageTitle);

  static bool searchMatches(String value, BuildContext context) => value
          .isNotEmpty
      ? context.l10n.appsPageTitle.toLowerCase().contains(value.toLowerCase())
      : false;

  @override
  Widget build(BuildContext context) {
    return YaruPage(children: [
      Center(
        child: Text(context.l10n.appsPageTitle),
      )
    ]);
  }
}
