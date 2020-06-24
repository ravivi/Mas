class Chambres {
  int id;
  Categorie categorie;
  String description;
  int prix;
  List<Images> images;

  Chambres({this.id, this.categorie, this.description, this.prix, this.images});

  Chambres.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    categorie = json['categorie'] != null
        ? new Categorie.fromJson(json['categorie'])
        : null;
    description = json['description'];
    prix = json['prix'];
    if (json['images'] != null) {
      images = new List<Images>();
      json['images'].forEach((v) {
        images.add(new Images.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.categorie != null) {
      data['categorie'] = this.categorie.toJson();
    }
    data['description'] = this.description;
    data['prix'] = this.prix;
    if (this.images != null) {
      data['images'] = this.images.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Categorie {
  int id;
  String nom;

  Categorie({this.id, this.nom});

  Categorie.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nom = json['nom'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['nom'] = this.nom;
    return data;
  }
}

class Images {
  int id;
  String image;

  Images({this.id, this.image});

  Images.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['image'] = this.image;
    return data;
  }
}

class Category {
  int id;
  String nom;
  List<String> chambres;

  Category({this.id, this.nom, this.chambres});

  Category.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nom = json['nom'];
    chambres = json['chambres'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['nom'] = this.nom;
    data['chambres'] = this.chambres;
    return data;
  }
}
