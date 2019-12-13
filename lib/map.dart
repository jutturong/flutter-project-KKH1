import 'dart:async';
import 'dart:collection';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:poly/poly.dart' as ckPoly;
import 'package:rflutter_alert/rflutter_alert.dart';
//import 'package:flutter_login_page_ui/main.dart';

var myKey = "AIzaSyAgKIsFE2QTjmhH_Lq3JVtaXPaKK2Ug_Ds";
MapView mapView;

class Map extends StatefulWidget {
  Completer<GoogleMapController> _controller = Completer();

//  Map<String,double>  userLocation;
  GoogleMapController mapController;

  @override
  _MapState createState() => _MapState();
}

class _MapState extends State<Map> {
//  double num_latitude;
//  double num_longitude;
//  String str_ans = "";

  var currentLocation = LocationData;
  var location = new Location();
  //พื้นที่ภายในโรงพยาบาลคือ 16.4306583, 102.8487617

  double cur_latitude = 0;
  double cur_longitude = 0;

  String str_ans;

  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  int _index = 0;

  //https://pub.dev/packages/location
  void _getlocation() {
    location.onLocationChanged().listen((LocationData currentLocation) {
      setState(() {
        cur_latitude = currentLocation.latitude;
        cur_longitude = currentLocation.longitude;
      });
    });
  }

  int _cIndex = 0;

  void _incrementTab(index) {
    setState(() {
      _cIndex = index;
    });
  }

  void _messagebox() {
    Alert(
      context: context,
//      style: alertStyle,
      type: AlertType.info,
      title: "FilledStacks",
      desc: "FilledStacks.com has the best Flutter tutorials",
      buttons: [
        DialogButton(
          child: Text(
            "COOL",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () => Navigator.pop(context),
          color: Color.fromRGBO(91, 55, 185, 1.0),
          radius: BorderRadius.circular(10.0),
        ),
      ],
    ).show();
  }

  void initState() {
    _getlocation();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
//    print(' select : ' + _index.toString());

    List<Point<num>> l = [
//      Point(18.4851825, 73.8498851),
//      Point(18.4849214, 73.8498675),
//      Point(18.4855965, 73.8520493),
//      Point(18.4859711, 73.8512369),
//      Point(18.4857828, 73.8500299),
//      Point(18.4851825, 73.8498851)

      Point(16.428891, 102.850693),
      Point(16.428899, 102.850758),
      Point(16.429585, 102.850776),
      Point(16.429574, 102.850021),
      Point(16.429635, 102.849779),
      Point(16.431335, 102.849790),
      Point(16.431419, 102.849723),

      Point(16.431429, 102.848435),
      Point(16.430633, 102.848444),
      Point(16.430744, 102.846771), //ประตูข้าง

      Point(16.430698, 102.846760),
      Point(16.430665, 102.847132),
      Point(16.429981, 102.846998),
      Point(16.429971, 102.847251),
      Point(16.430233, 102.847303),
      Point(16.430219, 102.847951),
      Point(16.428882, 102.847924),
      Point(16.428891, 102.850693),
    ];

    if (cur_latitude != null && cur_longitude != null) {
      var testPolygon = ckPoly.Polygon(l);
      Point point_current = Point(cur_latitude, cur_longitude);
      var checkInKKH = testPolygon.isPointInside(point_current);
      if (checkInKKH == true) {
        str_ans = "อยู่ 'ใน' พื้นที่ทำงาน";
      } else {
        str_ans = "อยู่ 'นอก' พื้นที่ทำงาน";
      }

//      _messagebox();
    }

//    return Container();
    return MaterialApp(
      title: 'My App demo arm',
      home: Scaffold(
        appBar: AppBar(
          title: Text(cur_latitude.toString() +
              ',' +
              cur_longitude.toString() +
              ',' +
              str_ans),
        ),
        body: GoogleMap(
          mapType: MapType.normal,
//          mapType: MapType.satellite,
//          mapType: MapType.terrain,
          myLocationEnabled: true,
//            mapType: MapType.hybrid,
          initialCameraPosition: CameraPosition(
            bearing: 0,
            tilt: 16.4291013,
            target: LatLng(16.4291013, 102.8487086),
            zoom: 17.2,
          ),
          scrollGesturesEnabled: false, //fix   ตำแหน่ง
          zoomGesturesEnabled: true,
          compassEnabled: true,

          markers: {
            Marker(
              markerId: MarkerId("ตำแหน่งของคุณ"),
              position: LatLng(
                cur_latitude,
                cur_longitude,
              ),
              icon: BitmapDescriptor.defaultMarker,
              infoWindow: InfoWindow(
                  title: 'ตำแหน่ง่ของคุณ',
                  snippet: '' +
                      cur_latitude.toString() +
                      ',' +
                      cur_longitude.toString()),
            )
          },

          polylines: {
            new Polyline(
              polylineId: PolylineId("KKH"),
              color: Colors.red[400],
              width: 3,
              consumeTapEvents: true,
              visible: true,
              points: [
                LatLng(16.428891, 102.850693),
                LatLng(16.428899, 102.850758),
                LatLng(16.429585, 102.850776),
                LatLng(16.429574, 102.850021),
                LatLng(16.429635, 102.849779),
                LatLng(16.431335, 102.849790),
                LatLng(16.431419, 102.849723),

                LatLng(16.431429, 102.848435),
                LatLng(16.430633, 102.848444),
                LatLng(16.430744, 102.846771), //ประตูข้าง

                LatLng(16.430698, 102.846760),
                LatLng(16.430665, 102.847132),
                LatLng(16.429981, 102.846998),
                LatLng(16.429971, 102.847251),
                LatLng(16.430233, 102.847303),
                LatLng(16.430219, 102.847951),
                LatLng(16.428882, 102.847924),
                LatLng(16.428891, 102.850693),
              ],
            )
          },
        ),
        floatingActionButton: FloatingActionButton(
          tooltip: 'ลงเวลาทำงาน',
          backgroundColor: Colors.black,
          child: Icon(
            Icons.person_pin_circle,
            color: Colors.white,
            size: 35.0,
          ),
          onPressed:
//              _incrementCounter, // <-- the state changed on button tap event
              _getlocation,
        ),
        bottomNavigationBar: BottomNavigationBar(
          onTap: (int newindex) {
//            print(' nav ' + newindex.toString());
            switch (newindex) {
              case 0:

//                Navigator.push(context,
//                    MaterialPageRoute(builder: (context) => Mainpage()));

                Navigator.pop(context);

                break;
              case 1:
                Navigator.pop(context);
            }
          },
          currentIndex: 0,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.backspace),
              title: Text('Back'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.lock_open),
              title: Text('Logout'),
            ),
          ],
        ),
      ),
    );
  }
}
