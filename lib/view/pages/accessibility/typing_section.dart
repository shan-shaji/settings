import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:settings/constants.dart';
import 'package:settings/l10n/l10n.dart';
import 'package:settings/view/pages/accessibility/accessibility_model.dart';
import 'package:settings/view/pages/settings_simple_dialog.dart';
import 'package:settings/view/settings_section.dart';
import 'package:yaru_icons/yaru_icons.dart';
import 'package:yaru_settings/yaru_settings.dart';
import 'package:yaru_widgets/yaru_widgets.dart';

class TypingSection extends StatelessWidget {
  const TypingSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = context.watch<AccessibilityModel>();
    return SettingsSection(
      width: kDefaultWidth,
      headline: Text(context.l10n.typing),
      children: [
        YaruSwitchRow(
          trailingWidget: Text(context.l10n.screenKeyboard),
          value: model.screenKeyboard,
          onChanged: (value) => model.setScreenKeyboard(value),
        ),
        const _RepeatKeys(),
        const _CursorBlinking(),
        const _TypingAssist(),
      ],
    );
  }
}

class _RepeatKeys extends StatelessWidget {
  const _RepeatKeys({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = context.watch<AccessibilityModel>();
    return YaruExtraOptionRow(
      iconData: YaruIcons.gear,
      actionLabel: context.l10n.repeatKeys,
      actionDescription: context.l10n.repeatKeysDescription,
      value: model.keyboardRepeat,
      onChanged: (value) => model.setKeyboardRepeat(value),
      onPressed: () => showDialog(
        context: context,
        builder: (_) => ChangeNotifierProvider.value(
          value: model,
          child: const _RepeatKeysSettings(),
        ),
      ),
    );
  }
}

class _RepeatKeysSettings extends StatelessWidget {
  const _RepeatKeysSettings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = context.watch<AccessibilityModel>();
    return SettingsSimpleDialog(
      width: kDefaultWidth,
      title: context.l10n.repeatKeys,
      closeIconData: YaruIcons.window_close,
      children: [
        YaruSliderRow(
          actionLabel: context.l10n.delay,
          actionDescription: context.l10n.repeatKeyDelayDescription,
          value: model.delay,
          min: 100,
          max: 2000,
          defaultValue: 500,
          onChanged: (value) => model.setDelay(value),
        ),
        YaruSliderRow(
          actionLabel: context.l10n.interval,
          actionDescription: context.l10n.intervalDelayDescription,
          value: model.interval,
          min: 0,
          max: 110,
          defaultValue: 30,
          onChanged: (value) => model.setInterval(value),
        ),
      ],
    );
  }
}

class _CursorBlinking extends StatelessWidget {
  const _CursorBlinking({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = context.watch<AccessibilityModel>();
    return YaruExtraOptionRow(
      iconData: YaruIcons.gear,
      actionLabel: context.l10n.cursorBlinking,
      actionDescription: context.l10n.cursorBlinkingDescription,
      value: model.cursorBlink,
      onChanged: (value) => model.setCursorBlink(value),
      onPressed: () => showDialog(
        context: context,
        builder: (_) => ChangeNotifierProvider.value(
          value: model,
          child: const _CursorBlinkingSettings(),
        ),
      ),
    );
  }
}

class _CursorBlinkingSettings extends StatelessWidget {
  const _CursorBlinkingSettings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = context.watch<AccessibilityModel>();
    return SettingsSimpleDialog(
      width: kDefaultWidth,
      title: context.l10n.cursorBlinking,
      closeIconData: YaruIcons.window_close,
      children: [
        YaruSliderRow(
          actionLabel: context.l10n.cursorBlinkTime,
          actionDescription: context.l10n.cursorBlinkTimeDescription,
          min: 100,
          max: 2500,
          defaultValue: 1200,
          value: model.cursorBlinkTime,
          onChanged: (value) => model.setCursorBlinkTime(value),
        ),
      ],
    );
  }
}

