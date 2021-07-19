import 'package:flutter/material.dart';
import 'package:settings/view/widgets/settings_row.dart';
import 'package:settings/view/widgets/settings_section.dart';
import 'package:bluez/bluez.dart';

class BluetoothPage extends StatefulWidget {
  const BluetoothPage({Key? key}) : super(key: key);

  @override
  State<BluetoothPage> createState() => _BluetoothPageState();
}

class _BluetoothPageState extends State<BluetoothPage> {
  late BlueZClient client;

  @override
  void initState() {
    client = BlueZClient();
    super.initState();
  }

  @override
  Future<void> dispose() async {
    super.dispose();
    await client.close();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> children;

    return Column(
      children: [
        SizedBox(
          width: 500,
          child: SettingsSection(headline: 'Bluetooth devices', children: [
            FutureBuilder<List<BlueZDevice>>(
                future: getDevices(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    children = snapshot.data!.map((device) {
                      return BluetoothDeviceRow(device: device);
                    }).toList();

                    return ListView(
                      shrinkWrap: true,
                      children: children,
                    );
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                })
          ]),
        )
      ],
    );
  }

  Future<List<BlueZDevice>> getDevices() async {
    await client.connect();

    return client.devices;
  }
}

class BluetoothDeviceRow extends StatelessWidget {
  const BluetoothDeviceRow({
    Key? key,
    required this.device,
  }) : super(key: key);

  final BlueZDevice device;

  @override
  Widget build(BuildContext context) {
    final status = device.connected ? 'connected' : 'disconnected';

    return InkWell(
      borderRadius: BorderRadius.circular(4.0),
      onTap: () => showSimpleDeviceDialog(context),
      child: SettingsRow(
          actionLabel: device.name,
          secondChild: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              status,
              style: TextStyle(
                  color:
                      Theme.of(context).colorScheme.onSurface.withOpacity(0.7)),
            ),
          )),
    );
  }

  void showSimpleDeviceDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (_) => StatefulBuilder(builder: (context, setState) {
              return AlertDialog(
                title: Text(device.name),
                content: SizedBox(
                  height: 250,
                  width: 300,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        SettingsRow(
                            actionLabel:
                                device.connected ? 'Connected' : 'Disconnected',
                            secondChild: Switch(
                                value: device.connected,
                                onChanged: (newValue) async {
                                  device.connected
                                      ? await device.disconnect()
                                      : await device.connect();
                                  setState(() {});
                                })),
                        SettingsRow(
                            actionLabel: device.paired ? 'Paired' : 'Unpaired',
                            secondChild: Switch(
                                value: device.paired,
                                onChanged: (newValue) async {
                                  device.paired
                                      ? await device.cancelPairing()
                                      : await device.pair();
                                  setState(() {});
                                })),
                        SettingsRow(
                            actionLabel: 'Address',
                            secondChild: Text(device.address)),
                        SettingsRow(
                            actionLabel: 'Type',
                            secondChild: Text(device.appearance.toString()))
                      ],
                    ),
                  ),
                ),
              );
            }));
  }
}
