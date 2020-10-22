
import 'package:animated_stream_list/animated_stream_list.dart';
import 'package:flutter/material.dart';
import 'package:safemap/ui/widgets/custom_text_area.dart';
import 'package:safemap/ui/widgets/responsive_ui.dart';
import 'package:safemap/ui/widgets/textformfield.dart';
import 'package:safemap/ui/widgets/textformfield2.dart';

class Ajout extends StatefulWidget {
  final _formKey = GlobalKey<FormState>();

  Ajout();

  @override
  _AjoutState createState() => _AjoutState();
}

class _AjoutState extends State<Ajout> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _nameController;
  static List<String> objetsList=[];
  bool checkBoxValue = false;
  double _height;
  double _width;
  double _pixelRatio;
  bool _large;
  bool _medium;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _height = MediaQuery
        .of(context)
        .size
        .height;
    _width = MediaQuery
        .of(context)
        .size
        .width;
    _pixelRatio = MediaQuery
        .of(context)
        .devicePixelRatio;
    _large = ResponsiveWidget.isScreenLarge(_width, _pixelRatio);
    _medium = ResponsiveWidget.isScreenMedium(_width, _pixelRatio);

    return Container(color: Colors.orange[200],
      margin: EdgeInsets.only(
          left: _width / 12.0,
          right: _width / 12.0,),

      child: SingleChildScrollView(

        child: Form(
          child: Column(
            children: <Widget>[
              SizedBox(height: _height / 10.0),
              titre(),
              SizedBox(height: _height / 10.0),
              lastNameTextFormField(),
              SizedBox(height: _height / 40.0),
              materiel(objetsList),
              SizedBox(height: _height/ 40.0),
              lista(objetsList),
            // Myobjet(),
              SizedBox(height: _height / 40.0),
              contact(),
              SizedBox(height: _height / 40.0),
              description(),
              SizedBox(height: _height / 40.0),
              button(),

            ],
          ),
        ),
      ),
    );
  }

  Widget titre () {
    return Container(
      margin: EdgeInsets.only(left: _width / 15.0),
      child: Center(
        child:
        Text(
          "Ajouter votre reclamation",
          style: TextStyle(
            fontWeight: FontWeight.w200,
            fontSize: _large ? 30 : (_medium ? 20.5 : 18),
          ),
        ),
      ),
    );
  }


  Widget materiel(items) {
    TextEditingController object = new TextEditingController();
    return Material(
      borderRadius: BorderRadius.circular(30.0),
      elevation: _large? 12 : (_medium? 10 : 8),
      child: TextFormField(
        controller: object,
        keyboardType: TextInputType.text,
        cursorColor:Colors.orange[200],
        decoration: InputDecoration(
          suffixIcon: IconButton(icon: Icon(Icons.add), color:Colors.orange[200], iconSize: 20,onPressed: (
              ) {
            setState(() {
              if(object.text.trim().length!=0) {
                items.insert(0, object.text);
              }
              else
              {
                return     Scaffold.of(context).showSnackBar(new SnackBar(
                  content: new Text("Objet can not be empty "),
                ));
              }
            });

            return print(items);
          },),
          prefixIcon: Icon(Icons.device_unknown, color:Colors.orange[200], size: 20),
          hintText: "Objet Volé",
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30.0),
              borderSide: BorderSide.none),
        ),
      ),);
  }

  Widget lastNameTextFormField() {
    return CustomTextField(
      keyboardType: TextInputType.text,
      icon: Icons.person,
      hint: "Nom de victime ",
    );
  }

  Widget contact() {
    return CustomTextField(
      keyboardType: TextInputType.emailAddress,
      icon: Icons.contact_mail,
      hint: "moyen de contact",
    );
  }


  Widget description() {
    return CustomTextarea(
      keyboardType: TextInputType.text,
      obscureText: true,
      icon: Icons.description,
      hint: "Description",
    );
  }

  Widget button() {
    return RaisedButton(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
      onPressed: () {


      },
      textColor: Colors.white,
      padding: EdgeInsets.all(0.0),
      child: Container(
        alignment: Alignment.center,
        height: _height / 18,
        width: _large ? _width / 4 : (_medium ? _width / 3.75 : _width / 3.5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20.0)),
          gradient: LinearGradient(
            colors: <Color>[Colors.black, Colors.black38],
          ),
        ),
        padding: const EdgeInsets.all(12.0),
        child: Text('submit',
            style: TextStyle(fontSize: _large ? 14 : (_medium ? 12 : 10))),
      ),
    );
  }

//test
  Widget test(items) {
    final animatedView = AnimatedStreamList<String>(
      streamList: items, // 1.
      itemBuilder: (String item, int index, BuildContext context,
          Animation<double> animation) => _createTile(item, animation), // 2.
      itemRemovedBuilder: (String item, int index, BuildContext context,
          Animation<double> animation) => _createRemovedTile(item, animation), // 3.
    );
    return ListView.builder(

      padding: const EdgeInsets.only(left: 50.0, right: 50.0),
      shrinkWrap: true,
      itemCount: items.length,
      itemBuilder: (context, int index) {
        return new Dismissible(
            key: new Key(items[index]),
            onDismissed: (direction) {
              items.removeAt(index);
              Scaffold.of(context).showSnackBar(new SnackBar(
                content: new Text("Item dismissed"),
              ));
            },
            child: new ListTile(
              title: new Text("${items[index]}"),
            )
        );
      },


    );
  }


  Widget lista(items) {
    TextStyle textStyle = Theme.of(context).textTheme.headline6;
    return ListView.builder(
      padding: EdgeInsets.only(
          left: _width / 10.0,
          right: _width / 10.0,),
      shrinkWrap: true,
      itemCount: items.length,
      itemBuilder: (context, int index) {
        return new Dismissible(
            key: new Key(items[index]),
            onDismissed: (direction) {
              items.removeAt(index);
              Scaffold.of(context).showSnackBar(new SnackBar(
                content: new Text("Item dismissed"),
              ));
            },
            child: new Card(
              child:Container(
                height: _height/13,
                width: _width/16,
                color: Colors.white,
                child: Center(
                  child: Text("${items[index]}", style: textStyle),
                ),)

            ),
        );
      },


    );
  }
}

_createTile(String item, Animation<double> animation) {

}

_createRemovedTile(String item, Animation<double> animation) {
}