import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:mapbox_navigation/helpers/commons.dart';
import 'package:flutter/foundation.dart';

import '../constants/restaurants.dart';
import '../helpers/shared_prefs.dart';
import '../widgets/carousel_card.dart';

class RestaurantsMap extends StatefulWidget {
  final String name;

  const RestaurantsMap({Key? key, required this.name}) : super(key: key);

  @override
  State<RestaurantsMap> createState() => _RestaurantsMapState();
}

class _RestaurantsMapState extends State<RestaurantsMap> {
  // Mapbox related
  LatLng latLng = getLatLngFromSharedPrefs();
  late CameraPosition _initialCameraPosition;
  late MapboxMapController controller;
  List<CameraPosition> _kRestaurantsList = [];
  List<Map> carouselData = [];
  List<Widget> carouselItems = [];
  var counter = 0;

  // Carousel related
  int pageIndex = 0;
  bool accessed = false;

  @override
  void initState() {
    super.initState();
    _initialCameraPosition = CameraPosition(target: latLng, zoom: 15);

    print('TESTAR RESTAURANTES: $restaurants');

    // Calculate the distance and time from data in SharedPreferences
    for (int index = 0; index < restaurants.length; index++) {
      num distance = getDistanceFromSharedPrefs(index) / 1000;
      num duration = getDurationFromSharedPrefs(index) / 60;
      carouselData
          .add({'index': index, 'distance': distance, 'duration': duration, 'name': restaurants[index]['name']});
    }
    //carouselData.sort((a, b) => a['duration'] < b['duration'] ? 0 : 1);

    debugPrint('CAROUSELDATA: $carouselData');

    for (int i=0; i<carouselData.length; i++){
      if (widget.name == carouselData[i]['name']){
        pageIndex = carouselData[i]['index'];
      }
    }
    debugPrint('PAGEINDEX: $pageIndex');

    // Generate the list of carousel widgets
    for(int i=0; i<carouselData.length; i++){
      carouselItems.add(carouselCard(carouselData[i]['index'],
            carouselData[i]['distance'], carouselData[i]['duration']));
      debugPrint('CAROUSELITEMS: ${carouselData[i]['index']}, ${carouselData[i]['name']}');
    }

    // initialize map symbols in the same order as carousel widgets
    for(int i=0; i<carouselData.length; i++){
      _kRestaurantsList.add(CameraPosition(
        target: getLatLngFromRestaurantData(carouselData[i]['index']), 
        zoom: 15));
        debugPrint('LIST: $_kRestaurantsList');
    }
  }

  _addSourceAndLineLayer(int index, bool removeLayer) async {
    // Can animate camera to focus on the item
    controller.animateCamera(
        CameraUpdate.newCameraPosition(_kRestaurantsList[index]));

    // Add a polyLine between source and destination
    Map geometry = getGeometryFromSharedPrefs(carouselData[index]['index']);
    debugPrint('POLYLINE: idx: $index , ${carouselData[index]['index']}, ${carouselData[index]['name']}');
    final _fills = {
      "type": "FeatureCollection",
      "features": [
        {
          "type": "Feature",
          "id": 0,
          "properties": <String, dynamic>{},
          "geometry": geometry,
        },
      ],
    };

    // Remove lineLayer and source if it exists
    if (removeLayer == true) {
      await controller.removeLayer("lines");
      await controller.removeSource("fills");
    }

    // Add new source and lineLayer
    await controller.addSource("fills", GeojsonSourceProperties(data: _fills));
    await controller.addLineLayer(
      "fills",
      "lines",
      LineLayerProperties(
        lineColor: Colors.red.toHexStringRGB(),
        lineCap: "round",
        lineJoin: "round",
        lineWidth: 2,
      ),
    );
  }

  _onMapCreated(MapboxMapController controller) async {
    this.controller = controller;
  }

  _onStyleLoadedCallback() async {
    for (CameraPosition _kRestaurant in _kRestaurantsList) {
      await controller.addSymbol(
        SymbolOptions(
          geometry: _kRestaurant.target,
          iconSize: 0.2,
          iconImage: "assets/icon/food.png",
        ),
      );
    }
    _addSourceAndLineLayer(pageIndex, false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mapa de Restaurantes'),
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
        child: Stack(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.8,
              child: MapboxMap(
                accessToken: dotenv.env['MAPBOX_ACCESS_TOKEN'],
                initialCameraPosition: _initialCameraPosition,
                onMapCreated: _onMapCreated,
                onStyleLoadedCallback: _onStyleLoadedCallback,
                myLocationEnabled: true,
                myLocationTrackingMode: MyLocationTrackingMode.TrackingGPS,
                minMaxZoomPreference: const MinMaxZoomPreference(14, 17),
              ),
            ),
            CarouselSlider(
              items: carouselItems,
              options: CarouselOptions(
                height: 100,
                viewportFraction: 0.6,
                initialPage: pageIndex,
                enableInfiniteScroll: false,
                scrollDirection: Axis.horizontal,
                onPageChanged:
                    (int index, CarouselPageChangedReason reason) async {
                  setState(() {
                    pageIndex = index;
                    debugPrint('CAROUSELINDEX: $index');
                  });
                  _addSourceAndLineLayer(pageIndex, true);
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          controller.animateCamera(
              CameraUpdate.newCameraPosition(_initialCameraPosition));
        },
        child: const Icon(Icons.my_location),
      ),
    );
  }
}
