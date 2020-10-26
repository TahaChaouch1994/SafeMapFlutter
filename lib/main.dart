import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:safemap/constants/constants.dart';
import 'package:safemap/ui/signin.dart';
import 'package:safemap/ui/signup.dart';
import 'package:safemap/ui/splashscreen.dart';
import 'package:safemap/ui/widgets/acceuil.dart';
import 'package:safemap/ui/widgets/ajout_reclamation.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Login",
      theme: ThemeData(primaryColor: Colors.orange[200]),
      routes: <String, WidgetBuilder>{
        SPLASH_SCREEN: (BuildContext context) => SplashScreen(),
        SIGN_IN: (BuildContext context) =>  SignInPage(),
        SIGN_UP: (BuildContext context) =>  SignUpScreen(),
        AjoutReclamation: (BuildContext context) =>  Ajout(),
      },
      initialRoute: SPLASH_SCREEN,
    );
  }
}