class _TypingAssist extends StatelessWidget {
  const _TypingAssist({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = context.watch<AccessibilityModel>();

    return YaruTile(
      enabled: model.typingAssistAvailable,
      title: Text(context.l10n.typingAssistAccessX),
      trailing: Row(
        children: [
          Text(model.typingAssistString),
          const SizedBox(width: 24.0),
          SizedBox(
            width: 40,
            height: 40,
            child: OutlinedButton(
              style: OutlinedButton.styleFrom(padding: const EdgeInsets.all(0)),
              onPressed: () => showDialog(
                context: context,
                builder: (_) => ChangeNotifierProvider.value(
                  value: model,
                  child: const _TypingAssistSettings(),
                ),
              ),
              child: const Icon(YaruIcons.gear),
            ),
          ),
        ],
      ),
    );
  }
}

class _TypingAssistSettings extends StatelessWidget {
  const _TypingAssistSettings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = context.watch<AccessibilityModel>();
    return SettingsSimpleDialog(
      width: kDefaultWidth,
      title: context.l10n.typingAssist,
      closeIconData: YaruIcons.window_close,
      children: [
        YaruSwitchRow(
          trailingWidget: Text(context.l10n.enableByKeyboard),
          actionDescription: context.l10n.enableByKeyboardDescription,
          value: model.keyboardEnable,
          onChanged: (value) => model.setKeyboardEnable(value),
        ),
        YaruSwitchRow(
          trailingWidget: Text(context.l10n.stickyKeys),
          actionDescription: context.l10n.stickyKeysDescription,
          value: model.stickyKeys,
          onChanged: (value) => model.setStickyKeys(value),
        ),
        const _StickyKeysSettings(),
        YaruSwitchRow(
          trailingWidget: Text(context.l10n.slowKeys),
          actionDescription: context.l10n.slowKeysDescription,
          value: model.slowKeys,
          onChanged: (value) => model.setSlowKeys(value),
        ),
        const _SlowKeysSettings(),
        YaruSwitchRow(
          trailingWidget: Text(context.l10n.bounceKeys),
          actionDescription: context.l10n.bounceKeysDescription,
          value: model.bounceKeys,
          onChanged: (value) => model.setBounceKeys(value),
        ),
        const _BounceKeysSettings(),
      ],
    );
  }
}

class _StickyKeysSettings extends StatelessWidget {
  const _StickyKeysSettings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = context.watch<AccessibilityModel>();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        children: [
          YaruCheckboxRow(
            enabled: model.stickyKeys ?? false,
            value: model.stickyKeysTwoKey ?? false,
            onChanged: (value) => model.setStickyKeysTwoKey(value!),
            text: context.l10n.stickyKeysTwoKeysOption,
          ),
          YaruCheckboxRow(
            enabled: model.stickyKeys ?? false,
            value: model.stickyKeysBeep ?? false,
            onChanged: (value) => model.setStickyKeysBeep(value!),
            text: context.l10n.stickyKeysBeepModifierOption,
          ),
        ],
      ),
    );
  }
}

class _SlowKeysSettings extends StatelessWidget {
  const _SlowKeysSettings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = context.watch<AccessibilityModel>();
    return Padding(
      padding: const EdgeInsets.only(left: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            height: 56,
            child: YaruSliderRow(
              enabled: model.slowKeys ?? false,
              actionLabel: context.l10n.acceptanceDelay,
              value: model.slowKeysDelay,
              min: 0,
              max: 500,
              defaultValue: 300,
              onChanged: model.setSlowKeysDelay,
            ),
          ),
          YaruCheckboxRow(
            enabled: model.slowKeys ?? false,
            value: model.slowKeysBeepPress ?? false,
            onChanged: (value) => model.setSlowKeysBeepPress(value!),
            text: context.l10n.stickyKeysBeepKeyOption,
          ),
          YaruCheckboxRow(
            enabled: model.slowKeys ?? false,
            value: model.slowKeysBeepAccept ?? false,
            onChanged: (value) => model.setSlowKeysBeepAccept(value!),
            text: context.l10n.stickyKeysBeepKeyAcceptedOption,
          ),
          YaruCheckboxRow(
            enabled: model.slowKeys ?? false,
            value: model.slowKeysBeepReject ?? false,
            onChanged: (value) => model.setSlowKeysBeepReject(value!),
            text: context.l10n.stickyKeysBeepKeyRejectedOption,
          ),
        ],
      ),
    );
  }
}

class _BounceKeysSettings extends StatelessWidget {
  const _BounceKeysSettings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = context.watch<AccessibilityModel>();
    return Padding(
      padding: const EdgeInsets.only(left: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            height: 56,
            child: YaruSliderRow(
              enabled: model.bounceKeys ?? false,
              actionLabel: context.l10n.acceptanceDelay,
              value: model.bounceKeysDelay,
              min: 0,
              max: 900,
              defaultValue: 300,
              onChanged: model.setBounceKeysDelay,
            ),
          ),
          YaruCheckboxRow(
            enabled: model.bounceKeys ?? false,
            value: model.bounceKeysBeepReject ?? false,
            onChanged: (value) => model.setBounceKeysBeepReject(value!),
            text: context.l10n.stickyKeysBeepKeyRejectedOption,
          ),
        ],
      ),
    );
  }
}
