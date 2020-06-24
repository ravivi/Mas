class ResidenceModel {
  final int id;
  final String name, image, adress, number, localisation;

  ResidenceModel({
    this.id,
    this.name,
    this.image,
    this.adress,
    this.number,
    this.localisation,
  });
}

List<ResidenceModel> residenceList = [
  ResidenceModel(
    id: 1,
    name: "Résidence MAS Angré 7ème tranche",
    image: "img1.jpg",
    adress: "lot 288 ilot 3436 3436, Abidjan",
    number: "+225 22 50 82 83",
    localisation:
        'https://www.google.com/maps/place/R%C3%A9sidence+Mas+Angr%C3%A9+7%C3%A8me+tranche/@5.3971078,-3.9879164,15z/data=!4m8!3m7!1s0x0:0xa1db360b5072f3f1!5m2!4m1!1i2!8m2!3d5.3971078!4d-3.9879164'),
    ResidenceModel(
    id: 2,
    name: "Résidence MAS Angré Palmeraie",
    image: "img2.jpg",
    adress: "7ème TRANCHE, Abidjan",
    number: "+225 48 75 59 35",
    localisation:
  "https://www.google.com/maps/place/RESIDENCE+MAS+ANGRE+PALMERAIE/@5.3968124,-3.9901393,17z/data=!3m1!4b1!4m8!3m7!1s0xfc1935a557e27d3:0xfa1f98f6e0969f31!5m2!4m1!1i2!8m2!3d5.3968071!4d-3.9879506" ),
];
