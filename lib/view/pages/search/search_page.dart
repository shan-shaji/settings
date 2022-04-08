import 'package:flutter/material.dart';
import 'package:settings/l10n/l10n.dart';
import 'package:yaru_widgets/yaru_widgets.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({Key? key}) : super(key: key);

  static Widget create(BuildContext context) => const SearchPage();

  static Widget createTitle(BuildContext context) =>
      Text(context.l10n.searchPageTitle);

  static bool searchMatches(String value, BuildContext context) => value
          .isNotEmpty
      ? context.l10n.searchPageTitle.toLowerCase().contains(value.toLowerCase())
      : false;

  @override
  Widget build(BuildContext context) {
    return YaruPage(
        children: [Center(child: Text(context.l10n.searchPageTitle))]);
  }
}
