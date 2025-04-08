import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _isScanning = false;
  List<String> _foundDevices = [];

  void _showScanningDialog() {
    setState(() {
      _isScanning = true;
      _foundDevices = [];
    });

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (_isScanning) {
            Future.delayed(Duration(seconds: 2), () {
              if (mounted) {
                setState(() {
                  _foundDevices = [
                    "SoilMoistureSensor1",
                    "SoilMoistureSensor2",
                    "SoilMoistureSensor3",
                  ];
                  _isScanning = false;
                });
              }
            });
          }
        });

        return AlertDialog(
          title: Text(
            _isScanning ? 'Scanning for Devices' : 'Available Devices',
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (_isScanning)
                Container(
                  height: 100,
                  alignment: Alignment.center,
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(),
                      SizedBox(height: 16),
                      Text('Looking for nearby devices...'),
                    ],
                  ),
                )
              else if (_foundDevices.isEmpty)
                const Text('No Devices found. Try scanning again.')
              else
                Container(
                  height: 200,
                  width: double.maxFinite,
                  child: ListView.builder(
                    itemCount: _foundDevices.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(_foundDevices[index]),
                        trailing: ElevatedButton(
                          child: const Text('Connect'),
                          onPressed: () {
                            Navigator.pop(context);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  'Connecting to ${_foundDevices[index]}...',
                                ),
                              ),
                            );
                          },
                        ),
                      );
                    },
                  ),
                ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
            if (!_isScanning)
              TextButton(
                onPressed: () {
                  setState(() {
                    _isScanning = true;
                    _foundDevices = [];
                  });
                },
                child: const Text('Scan Again'),
              ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: ListView(
        children: [
          ListTile(
            leading: const Icon(Icons.wifi_find),
            title: const Text('Scan for Devices'),
            subtitle: const Text('Find and connect to available devices'),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {
              _showScanningDialog();
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.devices),
            title: const Text('Manage Devices'),
            subtitle: const Text('View and edit connected devices'),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {
              // Navigate to device management screen
            },
          ),
        ],
      ),
    );
  }
}
