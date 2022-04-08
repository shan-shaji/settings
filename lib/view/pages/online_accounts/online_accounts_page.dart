import 'package:flutter/material.dart';
import 'package:settings/l10n/l10n.dart';
import 'package:yaru_widgets/yaru_widgets.dart';

class OnlineAccountsPage extends StatelessWidget {
  const OnlineAccountsPage({Key? key}) : super(key: key);

  static Widget create(BuildContext context) => const OnlineAccountsPage();

  static Widget createTitle(BuildContext context) =>
      Text(context.l10n.onlineAccountsPageTitle);

  static bool searchMatches(String value, BuildContext context) =>
      value.isNotEmpty
          ? context.l10n.onlineAccountsPageTitle
              .toLowerCase()
              .contains(value.toLowerCase())
          : false;

  @override
  Widget build(BuildContext context) {
    return YaruPage(
        children: [Center(child: Text(context.l10n.onlineAccountsPageTitle))]);
  }
}
