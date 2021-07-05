import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:settings/view/pages/appearance/appearance_page.dart';
import 'package:settings/view/pages/mouse_and_touchpad/mouse_and_touchpad_page.dart';
import 'package:settings/view/pages/notifications_page.dart/notifications_page.dart';
import 'package:settings/view/widgets/page_item.dart';

final pageItems = <PageItem>[
  PageItem(title: 'WIFI', iconData: Icons.wifi, builder: (_) => Text('WIFI')),
  PageItem(
      title: 'Network',
      iconData: Icons.settings_ethernet,
      builder: (_) => Text('Network')),
  PageItem(
      title: 'Bluetooth',
      iconData: Icons.bluetooth,
      builder: (_) => Text('Bluetooth')),
  PageItem(
      title: 'Wallpaper',
      iconData: Icons.wallpaper,
      builder: (_) => Text('Wallpaper')),
  PageItem(
      title: 'Appearance',
      iconData: Icons.theater_comedy,
      builder: (_) => AppearancePage()),
  PageItem(
      title: 'Notifications',
      iconData: Icons.notifications,
      builder: (_) => NotificationsPage()),
  PageItem(
      title: 'Search', iconData: Icons.search, builder: (_) => Text('Search')),
  PageItem(title: 'Apps', iconData: Icons.apps, builder: (_) => Text('Apps')),
  PageItem(
      title: 'Security',
      iconData: Icons.lock,
      builder: (_) => Text('Security')),
  PageItem(
      title: 'Online Accounts',
      iconData: Icons.cloud,
      builder: (_) => Text('Online Accounts')),
  PageItem(
      title: 'Sharing', iconData: Icons.share, builder: (_) => Text('Sharing')),
  PageItem(
      title: 'Sound',
      iconData: Icons.music_note,
      builder: (_) => Text('Sound')),
  PageItem(
      title: 'Energy', iconData: Icons.power, builder: (_) => Text('Energy')),
  PageItem(
      title: 'Displays',
      iconData: Icons.monitor,
      builder: (_) => Text('Displays')),
  PageItem(
      title: 'Mouse and touchpad',
      iconData: Icons.mouse,
      builder: (_) => MouseAndTouchpadPage()),
  PageItem(
      title: 'Keyboard shortcuts',
      iconData: Icons.keyboard,
      builder: (_) => Text('Keyboard shortcuts')),
  PageItem(
      title: 'Printers',
      iconData: Icons.print,
      builder: (_) => Text('Printers')),
  PageItem(
      title: 'Shared devices',
      iconData: Icons.usb,
      builder: (_) => Text('Shared devices')),
  PageItem(
      title: 'Color',
      iconData: Icons.settings_display,
      builder: (_) => Text('Color')),
  PageItem(
      title: 'Region and language',
      iconData: Icons.language,
      builder: (_) => Text('Region and language')),
  PageItem(
      title: 'Accessability',
      iconData: Icons.settings_accessibility,
      builder: (_) => Text('Accessability')),
  PageItem(
      title: 'Users',
      iconData: Icons.supervisor_account,
      builder: (_) => Text('Users')),
  PageItem(
      title: 'Preferred Apps',
      iconData: Icons.star,
      builder: (_) => Text('Preferred Apps')),
  PageItem(
      title: 'Date and time',
      iconData: Icons.access_time,
      builder: (_) => Text('Date and time')),
  PageItem(title: 'Info', iconData: Icons.info, builder: (_) => Text('Info')),
];
