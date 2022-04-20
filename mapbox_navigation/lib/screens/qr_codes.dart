import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:mapbox_navigation/helpers/commons.dart';

import '../constants/restaurants.dart';
import '../helpers/shared_prefs.dart';
import '../widgets/carousel_card.dart';

import './qr_code_files/generate.dart';
import './qr_code_files/scan.dart';

class QRCodes extends StatefulWidget {
  const QRCodes({Key? key}) : super(key: key);

  @override
  State<QRCodes> createState() => _QRCodesState();
}

class _QRCodesState extends State<QRCodes> {
  
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.all(50.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Image(image: NetworkImage("https://media.istockphoto.com/vectors/qr-code-scan-phone-icon-in-comic-style-scanner-in-smartphone-vector-vector-id1166145556")),
            flatButton("Scan QR CODE", ScanPage(), context),
            SizedBox(height: 20.0,),
          ],
        ),
      ),
    );
  }
  
}

Widget flatButton(String text, Widget widget, BuildContext context) {
    return TextButton(
      style: ButtonStyle(
      ), onPressed: () { 
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => widget));
       }, child: Text(text),
  );
  }


