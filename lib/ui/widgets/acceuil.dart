

import 'package:expansion_card/expansion_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_skeleton/flutter_skeleton.dart';
import 'package:safemap/services/acceuilservice.dart';
import 'package:safemap/ui/widgets/acceuilwidget.dart';



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
  AcceuilService as = new AcceuilService();

  @override
  void initState() {
    super.initState();

    Future <dynamic> rpt = as.getAllReports();
    rpt.then((value) {

      setState(() {
        test = value.length;
        value2 = value;
      });

    });

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

        print(value2[0]["nom"]);




    });

          return Scaffold(
              backgroundColor: Colors.orange[200],
              body: Center(
                  child:
                  SingleChildScrollView(
                    child:
                    Column(children: <Widget>[
                      for(int i = 0; i < test; i++)

                        AcceuilWidget2(value2[i]["victim"],value2[i]["objetvole"],value2[i]["description"]),

                      SizedBox(height: _height / 40.0),

                    ],
                    ),)
              )
          );
      }
    }
    );



  }
}


Widget AcceuilWidget2(victim2,objetvole2,description2) {

    return AcceuilWidget(
      victim:victim2,
      objetvole:objetvole2,
      description: description2
    );
}
