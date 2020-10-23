class Report {

  String id;
  String usermail;
  String victim;
  String contact;
  String description;
  String longitude;
  String latitude;
  List<String>  objetvole;


  Report.fromJsonMap(Map<String, dynamic> map):
        id = map["id"],
        usermail = map["usermail"],
        victim = map["victim"],
        contact = map["contact"],
        description = map["description"],
        longitude = map["longitude"],
        objetvole = map["objetvole"],
        latitude = map["latitude"];




  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['usermail'] = usermail;
    data['victim'] = victim;
    data['contact'] = contact;
    data['description'] = description;
    data['longitude'] = longitude;
    data['latitude'] = latitude;
    data['objetvole'] = objetvole;
    return data;
  }

  Report();
}
