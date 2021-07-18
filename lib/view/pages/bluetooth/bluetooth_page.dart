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
                    children = snapshot.data!.map((e) {
                      final status = e.connected ? 'connected' : 'disconnected';

                      return SettingsRow(
                          actionLabel: e.name,
                          secondChild: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              status,
                              style: TextStyle(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onSurface
                                      .withOpacity(0.7)),
                            ),
                          ));
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
