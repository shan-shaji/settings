import 'package:bluez/bluez.dart';
import 'package:flutter/material.dart';
import 'package:safe_change_notifier/safe_change_notifier.dart';
import 'package:yaru_icons/yaru_icons.dart';

const yaruIcons = <String, IconData>{
  'ac-adapter': YaruIcons.power,
  'audio-card': YaruIcons.audio,
  'audio-headphones': YaruIcons.headphones,
  'audio-headset': YaruIcons.headset,
  'audio-input-microphone': YaruIcons.microphone,
  'audio-speakers': YaruIcons.audio,
  'auth-fingerprint': YaruIcons.fingerprint,
  'battery': YaruIcons.battery_level_100,
  'camera-photo': YaruIcons.camera_photo,
  'camera-video': YaruIcons.camera_video,
  'computer': YaruIcons.computer,
  'drive-harddisk': YaruIcons.drive_harddisk,
  'drive-harddisk-solidstate': YaruIcons.drive_solidstatedisk,
  'drive-harddisk-usb': YaruIcons.drive_harddisk_usb,
  'drive-multidisk': YaruIcons.drive_multidisk,
  'drive-optical': YaruIcons.drive_optical,
  'drive-removable-media': YaruIcons.drive_removable_media,
  'input-dialpad': YaruIcons.input_dialpad,
  'input-gaming': YaruIcons.input_gaming,
  'input-keyboard': YaruIcons.input_keyboard,
  'input-mouse': YaruIcons.input_mouse,
  'input-touchpad': YaruIcons.input_touchpad,
  'input-tablet': YaruIcons.input_tablet,
  'media-flash': YaruIcons.media_flash,
  'media-floppy': YaruIcons.media_floppy,
  'media-optical': YaruIcons.media_optical,
  'media-removable': YaruIcons.media_removable,
  'media-tape': YaruIcons.media_tape,
  'multimedia-player': YaruIcons.multimedia_player,
  'network-wired': YaruIcons.network_wired,
  'network-wireless': YaruIcons.network_wireless,
  'pda': YaruIcons.smartphone,
  'phone': YaruIcons.phone_old,
  'printer': YaruIcons.printer,
  'printer-network': YaruIcons.printer_network,
  'video-display': YaruIcons.desktop_display,
  'preferences-desktop-keyboard': YaruIcons.input_keyboard,
  'touchpad-disabled': YaruIcons.input_touchpad,
  'thunderbolt': YaruIcons.thunderbolt
};

class BluetoothDeviceModel extends SafeChangeNotifier {
  final BlueZDevice _device;
  late bool connected;
  late String name;
  late int appearance;
  late int deviceClass;
  late String alias;
  late bool blocked;
  late String address;
  late bool paired;
  late String errorMessage;
  late bool connecting;
  late BlueZAdapter adapter;
  late BlueZAddressType addressType;
  late String icon;
  late bool legacyPairing;
  late bool wakeAllowed;
  late int txPower;
  late List<BlueZGattService> gattServices;

  BluetoothDeviceModel(this._device) {
    updateFromClient();
    errorMessage = '';
  }

  void init() {
    _device.propertiesChanged.listen((event) {
      updateFromClient();
      notifyListeners();
    });
  }

  void updateFromClient() {
    connected = _device.connected;
    name = _device.name;
    appearance = _device.appearance;
    alias = _device.alias;
    blocked = _device.blocked;
    address = _device.address;
    paired = _device.paired;
    adapter = _device.adapter;
    addressType = _device.addressType;
    icon = _device.icon;
    legacyPairing = _device.legacyPairing;
    wakeAllowed = _device.wakeAllowed;
    txPower = _device.txPower;
    gattServices = _device.gattServices;
  }

  Future<void> connect() async {
    errorMessage = '';
    if (!_device.paired) {
      await _device.pair().catchError((ioError) {
        errorMessage = ioError.toString();
      });
      notifyListeners();
    }

    await _device.connect().catchError((ioError) {
      errorMessage = ioError.toString();
    });
    paired = _device.paired;
    connected = _device.connected;
    notifyListeners();
  }

  Future<void> disconnect() async {
    errorMessage = '';
    await _device.disconnect().catchError((ioError) {
      errorMessage = ioError.toString();
    });
    connected = _device.connected;
    notifyListeners();
  }
}
