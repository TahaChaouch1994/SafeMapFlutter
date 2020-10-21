
import 'package:flutter/material.dart';
import 'package:safemap/ui/widgets/custom_text_area.dart';
import 'package:safemap/ui/widgets/textformfield.dart';
import 'package:safemap/ui/widgets/textformfield2.dart';


Widget Ajout(_height,_width,_large,_medium) {
  List<Widget>list = new List();

  final List<String> items = new List<String>.generate(3, (i) => "Items ${i+1}");

  return Container(color: Colors.orange[200],
    margin: EdgeInsets.only(
        left:_width/ 12.0,
        right: _width / 12.0,
        top: _height / 20.0),

    child:SingleChildScrollView(

     child : Form(
      child: Column(
        children: <Widget>[
          SizedBox(height: _height / 10.0),
          ajout_reclamation (_large,_medium,_width),
          SizedBox(height: _height / 10.0),
          lastNameTextFormField(),
          SizedBox(height: _height / 40.0),
          materiel(),
          SizedBox(height: _height/ 40.0),
          lista(items),
          SizedBox(height: _height/ 40.0),
          contact(),
          SizedBox(height: _height / 40.0),
          description(),
          SizedBox(height: _height / 40.0),
          button(_height, _width, _large, _medium),

        ],
      ),
    ),
    ),
  );
}

Widget ajout_reclamation (_large,_medium,_width) {
  return Container(
     margin: EdgeInsets.only(left: _width / 15.0),
    child: Center(
      child:
      Text(
        "Ajouter votre reclamation",
        style: TextStyle(
          fontWeight: FontWeight.w200,
          fontSize: _large? 30 : (_medium? 20.5 : 18),
        ),
      ),
    ),
  );
}
Widget materiel() {
  return CustomTextField2(
    keyboardType: TextInputType.text,
    icon: Icons.business_center,
    hint: " objets volés",
    icon2: Icons.add,
  );
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
Widget button(_height,_width,_large,_medium) {
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
      width: _large? _width/4 : (_medium? _width/3.75: _width/3.5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(20.0)),
        gradient: LinearGradient(
          colors: <Color>[Colors.black, Colors.black38],
        ),
      ),
      padding: const EdgeInsets.all(12.0),
      child: Text('submit',style: TextStyle(fontSize: _large? 14: (_medium? 12: 10))),
    ),
  );



}

//test
Widget test(list) {
  return  Container(
      padding: EdgeInsets.all(20.0),
      child: new ListView.builder(itemBuilder: (context, index){
        Widget widget = list.elementAt(index);
        return widget;
      }, itemCount: list.length,),
  );
}




   Widget lista(items)
{
  return ListView.builder(

    padding: const EdgeInsets.only(left: 50.0,right: 50.0),
    shrinkWrap: true,
    itemCount: items.length,
    itemBuilder: (context,int index){
      return new Dismissible(
       key: new Key(items[index]),
        onDismissed: (direction){
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
