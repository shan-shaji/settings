import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:settings/constants.dart';
import 'package:settings/l10n/l10n.dart';
import 'package:settings/services/settings_service.dart';
import 'package:settings/view/link.dart';
import 'package:settings/view/pages/privacy/reporting_model.dart';
import 'package:settings/view/section_description.dart';
import 'package:yaru_widgets/yaru_widgets.dart';

const kUbuntuReportingLink = 'https://ubuntu.com/legal/data-privacy';

class ReportingPage extends StatelessWidget {
  const ReportingPage({Key? key}) : super(key: key);

  static Widget create(BuildContext context) => ChangeNotifierProvider(
        create: (_) => ReportingModel(
          context.read<SettingsService>(),
        ),
        child: const ReportingPage(),
      );

  @override
  Widget build(BuildContext context) {
    final model = context.watch<ReportingModel>();
    return YaruPage(children: [
      SectionDescription(
          width: kDefaultWidth, text: context.l10n.reportingDescription),
      Padding(
        padding: const EdgeInsets.only(bottom: 20),
        child: SizedBox(
          width: kDefaultWidth,
          child: Row(
            children: [
              Link(
                  url: kUbuntuReportingLink,
                  linkText: context.l10n.reportingLink),
            ],
          ),
        ),
      ),
      YaruSection(width: kDefaultWidth, children: [
        YaruSwitchRow(
          width: kDefaultWidth,
          trailingWidget: Text(context.l10n.reportingActionLabel),
          value: model.reportTechnicalProblems,
          onChanged: (value) => model.reportTechnicalProblems = value,
        ),
        YaruSwitchRow(
          width: kDefaultWidth,
          trailingWidget: Text(context.l10n.reportingUsageActionLabel),
          value: model.sendSoftwareUsageStats,
          onChanged: (value) => model.sendSoftwareUsageStats = value,
        ),
      ])
    ]);
  }
}
