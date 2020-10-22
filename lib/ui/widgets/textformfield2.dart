/*
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Myobjet extends StatefulWidget {
  final _formKey = GlobalKey<FormState>();

  Myobjet();

  @override
  _MyobjetState createState() => _MyobjetState();
}

class _MyobjetState extends State<Myobjet> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _nameController;
  static List<String> objetsList = [];

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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        materiel(objetsList),

        lista(objetsList),

      ],


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

  Widget materiel(items) {
    TextEditingController object = new TextEditingController();
    return Material(
      borderRadius: BorderRadius.circular(30.0),
      //elevation: _large? 12 : (_medium? 10 : 8),
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


}
*/
