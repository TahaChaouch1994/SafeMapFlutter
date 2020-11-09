import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:safemap/constants/constants.dart';
import 'package:safemap/entities/user.dart';
import 'package:safemap/services/userservice.dart';
import 'package:safemap/ui/home_screen.dart';
import 'package:safemap/ui/signup.dart';
import 'package:safemap/ui/widgets/custom_shape.dart';
import 'package:safemap/ui/widgets/responsive_ui.dart';
import 'package:safemap/ui/widgets/textformfield.dart';
import 'package:shared_preferences/shared_preferences.dart';


class SignInPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SignInScreen(),
    );
  }
}

class SignInScreen extends StatefulWidget {
  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {

  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  double _height;
  double _width;
  double _pixelRatio;
  bool _large;
  bool _medium;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  GlobalKey<FormState> _key = GlobalKey();

  UserService userService = new UserService();

  TextEditingController adressemail = new TextEditingController();
  TextEditingController mdp = new TextEditingController();

  bool x=true;



  @override
  Widget build(BuildContext context) {
    _height = MediaQuery.of(context).size.height;
    _width = MediaQuery.of(context).size.width;
    _pixelRatio = MediaQuery.of(context).devicePixelRatio;
    _large =  ResponsiveWidget.isScreenLarge(_width, _pixelRatio);
    _medium =  ResponsiveWidget.isScreenMedium(_width, _pixelRatio);
    return Material(
      child: Container(
        height: _height,
        width: _width,
        padding: EdgeInsets.only(bottom: 5),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              clipShape(),
              signInTextRow(),
              form(),
              forgetPassTextRow(),
              SizedBox(height: _height / 12),
              button(),
              signUpTextRow(),
            ],
          ),
        ),
      ),
    );
  }

  Widget clipShape() {
    //double height = MediaQuery.of(context).size.height;
    return Stack(
      children: <Widget>[
        Opacity(
          opacity: 0.75,
          child: ClipPath(
            clipper: CustomShapeClipper(),
            child: Container(
              height:_large? _height/4 : (_medium? _height/3.75 : _height/3.5),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.orange[200], Colors.pinkAccent],
                ),
              ),
            ),
          ),
        ),
        Opacity(
          opacity: 0.5,
          child: ClipPath(
            clipper: CustomShapeClipper2(),
            child: Container(
              height: _large? _height/4.5 : (_medium? _height/4.25 : _height/4),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.orange[200], Colors.pinkAccent],
                ),
              ),
            ),
          ),
        ),
        Container(
          alignment: Alignment.bottomCenter,
          margin: EdgeInsets.only(top: _large? _height/30 : (_medium? _height/25 : _height/20)),
          child: Image.asset(
            'assets/images/login.png',
            height: _height/3.5,
            width: _width/3.5,
          ),
        ),
      ],
    );
  }



  Widget signInTextRow() {
    return Container(
      margin: EdgeInsets.only(left: _width / 15.0),
      child: Center(
        child:
        Text(
          "Sign in to your account",
          style: TextStyle(
            fontWeight: FontWeight.w200,
            fontSize: _large? 20 : (_medium? 17.5 : 15),
          ),
        ),
      ),
    );
  }

  Widget form() {
    return Container(
      margin: EdgeInsets.only(
          left: _width / 12.0,
          right: _width / 12.0,
          top: _height / 15.0),
      child: Form(
        key: _key,
        child: Column(
          children: <Widget>[
            emailTextFormField(x),
            SizedBox(height: _height / 40.0),
            passwordTextFormField(x),
          ],
        ),
      ),
    );
  }

  Widget emailTextFormField(x) {
    if(x==false) {
      return CustomTextField(
        keyboardType: TextInputType.emailAddress,
        textEditingController: adressemail,
        icon: Icons.email,
        hint: "Email",
        colortext: Colors.red,
      );

    }
    else{

      return CustomTextField(
        keyboardType: TextInputType.emailAddress,
        textEditingController: adressemail,
        icon: Icons.email,
        hint: "Email",
        colortext: Colors.orange[200],
      );
    }
  }

  Widget passwordTextFormField(x) {
    if(x==false) {
    return CustomTextField(
      keyboardType: TextInputType.emailAddress,
      textEditingController: mdp,
      icon: Icons.lock,
      obscureText: true,
      hint: "Password",
      colortext: Colors.red,
    );}
    else{
      return CustomTextField(
        keyboardType: TextInputType.emailAddress,
        textEditingController: mdp,
        icon: Icons.lock,
        obscureText: true,
        hint: "Password",
        colortext: Colors.orange[200],
      );
    }
  }

  Widget forgetPassTextRow() {
    return Container(
      margin: EdgeInsets.only(top: _height / 40.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            "Forgot your password?",
            style: TextStyle(fontWeight: FontWeight.w400,fontSize: _large? 14: (_medium? 12: 10)),
          ),
          SizedBox(
            width: 5,
          ),
          GestureDetector(
            onTap: () {
              print("Routing");
            },
            child: Text(
              "Recover",
              style: TextStyle(
                  fontWeight: FontWeight.w600, color: Colors.orange[200]),
            ),
          )
        ],
      ),
    );
  }

  Widget button() {
    return RaisedButton(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
      onPressed: () {

        User euser = new User();
        euser.adressemail = adressemail.text.trim();
        euser.mdp = mdp.text.trim();

        Future <dynamic> user = userService.login(euser);

        user.then((value) {
          if(value == "matched")
            {_saveMark(0,0);
              Future <dynamic> user1 = userService.getUserFromLogin(euser.adressemail);
              user1.then((value) {
                User loggedInUser = User.fromJsonMap(value[0]);

                _saveUser(loggedInUser);
              });

              Navigator.push(context, PageRouteBuilder(
                transitionDuration: Duration(seconds: 2),
                transitionsBuilder:(context, animation, secondaryAnimation, child){
                  var begin= 0.0;
                  var end=1.0;
                  var tween= Tween(begin: begin,end: end);
                  animation=CurvedAnimation(parent: animation, curve: Curves.easeInCirc);
                  return ScaleTransition(
                    scale: tween.animate(animation),
                    child: RotationTransition(turns: tween.animate(animation),child: child),
                  );
                },pageBuilder: (context, animation, secondaryAnimation)
              {
                return homescreen();
              },
              ));
              Scaffold
                  .of(context)
                  .showSnackBar(SnackBar(content: Text('Login Successful',style: TextStyle(color:Colors.green),)));
            }
          else {
            setState(() {
              x=false;
            });
            PageRouteBuilder(
              transitionDuration: Duration(seconds: 2),
              transitionsBuilder:(context, animation, secondaryAnimation, child){
                animation=CurvedAnimation(parent: animation, curve: Curves.elasticInOut);
                return Align(
                  alignment: Alignment.bottomCenter,
                  child: SizeTransition(sizeFactor: animation,child: child),
                );
              },pageBuilder: (context, animation, secondaryAnimation)
            {
              return SignInScreen();
            },
            );
            Scaffold
                .of(context)
                .showSnackBar(SnackBar(content: Text('email or password is incorrect',style: TextStyle(color:Colors.red),)));

          }
        });

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
            colors: <Color>[Colors.orange[200], Colors.pinkAccent],
          ),
        ),
        padding: const EdgeInsets.all(12.0),
        child: Text('SIGN IN',style: TextStyle(fontSize: _large? 14: (_medium? 12: 10))),
      ),
    );
  }

  Widget signUpTextRow() {
    return Container(
      margin: EdgeInsets.only(top: _height / 120.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            "Don't have an account?",
            style: TextStyle(fontWeight: FontWeight.w400,fontSize: _large? 14: (_medium? 12: 10)),
          ),
          SizedBox(
            width: 5,
          ),
          GestureDetector(
            onTap: () {
              //  SlideRigight();
              // Navigator.pushReplacement(context,
              //MaterialPageRoute(builder: (context)=> SignUpScreen()));



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
                return SignUpScreen();
              },
              ));
              // Navigator.of(context).pushNamed(SIGN_UP);
              print("Routing to Sign up screen");
            },
            child: Text(
              "Sign up",
              style: TextStyle(
                  fontWeight: FontWeight.w800, color: Colors.orange[200], fontSize: _large? 19: (_medium? 17: 15)),
            ),
          )
        ],
      ),
    );
  }

  Future<void> _saveUser(User user) async {
    final SharedPreferences prefs = await _prefs;

    setState(() {
      prefs.setString("go_user", jsonEncode(user)).then((bool success) {
        return jsonEncode(user);
      });
    });
  }


  Future<void> _saveMark(double longitude, double latitude) async {
    final SharedPreferences prefs = await _prefs;

    setState(() {
      prefs.setString("longitude", longitude.toString()).then((bool success) {
        return longitude.toString();
      });
      prefs.setString("latitude", latitude.toString()).then((bool success) {
        return latitude.toString();
      });
    });
  }

}
