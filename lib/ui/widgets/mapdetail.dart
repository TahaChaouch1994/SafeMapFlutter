import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';


class mapdetail extends StatefulWidget {


  final String latitude;
  final String longitude;
  const mapdetail ({ Key key, this.latitude,this.longitude }): super(key: key);


  @override
  _mapdetailState createState() => _mapdetailState();

}

class _mapdetailState extends State<mapdetail> {
  Completer<GoogleMapController> _controller = Completer();
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  final Geolocator _geolocator = Geolocator();
  static const routeName = '/country-map';
  final Set<Marker> _markers = {};
  CameraPosition _initialLocation = CameraPosition(target: LatLng(0.0, 0.0));
  GoogleMapController mapController;
  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }
  @override
  Widget build(BuildContext context) {
    final Map country = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange[200],
        title: Text("retour"),
      ),
      body:  GoogleMap(
        markers: _markers,
        initialCameraPosition:  CameraPosition(target: LatLng(double.parse(widget.latitude),double.parse(widget.longitude)),zoom: 8.0,),
        mapType: MapType.normal,
        zoomGesturesEnabled: true,
        zoomControlsEnabled: false,
        onMapCreated: (GoogleMapController controller) {
          mapController = controller;
        },
      ),
      //  markers: _markers.values.toSet(),
    );

  }
  _getCurrentLocation() async {
 _markers.add(Marker(
      markerId: MarkerId(widget.longitude),
      position: LatLng(double.parse(widget.latitude),double.parse(widget.longitude)),
      infoWindow: InfoWindow(
        title: 'I am a marker',
      ),
      icon:
      BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueMagenta),
    ));

/* setState(() {

   mapController.animateCamera(
     CameraUpdate.newCameraPosition(
       CameraPosition(
         target: LatLng(double.parse(widget.latitude), double.parse(widget.longitude)),
         zoom: 18.0,
       ),
     ),
   );
 });*/

      }

  }

