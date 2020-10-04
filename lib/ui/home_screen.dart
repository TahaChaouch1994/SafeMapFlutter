import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class homescreen extends StatefulWidget{
  @override
  _homescreenState createState() => _homescreenState();
}

class _homescreenState extends State<homescreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container
        (color: Colors.orange[200],
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
      child: Column(
        children :[
        ]
      ),
      ),
      bottomNavigationBar: CurvedNavigationBar(
          color:Colors.white,
          backgroundColor: Colors.orange[200],
          buttonBackgroundColor:Colors.white,
          height: 50,
          items: [
        Icon(Icons.playlist_add,size: 20 ,color:Colors.black),
        Icon(Icons.add_location,size: 20 ,color:Colors.black),
        Icon(Icons.description,size: 20 ,color:Colors.black),
      ],
          onTap: (index)
          {
              debugPrint("hani fil $index");
          }),

    );
  }
}
