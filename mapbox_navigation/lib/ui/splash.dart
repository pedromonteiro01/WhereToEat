import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:mapbox_navigation/constants/restaurants.dart';
import 'package:mapbox_navigation/main.dart';
import 'package:mapbox_navigation/constants/restaurants.dart';

import '../helpers/directions_handler.dart';
import '../screens/home_management.dart';
import 'dart:io';

import 'package:firebase_database/firebase_database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  
  @override
  void initState() {
    super.initState();
    final _dbRef = FirebaseDatabase.instance.ref();
    var tableRef = _dbRef.child("SampleData");
    myFunction(_dbRef);
    initializeLocationAndSave();
  }

  void myFunction(_dbRef) async{
    _dbRef.once().then((DatabaseEvent databaseEvent) {
      print("Data " + databaseEvent.snapshot.value.toString());
      String s = '[' + databaseEvent.snapshot.value.toString() + ']';
      List<dynamic> map = jsonDecode(s);
      List m = map;
      print('LENGTH ' + m.length.toString());
      for (int i = 0; i< m.length; i++){
        print('FODASE '+ map[i].toString());
      }
    });
}

  void initializeLocationAndSave() async {
    // Ensure all permissions are collected for Locations
    Location _location = Location();
    bool? _serviceEnabled;
    PermissionStatus? _permissionGranted;

    getRes();
    sleep(Duration(seconds: 1));
    
    _serviceEnabled = await _location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await _location.requestService();
    }

    _permissionGranted = await _location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await _location.requestPermission();
    }

    // Get capture the current user location
    LocationData _locationData = await _location.getLocation();
    LatLng currentLatLng =
        LatLng(_locationData.latitude!, _locationData.longitude!);
        //LatLng(40.633067, -8.658986);

    // Store the user location in sharedPreferences
    sharedPreferences.setDouble('latitude', _locationData.latitude!);
    sharedPreferences.setDouble('longitude', _locationData.longitude!);

    // Get and store the directions API response in sharedPreferences
    for (int i = 0; i < restaurants.length; i++) {
      Map modifiedResponse = await getDirectionsAPIResponse(currentLatLng, i);
      saveDirectionsAPIResponse(i, json.encode(modifiedResponse));
    }

    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => HomeManagement(res_name: 'start',)));
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.black,
      child: Center(child: Image.asset('assets/image/logo.png', )),
    );
  }
}
