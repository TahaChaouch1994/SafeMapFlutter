

import 'package:expansion_card/expansion_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_skeleton/flutter_skeleton.dart';
class Acceuil extends StatelessWidget {
  Acceuil({Key key}) : super(key: key);
  double _height;
  double _width;
  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = TextStyle(color: Colors.white, fontSize: 16.0);
    return Scaffold(
      appBar: AppBar(title: Text('Skeleton Demo')),
      body: Container(
        width: double.infinity,
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            RaisedButton(
              color: Colors.blue,
              child: Text("List Skeleton", style: textStyle),
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  return ListSkeletonDemo();
                }));
              },
            ),
            RaisedButton(
              color: Colors.blue,
              child: Text("Card Skeleton", style: textStyle),
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  return CardSkeletonDemo();
                }));
              },
            ),
            RaisedButton(
              color: Colors.blue,
              child: Text("Card List Skeleton", style: textStyle),
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  return CardListSkeletonDemo();
                }));
              },
            ),
            RaisedButton(
              color: Colors.blue,
              child: Text("expansion_card", style: textStyle),
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  return MainApp();
                }));
              },
            )
          ],
        ),
      ),
    );
  }
}

class CardListSkeletonDemo extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _CardListSkeletonDemoState();
}

class _CardListSkeletonDemoState extends State<CardListSkeletonDemo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF222222),
      appBar: AppBar(title: Text("Card List Skeleton Demo")),
      body: Container(
        child: CardListSkeleton(
          style: SkeletonStyle(
            theme: SkeletonTheme.Dark,
            isShowAvatar: true,
            isCircleAvatar: true,
            barCount: 2,
          ),
        ),
      ),
    );
  }
}


class CardSkeletonDemo extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _CardSkeletonDemoState();
}

class _CardSkeletonDemoState extends State<CardSkeletonDemo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFe0e0e0),
      appBar: AppBar(title: Text("Card Skeleton Demo")),
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: CardSkeleton(
          style: SkeletonStyle(
            theme: SkeletonTheme.Dark,
            isShowAvatar: true,
            isCircleAvatar: false,
            borderRadius: BorderRadius.all(Radius.circular(16.0)),
            padding: EdgeInsets.all(32.0),
            barCount: 2,
            colors: [Color(0xffffffff)],
            backgroundColor: Color(0xFF009000),
            isAnimation: false,
          ),
        ),
      ),
    );
  }
}


class ListSkeletonDemo extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ListSkeletonDemoState();
}

class _ListSkeletonDemoState extends State<ListSkeletonDemo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("List Skeleton Demo"),
//        actions: <Widget>[
//          GestureDetector(
//            onTap: _onPressedSetting,
//            child: Padding(
//              padding: EdgeInsets.symmetric(horizontal: 16.0),
//              child: Icon(Icons.settings, color: Colors.white),
//            ),
//          )
//        ],
      ),
      body: ListSkeleton(
        style: SkeletonStyle(
          theme: _theme,
          isShowAvatar: _isShowAvatar,
          barCount: 3,
          colors: [Color(0xff333333), Color(0xffffff45), Color(0xff333333)],
          isAnimation: true,
        ),
      ),
    );
  }

  SkeletonTheme _theme;
  bool _isShowAvatar = false;
//  final bool isCircularImage;
//  final int bottomLinesCount;
//  final double radius;

  void _onPressedSetting() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter setStateDialog) {
                return AlertDialog(
                  titlePadding: EdgeInsets.only(left: 16.0, top: 16.0),
                  title: Text("SkeletonConfig"),
                  contentPadding: EdgeInsets.all(16.0),
                  content: _renderConfigViews(context, setStateDialog),
                  actions: <Widget>[
                    FlatButton(
                        child: Text("OK"),
                        onPressed: () => Navigator.of(context).pop())
                  ],
                );
              });
        });
  }

  _renderConfigViews(BuildContext context, StateSetter setStateDialog) {
    return Column(
      children: <Widget>[
        Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Text("Light"),
                Radio(
                  value: SkeletonTheme.Light,
                  groupValue: _theme,
                  onChanged: (value) {
                    setState(() {
                      _theme = value;
                    });
                    setStateDialog(() {
                      _theme = value;
                    });
                  },
                ),
                Text("Dark"),
                Radio(
                    value: SkeletonTheme.Dark,
                    groupValue: _theme,
                    onChanged: (value) {
                      setState(() {
                        _theme = value;
                      });
                      setStateDialog(() {
                        _theme = value;
                      });
                    }),
              ],
            ),
          ],
        )
      ],
    );
  }
}

class MainApp extends StatelessWidget {
  @override
  double _height;
  double _width;
  Widget build(BuildContext context) {
    _height = MediaQuery
        .of(context)
        .size
        .height;
    return Scaffold(
backgroundColor: Colors.orange[200],
        body: Center(
            child:Column (children: <Widget>[
               ExpansionCard(
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
                      "Header",
                      style: TextStyle(
                        fontSize: 30,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      "Sub",
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                  ],
                ),
              ),
              children: <Widget>[
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 7),
                  child: Text("Content goes over here !",
                      style: TextStyle(fontSize: 20, color: Colors.white)),
                )
              ],
            ),
              SizedBox(height: _height / 40.0),

              ExpansionCard(
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
                    "Header",
                    style: TextStyle(
                      fontSize: 30,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    "Sub",
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                ],
              ),
            ),
            children: <Widget>[
              Container(
                margin: EdgeInsets.symmetric(horizontal: 7),
                child: Text("Content goes over here !",
                    style: TextStyle(fontSize: 20, color: Colors.white)),
              )
            ],
          ),
        ],
              )
    )
    );
  }
}

/*
Widget Acceuil() {

  double _width;
  return Container(color: Colors.orange[200],
    child:Center(
      child:
      Text(
        "Acceuil",
        style: TextStyle(
          fontWeight: FontWeight.w200,
        ),)
      ),);
}*/
