import 'dart:convert';

import 'package:http/http.dart' as http;

class Residence {
  int id;
  String nom;
  String numero;
  String emplacement;
  String position;
  String image;

  Residence(
      {this.id,
      this.nom,
      this.numero,
      this.emplacement,
      this.position,
      this.image});

  Residence.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nom = json['nom'];
    numero = json['numero'];
    emplacement = json['emplacement'];
    position = json['position'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['nom'] = this.nom;
    data['numero'] = this.numero;
    data['emplacement'] = this.emplacement;
    data['position'] = this.position;
    data['image'] = this.image;
    return data;
  }

  Future getListResidence() async {
    final res = await http.get(
        Uri.encodeFull("https://mas.wmcci.com/api/residences"),
        headers: {"Accept": "application/json"});
        
   final list = json.decode(res.body) as List<dynamic>;
  // print(json.decode(res.body).runtimeType);
    List<Residence> arr = list.map((item) => Residence.fromJson(item)).toList();
    //print(arr[0].nom);
    return arr;
  }

}
