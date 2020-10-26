import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';


class MapMark extends StatefulWidget {
  MapMark();

  @override
  _MapMarkState createState() => _MapMarkState();
}

class _MapMarkState extends State<MapMark> {
  Completer<GoogleMapController> _controller = Completer();
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  static const routeName = '/country-map';
  final Set<Marker> _markers = {};

  @override
  Widget build(BuildContext context) {
    final Map country = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange[200],
        title: Text("retour"),
      ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(40.688841, -74.044015),
          zoom: 11,
        ),
        markers: _markers,
       // initialCameraPosition: _theSecretLocation,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
        onTap: _handleTap,
      ),
      //  markers: _markers.values.toSet(),
      );

  }
  _handleTap(LatLng point) async{
    setState((){
      _markers.clear();
      _markers.add(Marker(
        markerId: MarkerId(point.toString()),
        position: point,
        infoWindow: InfoWindow(
          title: 'I am a marker',
        ),
        icon:
        BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueMagenta),
      ));
      print(_markers.elementAt(0).position.latitude);
      _saveMark(_markers.elementAt(0).position.longitude,_markers.elementAt(0).position.latitude);
        });}


  Future<void> _saveMark(double longitude, double latitude) async {
    final SharedPreferences prefs = await _prefs;

    setState(() {
      prefs.setString("longitude", longitude.toString()).then((bool success) {
        return longitude.toString();
      });
      prefs.setString("latitude", latitude.toString()).then((bool success) {
        return latitude.toString();
      });
    });
  }
}