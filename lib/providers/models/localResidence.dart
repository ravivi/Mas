import 'package:flutter/cupertino.dart';

class LocalResidence {
  final int id;
  final double lat;
  final double lng;
  final String nom;

  LocalResidence({
    @required this.id,
    @required this.lat,
    @required this.lng,
    @required this.nom,
  });
}

List<LocalResidence> localResidence = [
  //LocalResidence(id: 1,lat:5.3971078,lng:-3.9879164,1),
  LocalResidence(id: 1,lat: 5.3971078,lng: -3.9879164,nom: "Résidence Mas Angré 7ème tranche"),
  LocalResidence(id: 2,lat: 5.3691734,lng: -3.9458998,nom: "Résidence Mas Angré Palmeraie"), 
];