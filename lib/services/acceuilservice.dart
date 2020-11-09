
import 'dart:convert';
import 'package:http/http.dart';
import 'package:safemap/services/link.dart';




class AcceuilService {

  Future<dynamic> getAllReports() async
  {
    Response res = await get(link.linkw+"/getReports");
    dynamic body = jsonDecode(res.body);
    return body;
  }

  Future<dynamic> getMaps() async
  {
    Response res = await get(link.linkw+"/getMaps");
    dynamic body = jsonDecode(res.body);
    return body;
  }




}