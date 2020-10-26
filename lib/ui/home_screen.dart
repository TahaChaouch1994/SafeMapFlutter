import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:safemap/ui/widgets/acceuil.dart';
import 'package:safemap/ui/widgets/ajout_reclamation.dart';
import 'package:safemap/ui/widgets/map.dart';
import 'package:safemap/ui/widgets/responsive_ui.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';


class homescreen extends StatefulWidget{
  @override
  _homescreenState createState() => _homescreenState();
}

class _homescreenState extends State<homescreen> {
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  int _page = 0;
  GlobalKey _bottomNavigationKey = GlobalKey();
  bool checkBoxValue = false;
  double _height;
  double _width;
  double _pixelRatio;
  bool _large;
  bool _medium;
  GoogleMapController mapController;
  final Map<String, Marker> _markers = {};
  TextEditingController Ojbet = TextEditingController();


  final LatLng _center = const LatLng(45.521563, -122.677433);

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }
  @override
  void initState() {
    super.initState();
    _saveMark(0, 0);
  }
  @override
  Widget build(BuildContext context) {
    _height = MediaQuery.of(context).size.height;
    _width = MediaQuery.of(context).size.width;
    _pixelRatio = MediaQuery.of(context).devicePixelRatio;
    _large =  ResponsiveWidget.isScreenLarge(_width, _pixelRatio);
    _medium =  ResponsiveWidget.isScreenMedium(_width, _pixelRatio);


    return Scaffold(
      backgroundColor: Colors.orange[200],
      bottomNavigationBar: CurvedNavigationBar(
          key: _bottomNavigationKey,
          index: 0,
          color:Colors.white,
          backgroundColor: Colors.orange[200],
          buttonBackgroundColor:Colors.white,
          height: 50,
          animationCurve: Curves.easeInOut,
          animationDuration: Duration(milliseconds: 600),
          items: [
            Icon(Icons.assignment,size: 20 ,color:Colors.black),
            Icon(Icons.add_location,size: 20 ,color:Colors.black),
            Icon(Icons.playlist_add,size: 20 ,color:Colors.black),
          ],
          onTap: (index)
              { setState(() {
                _page = index;
              });
              debugPrint("je suis dans la page  $index");
              },
      ),
      body:navigationbottombar(_page,),
    );
  }

        navigationbottombar(int page) {
            if(page == 0)
              {return Acceuil();}
            if(page == 1)
            {return Mapgoogle(_markers,_getLocation);}
            if(page == 2)
            {return Ajout();}
            else{return Acceuil();}
        }

  void _getLocation() async {
    var currentLocation = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.best);

    setState(() {
      _markers.clear();
      final marker = Marker(
        markerId: MarkerId("curr_loc"),
        position: LatLng(currentLocation.latitude, currentLocation.longitude),
        infoWindow: InfoWindow(title: 'Your Location'),
      );
      _markers["Current Location"] = marker;
    });
  }
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