import 'dart:convert';
import 'package:http/http.dart';
import 'package:safemap/entities/report.dart';
import 'package:safemap/services/link.dart';

class MapService {



  Future <dynamic> reportincident(Report report) async
  {
    Response res = await post(link.linkw+"/report", headers: {"Content-Type": "application/json"}, body: jsonEncode(report));
    dynamic body = jsonDecode(res.body);
    return body;
  }




}
