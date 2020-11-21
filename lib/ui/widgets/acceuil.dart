

import 'package:expansion_card/expansion_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_skeleton/flutter_skeleton.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:safemap/services/acceuilservice.dart';
import 'package:safemap/ui/widgets/acceuilwidget.dart';
import 'package:geolocator/geolocator.dart'  as geo  ;




class Acceuil extends StatefulWidget{
  @override
  _Acceuil createState() => _Acceuil();
}




class _Acceuil extends State<Acceuil> {
  @override
  double _height;
  double _width;
  int test;
  List <dynamic> value2;
  List <String> AdressePoste;
  AcceuilService as = new AcceuilService();
  PermissionStatus _permissionStatus = PermissionStatus.undetermined;
  final geo.Geolocator _geolocator = geo.Geolocator();

  @override
  void initState() {
    super.initState();
    _ActiveLocation();
    Future <dynamic> rpt = as.getAllReports();
    rpt.then((value) {

      setState(() {
        test = value.length;
        value2 = value;
      });
     // _getAddress();
    });

  }


  _getAddress() async {
    try {
    //  print(test);
      for(int i = 0; i <test-1 ; i++)
    {  List<geo.Placemark> p = await _geolocator.placemarkFromCoordinates(
          double.parse(value2[i]["latitude"]),double.parse(value2[i]["longitude"]));

      geo.Placemark place = p[0];

      setState(() {
        AdressePoste.add("${place.name}, ${place.locality}, ${place.country}");
      });
    print(AdressePoste[i]);}
    } catch (e) {
      print(e);
    }

  }


  Widget build(BuildContext context) {
    _height = MediaQuery
        .of(context)
        .size
        .height;







    return  FutureBuilder(
        future: as.getAllReports(),
    builder: (context, snapshot) {
      switch (snapshot.connectionState) {
        case ConnectionState.none :
          return Text('NONE');
        case ConnectionState.waiting :
          return Text('Loading');
        case ConnectionState.done :


    Future <dynamic> rpt = as.getAllReports();
    rpt.then((value) {

        test = value.length;
        value2 = value;

       // print(value2[0]["nom"]);




    });

          return Scaffold(
              backgroundColor: Colors.orange[200],
              body: Center(
                  child:
                  SingleChildScrollView(
                    child:
                    Column(children: <Widget>[
                      for(int i = 0; i < test; i++)

                        AcceuilWidget2(value2[i]["victim"],value2[i]["objetvole"],value2[i]["description"],value2[i]["date"],value2[i]["contact"],value2[i]["longitude"],value2[i]["latitude"]),

                      SizedBox(height: _height / 40.0),

                    ],
                    ),)
              )
          );
      }
    }
    );



  }
  Future<void> requestPermission(Permission permission) async {
    final status = await permission.request();

    setState(() {
    //  print(status);
      _permissionStatus = status;
     // print(_permissionStatus);
    });
  }
  _ActiveLocation() async {
    if (!await Permission.location.isGranted) {
      requestPermission(Permission.location);
   //   print( _permissionStatus.toString());
      /* await _geolocator
          .getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
          .then((Position position) async {
        setState(() {
          _currentPosition = position;
          print('CURRENT POS: $_currentPosition');
          mapController.animateCamera(
            CameraUpdate.newCameraPosition(
              CameraPosition(
                target: LatLng(position.latitude, position.longitude),
                zoom: 18.0,
              ),
            ),
          );
        });
        await _getAddress();
      }).catchError((e) {
        print(e);
      });
*/
    }
    else{
      //print( Permission.location.serviceStatus.toString());
    }
    /* await _geolocator
          .getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
          .then((Position position) async {
        setState(() {
          _currentPosition = position;
          print('CURRENT POS: $_currentPosition');
          mapController.animateCamera(
            CameraUpdate.newCameraPosition(
              CameraPosition(
                target: LatLng(position.latitude, position.longitude),
                zoom: 18.0,
              ),
            ),
          );
        });
        await _getAddress();
      }).catchError((e) {
        print(e);
      });}
*/
  }
}


Widget AcceuilWidget2(victim2,objetvole2,description2,date2,contact2,longitude2,latitude2) {

    return AcceuilWidget(
      victim:victim2,
        objetvole:objetvole2,
        description: description2,
        date:date2,
        contact:contact2,
      longitude:longitude2,
      latitude:latitude2

    );
}
