
class ReservationModel {
  int id;
  String email,nom,prenom,numero;
  DateTime debut,fin;

  ReservationModel({this.id, this.email, this.nom, this.prenom,this.numero, this.debut, this.fin});

  ReservationModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    nom = json['nom'];
    prenom = json['prenom'];
    numero = json['numero'];
    debut = json['debut'];
    fin = json['fin'];
    
   
  }
}