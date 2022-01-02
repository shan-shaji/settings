import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:settings/view/pages/keyboard/input_source_model.dart';
import 'package:yaru_widgets/yaru_widgets.dart';

class InputSourceSection extends StatelessWidget {
  const InputSourceSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final inputSourceModel = context.watch<InputSourceModel>();

    return Column(children: [
      YaruSection(headline: 'Change input sources', children: [
        RadioListTile(
            title: const Text('Use the same input for all windows'),
            value: false,
            groupValue: inputSourceModel.perWindow,
            onChanged: (_) => inputSourceModel.perWindow = false),
        RadioListTile(
            title: const Text('Give each window its own input source'),
            value: true,
            groupValue: inputSourceModel.perWindow,
            onChanged: (_) => inputSourceModel.perWindow = true)
      ])
    ]);
  }
}
