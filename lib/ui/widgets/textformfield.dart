import 'package:flutter/material.dart';
import 'package:safemap/ui/widgets/responsive_ui.dart';

class CustomTextField extends StatelessWidget {
  final String hint;
   Color colortext=Colors.orange[200];
  final TextEditingController textEditingController;
  final TextInputType keyboardType;
  final bool obscureText;
  final IconData icon;
  final InputDecoration decoration;
  double _width;
  double _pixelRatio;
  bool large;
  bool medium;


  CustomTextField(
    {this.hint,
      this.textEditingController,
      this.keyboardType,
      this.icon,
      this.obscureText= false,
      this.colortext,
      this.decoration,

     });

  @override
  Widget build(BuildContext context) {
    _width = MediaQuery.of(context).size.width;
    _pixelRatio = MediaQuery.of(context).devicePixelRatio;
    large =  ResponsiveWidget.isScreenLarge(_width, _pixelRatio);
    medium=  ResponsiveWidget.isScreenMedium(_width, _pixelRatio);
    return Material(
      borderRadius: BorderRadius.circular(30.0),
      elevation: large? 12 : (medium? 10 : 8),
      child: TextFormField(
        obscureText: obscureText,
        controller: textEditingController,
        keyboardType: keyboardType,
        cursorColor:colortext,
        decoration: InputDecoration(
          prefixIcon: Icon(icon, color:colortext, size: 20),
          hintText: hint,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30.0),
              borderSide: BorderSide.none),
        ),
      ),
    );
  }
}





