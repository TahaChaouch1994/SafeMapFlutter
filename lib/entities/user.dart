class User {

  String id;
  String adressemail;
  String prenom;
  String nom;
  String mdp;


  User.fromJsonMap(Map<String, dynamic> map):
        id = map["id"],
        adressemail = map["adressemail"],
        prenom = map["prenom"],
        nom = map["nom"],
        mdp = map["mdp"];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['adressemail'] = adressemail;
    data['prenom'] = prenom;
    data['nom'] = nom;
    data['mdp'] = mdp;
    return data;
  }

  User();
}