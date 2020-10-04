import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:safemap/ui/widgets/acceuil.dart';
import 'package:safemap/ui/widgets/ajout_reclamation.dart';
import 'package:safemap/ui/widgets/map.dart';
import 'package:safemap/ui/widgets/responsive_ui.dart';


class homescreen extends StatefulWidget{
  @override
  _homescreenState createState() => _homescreenState();
}

class _homescreenState extends State<homescreen> {
  int _page = 0;
  GlobalKey _bottomNavigationKey = GlobalKey();
  bool checkBoxValue = false;
  double _height;
  double _width;
  double _pixelRatio;
  bool _large;
  bool _medium;
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
              debugPrint("hani fil $index");
              },
      ),
      body:navigationbottombar(_page,),
    );
  }

navigationbottombar(int page) {
    if(page == 0)
      {return Acceuil();}
    if(page == 1)
    {return Mapgoogle();}
    if(page == 2)
    {return Ajout(_height,_width,_large,_medium);}
    else{return Acceuil();}
}
}