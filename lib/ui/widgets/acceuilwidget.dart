import 'package:flutter/material.dart';
import 'package:safemap/ui/widgets/mapdetail.dart';
import 'package:safemap/ui/widgets/responsive_ui.dart';
import 'package:expansion_card/expansion_card.dart';
import 'package:geolocator/geolocator.dart'  as geo  ;
import 'package:shared_preferences/shared_preferences.dart';

class AcceuilWidget extends StatelessWidget {


  String victim;
  String contact;
  String objetvole;
  String description;
  String date;
  String AdressePoste;
  String longitude;
  String latitude;


  AcceuilWidget(
      {this.victim,
        this.objetvole,
        this.description,
        this.date,
        this.contact,
        this.AdressePoste, this.longitude, this.latitude,
      });

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
   return  ExpansionCard(
      borderRadius: 20,
      background: Image.asset(
        "assets/images/card.gif",
        fit: BoxFit.cover,
      ),
      title: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
               "Cana, Tunisie, Italy                    "+ date,
              style: TextStyle(
                fontSize: 15,
                color: Colors.grey[400],
              ),
            ),
            SizedBox(height:10),// objetvole.substring(0,objetvole.length-1).replaceAll(";", " - ")
            Text(victim
               ,
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
            SizedBox(height:10),
          ],
        ),
      ),
      children: <Widget>[
        Container(
            child: Column(
    children: [
      Align(
        alignment: Alignment.topLeft,
        child:Text("Objet Volé  :    "+objetvole.substring(0,objetvole.length-1).replaceAll(";", " - ")+"  "+"\n",
        style: TextStyle(fontSize: 15, color: Colors.white ,),
        textAlign: TextAlign.left,

      ),),

      Text(description+"\n",
          style: TextStyle(fontSize: 20, color: Colors.white)
      ),
       Container(
         child:Row(
             mainAxisAlignment: MainAxisAlignment.spaceBetween,
             children: [
               Align(
                 alignment:Alignment(0.1, 0.2),
              child:Text("      "+contact,
                   style: TextStyle(fontSize: 15, color: Colors.white),
                   textAlign: TextAlign.right,
                 ),),
               GestureDetector(
                  onTap: () {


                    Navigator.push(context, PageRouteBuilder(
                    transitionDuration: Duration(seconds: 2),
                    transitionsBuilder:(context, animation, secondaryAnimation, child){
                      animation=CurvedAnimation(parent: animation, curve: Curves.elasticInOut);
                      return Align(
                        alignment: Alignment.bottomCenter,
                        child: SizeTransition(sizeFactor: animation,child: child),
                      );
                    },pageBuilder: (context, animation, secondaryAnimation)
                  {
                    return mapdetail(latitude:latitude,longitude:longitude);
                  },
                  ));

                 },
                  child:Align(
                    alignment:Alignment(0.1, 0.6) ,
                   child:Text("Show Map     ",
                        style: TextStyle(fontSize: 15, color: Colors.white)),
                  )
                  )
         ]
         )
       )
    ],
    )

          ),


      ],
    );
  }

}






