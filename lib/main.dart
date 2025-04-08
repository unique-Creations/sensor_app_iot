import 'package:flutter/material.dart';
import 'package:sensor_app_iot/screens/devicelist.dart';
import 'package:sensor_app_iot/screens/settings.dart';

void main() {
  runApp(SenseApp());
}

class SenseApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sense',
      theme: ThemeData(
        primarySwatch: Colors.green,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Sense')),
      body: _buildBody(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.spa), label: 'Plants'),
          BottomNavigationBarItem(icon: Icon(Icons.spa), label: 'Devices'),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
    );
  }

  Widget _buildBody() {
    switch (_selectedIndex) {
      case 0:
        return PlantListScreen();
      case 1:
        return DeviceListScreen();
      case 2:
        return SettingsScreen();
      default:
        return PlantListScreen();
    }
  }
}

class PlantListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Mock plant data
    final plants = [
      {
        'name': 'Fiddle Leaf Fig',
        'moisture': 65,
        'lastWatered': '2 days ago',
        'status': 'Healthy',
      },
      {
        'name': 'Snake Plant',
        'moisture': 30,
        'lastWatered': '5 days ago',
        'status': 'Needs water',
      },
      {
        'name': 'Monstera',
        'moisture': 50,
        'lastWatered': '3 days ago',
        'status': 'Healthy',
      },
    ];

    return ListView.builder(
      padding: EdgeInsets.all(16.0),
      itemCount: plants.length,
      itemBuilder: (context, index) {
        final plant = plants[index];

        return Card(
          margin: EdgeInsets.only(bottom: 16.0),
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  plant['name'] as String,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Moisture: ${plant['moisture']}%'),
                          SizedBox(height: 4),
                          LinearProgressIndicator(
                            value: (plant['moisture'] as int) / 100,
                            backgroundColor: Colors.grey[200],
                            valueColor: AlwaysStoppedAnimation<Color>(
                              (plant['moisture'] as int) < 40
                                  ? Colors.red
                                  : Colors.green,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text('Last watered:'),
                        Text(plant['lastWatered'] as String),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 8),
                Chip(
                  label: Text(plant['status'] as String),
                  backgroundColor:
                      (plant['status'] == 'Healthy')
                          ? Colors.green[100]
                          : Colors.red[100],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
