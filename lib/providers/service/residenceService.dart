import 'dart:convert';
import 'package:Mas/providers/models/ReservationModel.dart';
import 'package:http/http.dart' as http;

import '../models/GrandResidence.dart';
import 'package:flutter/foundation.dart';

class ResidenceProv with ChangeNotifier {
  List<Residence> loadResidence = [];
  List<ReservationModel> loadRev = [];

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
          body: json.encode({
            'email': rev.email,
            'nom': rev.nom,
            'prenom': rev.prenom,
            'numero': rev.numero,
            'debut': rev.debut,
            'fin': rev.fin
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
