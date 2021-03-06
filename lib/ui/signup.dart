


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:safemap/constants/constants.dart';
import 'package:safemap/entities/user.dart';
import 'package:safemap/services/userservice.dart';
import 'package:safemap/ui/signin.dart';
import 'package:safemap/ui/widgets/custom_shape.dart';
import 'package:safemap/ui/widgets/customappbar.dart';
import 'package:safemap/ui/widgets/responsive_ui.dart';
import 'package:safemap/ui/widgets/textformfield.dart';
import 'package:safemap/utils/validator.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool checkBoxValue = false;
  double _height;
  double _width;
  double _pixelRatio;
  bool _large;
  bool _medium;

  UserService userService = new UserService();

  TextEditingController adressemail = new TextEditingController();
  TextEditingController nom = new TextEditingController();
  TextEditingController prenom = new TextEditingController();
  TextEditingController mdp = new TextEditingController();
  TextEditingController rmdp = new TextEditingController();

  @override
  Widget build(BuildContext context) {

    _height = MediaQuery.of(context).size.height;
    _width = MediaQuery.of(context).size.width;
    _pixelRatio = MediaQuery.of(context).devicePixelRatio;
    _large =  ResponsiveWidget.isScreenLarge(_width, _pixelRatio);
    _medium =  ResponsiveWidget.isScreenMedium(_width, _pixelRatio);

    return Material(
      child: Scaffold(
        body:Builder(
        builder: (context) =>
        Container(
          height: _height,
          width: _width,
          margin: EdgeInsets.only(bottom: 5),
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Opacity(opacity: 0.88,child: CustomAppBar()),
              clipShape(),
             //   SizedBox(height: _height / 24),
                signUpTextRow(),
               // SizedBox(height: _height / 25),
                form(),
           //     acceptTermsTextRow(),
                SizedBox(height: _height/35,),
                button(context),
            //    infoTextRow(),
               // socialIconsRow(),
                //signInTextRow(),
              ],
            ),
          ),
        ),
      ),
    ));
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
              height:_large? _height/9 : (_medium? _height/7.75 : _height/7.5),
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
              height: _large? _height/9.5 : (_medium? _height/7.5 : _height/7),
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
       /*   child: Image.asset(
            'assets/images/login.png',
            height: _height/3.5,
            width: _width/3.5,
          ),*/
        ),
      ],
    );
  }

  Widget form() {
    return Container(
      margin: EdgeInsets.only(
          left:_width/ 12.0,
          right: _width / 12.0,
          top: _height / 20.0),
      child: Form(
        child: Column(
          children: <Widget>[
            firstNameTextFormField(),
            SizedBox(height: _height / 60.0),
            lastNameTextFormField(),
            SizedBox(height: _height/ 60.0),
            emailTextFormField(),
            SizedBox(height: _height / 60.0),
            phoneTextFormField(),
            SizedBox(height: _height / 60.0),
            passwordTextFormField(),
          ],
        ),
      ),
    );
  }

  Widget firstNameTextFormField() {
    return CustomTextField(
      keyboardType: TextInputType.text,
      icon: Icons.person,
      hint: "First Name",
      textEditingController: prenom,
    );
  }

  Widget lastNameTextFormField() {
    return CustomTextField(
      keyboardType: TextInputType.text,
      icon: Icons.person,
      hint: "Last Name",
      textEditingController: nom,
    );
  }

  Widget emailTextFormField() {
    return CustomTextField(

      keyboardType: TextInputType.emailAddress,
      icon: Icons.email,
      hint: "Email",
      textEditingController: adressemail,
    );
  }

  Widget phoneTextFormField() {
    return CustomTextField(
      keyboardType: TextInputType.text,
      obscureText: true,
      icon: Icons.lock,
      hint: "Password",
      textEditingController: mdp,

    );
  }

  Widget passwordTextFormField() {
    return CustomTextField(
      keyboardType: TextInputType.text,
      obscureText: true,
      icon: Icons.lock,
      hint: "Repeat Password",
      textEditingController: rmdp,
    );
  }

  Widget acceptTermsTextRow() {
    return Container(
      margin: EdgeInsets.only(top: _height / 100.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Checkbox(
              activeColor: Colors.orange[200],
              value: checkBoxValue,
              onChanged: (bool newValue) {
                setState(() {
                  checkBoxValue = newValue;
                });
              }),
          Text(
            "I accept all terms and conditions",
            style: TextStyle(fontWeight: FontWeight.w400, fontSize: _large? 12: (_medium? 11: 10)),
          ),
        ],
      ),
    );
  }

  Widget button(context) {
    return RaisedButton(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
      onPressed: () {
        User euser = new User();
        euser.prenom = prenom.text.trim();
        euser.nom = nom.text.trim();
        euser.adressemail = adressemail.text.trim();
        euser.mdp = mdp.text.trim();

        if (Validator().validateName(euser.prenom) != null)
        {
          Scaffold
              .of(context)
              .showSnackBar(SnackBar(content: Text(
            Validator().validateName(euser.prenom),
            style: TextStyle(color: Colors.orange),)));
        }
        else if (Validator().validateName(euser.nom) != null)
        {
          Scaffold
              .of(context)
              .showSnackBar(SnackBar(content: Text("Last"+" "+
            Validator().validateName(euser.nom),
            style: TextStyle(color: Colors.orange),)));
        }
        else if (Validator().validateEmail(euser.adressemail) != null)
        {
          Scaffold
              .of(context)
              .showSnackBar(SnackBar(content: Text(
            Validator().validateEmail(euser.adressemail),
            style: TextStyle(color: Colors.orange))));
        }
        else if (Validator().validatePasswordLength(euser.mdp) != null)
        {
          Scaffold
              .of(context)
              .showSnackBar(SnackBar(content: Text(
            Validator().validatePasswordLength(euser.mdp),
            style: TextStyle(color: Colors.orange),)));
        }
        else if (Validator().validatePasswordLength(euser.mdp) != null)
        {
          Scaffold
              .of(context)
              .showSnackBar(SnackBar(content: Text(
            Validator().validatePasswordLength(euser.mdp),
            style: TextStyle(color: Colors.orange),)));
        }
        else if (euser.mdp.trim() != rmdp.text.trim())
        {
          Scaffold
              .of(context)
              .showSnackBar(SnackBar(content: Text("passwords don't match",
            style: TextStyle(color: Colors.deepOrange),)));
        }else {
          Future <dynamic> user = userService.getUserBeforeSignup(euser);
          user.then((value) {
            print(value);
            if (value == "AffectGood") {
              Navigator.push(context, PageRouteBuilder(
                transitionDuration: Duration(seconds: 2),
                transitionsBuilder: (context, animation, secondaryAnimation,
                    child) {
                  animation = CurvedAnimation(parent: animation, curve: Curves
                      .elasticInOut);
                  return Align(
                    alignment: Alignment.topCenter,
                    child: SizeTransition(sizeFactor: animation, child: child),
                  );
                },
                pageBuilder: (context, animation, secondaryAnimation) {
                  return SignInScreen();
                },
              ));
              // Navigator.of(context).pushNamed(SIGN_UP);
              print("Routing to Sign up screen");
            }
            else {
              Scaffold
                  .of(context)
                  .showSnackBar(SnackBar(content: Text(
                'oops something went wrong',
                style: TextStyle(color: Colors.red),)));
            }
          });
        }},
      textColor: Colors.white,
      padding: EdgeInsets.all(0.0),
      child: Container(
        alignment: Alignment.center,
        height: _height / 15,
        width:_large? _width/3 : (_medium? _width/3.5: _width/3.25),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20.0)),
          gradient: LinearGradient(
            colors: <Color>[Colors.orange[200], Colors.pinkAccent],
          ),
        ),
        padding: const EdgeInsets.all(12.0),
        child: Text('SIGN UP', style: TextStyle(fontSize: _large? 15: (_medium? 13: 11)),),
      ),
    );
  }

  Widget infoTextRow() {
    return Container(
      margin: EdgeInsets.only(top: _height / 40.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            "Or create using social media",
            style: TextStyle(fontWeight: FontWeight.w400, fontSize: _large? 12: (_medium? 11: 10)),
          ),
        ],
      ),
    );
  }

  Widget socialIconsRow() {
    return Container(
      margin: EdgeInsets.only(top: _height / 80.0),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          CircleAvatar(
            radius: 15,
            backgroundImage: AssetImage("assets/images/googlelogo.png"),
          ),
          SizedBox(
            width: 20,
          ),
          CircleAvatar(
            radius: 15,
            backgroundImage: AssetImage("assets/images/fblogo.jpg"),
          ),
          SizedBox(
            width: 20,
          ),
          CircleAvatar(
            radius: 15,
            backgroundImage: AssetImage("assets/images/twitterlogo.jpg"),
          ),
        ],
      ),
    );
  }

  Widget signInTextRow() {
    return Container(
      margin: EdgeInsets.only(top: _height / 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            "Already have an account?",
            style: TextStyle(fontWeight: FontWeight.w400),
          ),
          SizedBox(
            width: 5,
          ),
          GestureDetector(
            onTap: () {
              Navigator.of(context).pop(SIGN_IN);
              print("Routing to Sign up screen");
            },
            child: Text(
              "Sign in",
              style: TextStyle(
                  fontWeight: FontWeight.w800, color: Colors.orange[200], fontSize: 19),
            ),
          )
        ],
      ),
    );
  }

  Widget signUpTextRow() {
    return Container(
     // margin: EdgeInsets.only(left: _width / 15.0),
      child: Center(
        child:
        Text(
          "Sign up",
          style: TextStyle(
            fontWeight: FontWeight.w200,
            fontSize: _large? 30 : (_medium? 20.5 : 18),
          ),
        ),
      ),
    );
  }

}
