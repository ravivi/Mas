import 'dart:convert';

import 'package:Mas/providers/models/GrandResidence.dart';
import 'package:Mas/providers/models/ReservationModel.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import '../models/AllModel.dart';

class ChambreService with ChangeNotifier {

  final String url = 'https://mas.wmcci.com/api';

  Residence residence;
  DateTime debut;
  DateTime fin;
  Chambres chambre;

  setParameters({Residence residence, DateTime debut, DateTime fin}) {
    this.residence = residence;
    this.debut = debut;
    this.fin = fin;
  }

  setChambre(Chambres chambre) {
    this.chambre = chambre;
  }

  Future<int> setReservation({String email, String nom, String prenom,String numero})  async{
    final res = await http.post('$url/reservations', headers: {"Accept": "application/json", 'Content-Type': 'application/json'}, body: jsonEncode({
  "email": email,
  "nom": nom,
  "prenom": prenom,
  "numero": numero,
  "debut": debut.toString(),
  "fin": fin.toString(),
  "chambre": "/api/chambres/${chambre.id}"
}));

if(res.statusCode == 201){
print(res.body);
    final Map<String,dynamic> body = jsonDecode(res.body);

    return body["id"] as int;
}
else if (res.statusCode == 404){
  return -1;
}
else{
  return 0;
}
  
    //print(body);
  }

  Future<List<Chambres>> fetchAvailable() async {
    final res = await http.get('$url/residences/${residence.id}/chambres?available_interval=$debut|$fin', headers: {"Accept": "application/json"});
    final body = jsonDecode(res.body);

    return body.map((json) => Chambres.fromJson(json)).toList().cast<Chambres>();
  }

}