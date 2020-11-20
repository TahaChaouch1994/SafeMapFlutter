import 'package:flutter/material.dart';
import 'package:safemap/ui/widgets/responsive_ui.dart';
import 'package:expansion_card/expansion_card.dart';

class AcceuilWidget extends StatelessWidget {


  String victim;
  String contact;
  String objetvole;
  String description;

  AcceuilWidget(
      {this.victim,
        this.objetvole,
        this.description,
      });

  @override
  Widget build(BuildContext context) {

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
              victim,
              style: TextStyle(
                fontSize: 25,
                color: Colors.white,
              ),
            ),
            Text(
                objetvole.substring(0,objetvole.length-1).replaceAll(";", " - "),
              style: TextStyle(fontSize: 20, color: Colors.white),
            ),
          ],
        ),
      ),
      children: <Widget>[
        Container(
          margin: EdgeInsets.symmetric(horizontal: 7),
          child: Text(description,
              style: TextStyle(fontSize: 20, color: Colors.white)),
        )
      ],
    );
  }

}







