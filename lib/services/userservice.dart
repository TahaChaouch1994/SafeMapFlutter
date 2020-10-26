import 'dart:convert';
import 'package:http/http.dart';
import 'package:safemap/services/link.dart';
import 'package:safemap/entities/user.dart';

class UserService {



  Future<dynamic> getUserBeforeSignup(User user) async
  {


    Response res = await get(link.linkw+"/signuptest/"+user.adressemail);

    dynamic body = jsonDecode(res.body);


    if(body == "usergood")
      {
        Response res = await post(link.linkw+"/signup", headers: {"Content-Type": "application/json"}, body: jsonEncode(user));
        dynamic body2 = jsonDecode(res.body);
        return body2;
      }
  }




  Future<dynamic> login(User user) async
  {
    Response res = await post(link.linkw+"/login", headers: {"Content-Type": "application/json"}, body: jsonEncode(user));
      dynamic body = jsonDecode(res.body);
      return body;
  }

  Future<dynamic> getUserFromLogin(String login) async
  {
    Response res = await get(link.linkw+"/getuserfromlogin/"+login);
    dynamic body = jsonDecode(res.body);
    return body;
  }



}
