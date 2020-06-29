import 'dart:convert';
import '../models/AllModel.dart';
import '../models/ReservationModel.dart';
import 'package:http/http.dart' as http;

import '../models/GrandResidence.dart';
import 'package:flutter/foundation.dart';

class ResidenceProv with ChangeNotifier {
  List<Residence> loadResidence = [];
  List<ReservationModel> loadRev = [];
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

  Future getResidence() async {
    List<Residence> res = await Residence().getListResidence();
    print(res);
    if (res != null) {
      loadResidence = res;
    }
    notifyListeners();
  }

  Residence findById(int id) {
    return loadResidence.firstWhere((res) => res.id == id);
  }

  Future<void> addReservation(ReservationModel rev) async {
    const url = 'https://mas.wmcci.com/api/reservations';
    try {
      final response = await http.post(url,
          headers: {
            "Accept": "application/json",
            'Content-Type': 'application/json'
          },
          body: jsonEncode({
            'email': rev.email,
            'nom': rev.nom,
            'prenom': rev.prenom,
            'numero': rev.numero,
            'debut': debut.toString(),
            'fin': fin.toString(),
            "chambre": "/api/chambres/${chambre.id}"
          }));
      print(json.decode(response.body));
      final newRev = ReservationModel(
          email: rev.email,
          nom: rev.nom,
          prenom: rev.prenom,
          numero: rev.numero,
          debut: rev.debut,
          fin: rev.fin);
      loadRev.add(newRev);

      notifyListeners();
    } catch (error) {
      print(error);
      throw error;
    }
  }
}
