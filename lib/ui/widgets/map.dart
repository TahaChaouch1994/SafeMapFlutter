import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:safemap/services/acceuilservice.dart';
import 'package:safemap/ui/home_screen.dart';
import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';


class MapGoogle extends StatefulWidget {
  MapGoogle();

  @override
  _MapGoogle createState() => _MapGoogle();
}

class _MapGoogle extends State<MapGoogle> {

  final Map<String, Marker> _markers = {};
  LatLng currentPostion1 = LatLng(37.4219983, -122.084);
  var oneSec = const Duration(seconds: 1);
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  AcceuilService as = new AcceuilService();
  final Set<Marker> _markers2 = {};
  LatLng point;



  @override
  void initState() {
    super.initState();
    _getLocation();

    getMark();
  }

  // Widget Mapgoogle(_markers, _getLocation) {







  @override
  Widget build(BuildContext context) {




    return   FutureBuilder (
        future: as.getMaps(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none :
              return Text('NONE');
            case ConnectionState.waiting :
              return Text('Loading');
            case ConnectionState.done :

//TEST

      print(_markers2);


                return MaterialApp(
                  home: Scaffold(
                    body: GoogleMap(
                      initialCameraPosition: CameraPosition(
                        target: currentPostion1,
                        zoom: 11,
                      ),
                      markers: _markers2,
                      myLocationEnabled: true,
                    ),

                  ),
                );




          }
        }
    );





  }


  void _getLocation() async {
    var currentLocation = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.best);

    setState(() {
      //  _markers.clear();
      final marker = Marker(
        markerId: MarkerId("curr_loc"),
        position: LatLng(currentLocation.latitude, currentLocation.longitude),
        infoWindow: InfoWindow(title: 'Your Location'),
      );
      _markers["Current Location"] = marker;
    });
  }


  void getMark()  async{
    Future <dynamic> rpt = as.getMaps();
    rpt.then((value) {
      setState(() {




         value.forEach((element) {
        _markers2.add(Marker(
          markerId: MarkerId(element["longitude"]),
          position: LatLng(double.parse(element["latitude"]), double.parse(element["longitude"])),
          infoWindow: InfoWindow(
            title: 'I am a marker',
          ),
          icon:
          BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueMagenta),
        ));

      });


      });
    });
  }


}









