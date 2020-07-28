import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MyMap extends StatefulWidget {
  @override
  State<MyMap> createState() => MapSampleState();
}

class MapSampleState extends State<MyMap> {
  Completer<GoogleMapController> _controller = Completer();
  final Set<Polyline> _polyline = {};
  final Set<Marker> _markers = {};

  static final _originLatitude=11.066546;
  static final _originLongitude=76.048018;

  static final CameraPosition malappuram = CameraPosition(
    target: LatLng(_originLatitude, _originLongitude),
    zoom: 14.4746,
  );

  static final CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(37.43296265331129, -122.08832357078792),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    plotPolyLine();
  }
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: malappuram,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
        polylines: _polyline,
      ),

    );
  }

  Future<void> _goToTheLake() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
  }
Future<void> plotPolyLine() async {
  var apiKey = "AIzaSyDR07gIkjnjfMhUqqj5WPZ3oUAjoo49wKQ";


 var _destLatitude=11.155136;
 var _destLongitude=75.961785;

  PolylinePoints polylinePoints = PolylinePoints();
  List<PointLatLng> result = await polylinePoints.getRouteBetweenCoordinates(
      apiKey,
      _originLatitude,
      _originLongitude,
      _destLatitude,
      _destLongitude);

  setState(() {
    _polyline.add(Polyline(
      width: 6,
      polylineId: PolylineId("myPolyLineIds"),
      visible: true,
      //latlng is List<LatLng>
      points: result.map((e) => LatLng(e.latitude, e.longitude)).toList(),
      color: Colors.green,
    ));
  });
}

}