
import 'dart:convert';
import 'package:http/http.dart';
import 'package:safemap/services/link.dart';
import 'package:safemap/entities/user.dart';




class AcceuilService {

  Future<dynamic> getAllReports() async
  {
    Response res = await get(link.linkw+"/getReports");
    dynamic body = jsonDecode(res.body);
    return body;
  }

}