class Report {

  String id;
  String usermail;
  String victim;
  String contact;
  String description;


  Report.fromJsonMap(Map<String, dynamic> map):
        id = map["id"],
        usermail = map["usermail"],
        victim = map["victim"],
        contact = map["contact"],
        description = map["description"];


  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['usermail'] = usermail;
    data['victim'] = victim;
    data['contact'] = contact;
    data['description'] = description;
    return data;
  }

  Report();
}
