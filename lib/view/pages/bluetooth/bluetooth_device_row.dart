import 'package:bluez/bluez.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:settings/view/pages/bluetooth/bluetooth_device_model.dart';
import 'package:settings/view/pages/bluetooth/bluetooth_device_types.dart';
import 'package:yaru_widgets/yaru_widgets.dart';

class BluetoothDeviceRow extends StatefulWidget {
  const BluetoothDeviceRow({Key? key, required this.removeDevice})
      : super(key: key);

  final AsyncCallback removeDevice;

  static Widget create(
      BuildContext context, BlueZDevice device, AsyncCallback removeDevice) {
    return ChangeNotifierProvider(
      create: (_) => BluetoothDeviceModel(device),
      child: BluetoothDeviceRow(
        removeDevice: removeDevice,
      ),
    );
  }

  @override
  State<BluetoothDeviceRow> createState() => _BluetoothDeviceRowState();
}

class _BluetoothDeviceRowState extends State<BluetoothDeviceRow> {
  late String status;

  @override
  void initState() {
    final model = context.read<BluetoothDeviceModel>();
    model.init();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final model = context.watch<BluetoothDeviceModel>();
    return InkWell(
      borderRadius: BorderRadius.circular(4.0),
      onTap: () => setState(() {
        showDialog(
            context: context,
            builder: (context) => StatefulBuilder(builder: (context, setState) {
                  return AlertDialog(
                    title: Padding(
                      padding:
                          const EdgeInsets.only(right: 8, left: 8, bottom: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: RichText(
                              text: TextSpan(
                                  text: model.name,
                                  style: Theme.of(context).textTheme.headline6),
                              maxLines: 10,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Icon(
                                BluetoothDeviceTypes.getIconForAppearanceCode(
                                    model.appearance)),
                          )
                        ],
                      ),
                    ),
                    content: SizedBox(
                      height: model.errorMessage.isEmpty ? 270 : 320,
                      width: 300,
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            YaruRow(
                                trailingWidget: model.connected
                                    ? const Text('Connected')
                                    : const Text('Disconnected'),
                                actionWidget: Switch(
                                    value: model.connected,
                                    onChanged: (connectRequested) async {
                                      connectRequested
                                          ? await model.connect()
                                          : await model.disconnect();
                                      setState(() {});
                                    })),
                            YaruRow(
                                trailingWidget: const Text('Paired'),
                                actionWidget: Padding(
                                  padding: const EdgeInsets.only(right: 8),
                                  child: Text(model.paired ? 'Yes' : 'No'),
                                )),
                            YaruRow(
                                trailingWidget: const Text('Address'),
                                actionWidget: Padding(
                                  padding: const EdgeInsets.only(right: 8),
                                  child: Text(model.address),
                                )),
                            YaruRow(
                                trailingWidget: const Text('Type'),
                                actionWidget: Padding(
                                  padding: const EdgeInsets.only(right: 8),
                                  child: Text(BluetoothDeviceTypes
                                          .map[model.appearance] ??
                                      'Unkown'),
                                )),
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 16, bottom: 8, right: 8, left: 8),
                              child: SizedBox(
                                width: 300,
                                child: OutlinedButton(
                                    onPressed: () {
                                      if (BluetoothDeviceTypes.isMouse(
                                          model.appearance)) {
                                        // TODO: get route name from model
                                        Navigator.of(context)
                                            .pushNamed('routeName');
                                      }
                                    },
                                    child: const Text('Open device settings')),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8),
                              child: SizedBox(
                                width: 300,
                                child: TextButton(
                                    onPressed: () async {
                                      await model.disconnect();
                                      widget.removeDevice;

                                      Navigator.of(context).pop();
                                    },
                                    child: const Text('Remove device')),
                              ),
                            ),
                            if (model.errorMessage.isNotEmpty)
                              Text(
                                model.errorMessage,
                                style: TextStyle(
                                    color: Theme.of(context).errorColor),
                              )
                          ],
                        ),
                      ),
                    ),
                  );
                }));
      }),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: YaruRow(
            trailingWidget: Text(model.name),
            actionWidget: Text(
              model.connected ? 'connected' : 'disconnected',
              style: TextStyle(
                  color:
                      Theme.of(context).colorScheme.onSurface.withOpacity(0.7)),
            )),
      ),
    );
  }
}
