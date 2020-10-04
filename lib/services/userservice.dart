import 'dart:convert';
import 'package:http/http.dart';
import 'package:safemap/services/link.dart';

class UserService {



  Future<dynamic> getUserFromLogin(String adressemail) async
  {
    Response res = await get(link.linkw+"/signuptest?adressemail="+adressemail);
   /* if (res.statusCode == 200) {
      dynamic body = jsonDecode(res.body);
      return body;
    }
    else
    {
      throw "Can't get users.";
    } */

    dynamic body = jsonDecode(res.body);
    return body;
  }



}
