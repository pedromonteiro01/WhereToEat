import 'package:flutter/material.dart';
import 'package:mapbox_navigation/screens/restaurants_map.dart';
import 'package:mapbox_navigation/screens/restaurants_table.dart';
import 'package:mapbox_navigation/screens/qr_codes.dart';
import 'package:mapbox_navigation/screens/qr_code_files/scan.dart';
import 'package:flutter/foundation.dart';

class HomeManagement extends StatefulWidget {
  final String res_name;

  const HomeManagement({Key? key, required this.res_name}) : super(key: key);
  @override
  State<HomeManagement> createState() => _HomeManagementState();
}

class _HomeManagementState extends State<HomeManagement> {
  final List<Widget> _pages = [
    const RestaurantsMap(name: 'null'),
    const RestaurantsTable(),
    const ScanPage(),
  ];
  int _index = 1;

  @override
  void initState() {
    if (widget.res_name != 'null' && widget.res_name != 'start'){
      _index = 0;
      _pages[0] = RestaurantsMap(name: widget.res_name);
    }
    else if (widget.res_name == 'start') {
      _index = 0;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_index],
      bottomNavigationBar: BottomNavigationBar(
        onTap: (selectedIndex) {
          setState(() {
            _index = selectedIndex;
          });
        },
        currentIndex: _index,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.map), label: 'Localizações'),
          BottomNavigationBarItem(
              icon: Icon(Icons.fastfood), label: 'Restaurantes'),
          BottomNavigationBarItem(
              icon: Icon(Icons.qr_code), label: 'QR Codes'),
        ],
      ),
    );
  }
}
