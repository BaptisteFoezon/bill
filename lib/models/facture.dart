class Facture {
  String nom;
  DateTime date;
  String commentaire;
  String carid;
  String scanurl = "";
  String factureid = "";
  RevisionFacture? revisionFacture;
  PneumatiqueFacture? pneumatiqueFacture;

  Facture({
    required this.nom,
    required this.date,
    required this.commentaire,
    required this.carid,
    required this.scanurl,
    required this.factureid,
    this.revisionFacture,
    this.pneumatiqueFacture,
  });
}

class RevisionFacture {
  bool selected = false;
  bool? huileB = true;
  bool? pollenB = false;
  bool? airB = false;
  bool? carburantB = false;
  bool? freinB = false;
  bool? transmitionB = false;
  bool? boitevitesseB = false;
  bool? refroidissementB = false;
  RevisionFacture({dynamic});

  Map<String, dynamic> toMap() {
    return {
      "Filtre huile": huileB,
      "Filtre pollen": pollenB,
      "Filtre air": airB,
      "Filtre carburant": carburantB,
      "Liquide frein": freinB,
      "Huile transmition": transmitionB,
      "Huile boite de vitesse ": boitevitesseB,
      "Huile de refroidissement ": refroidissementB,
    };
  }

  RevisionFacture? fromMap(Map map) {
    RevisionFacture revisionFacture = RevisionFacture();
    revisionFacture.huileB = map["Filtre huile"];
    revisionFacture.pollenB = map["Filtre pollen"];
    revisionFacture.airB = map["Filtre air"];
    revisionFacture.carburantB = map["Filtre carburant"];
    revisionFacture.transmitionB = map["Huile transmition"];
    revisionFacture.boitevitesseB = map["Huile boite de vitesse "];
    revisionFacture.refroidissementB = map["Huile de refroidissement "];

    return revisionFacture;
  }
}

class PneumatiqueFacture {
  bool selected = false;
  bool? avantB = false;
  bool? arriereB = false;
  String? marque = "";
  bool? twoB = false;
  bool? fourB = false;
  bool? pneuHiverB = false;
  String? dimension = "";
  bool? geometrieB = false;

  PneumatiqueFacture({dynamic});

  Map<String, dynamic> toMap() {
    return {
      "Avant": avantB,
      "Arriere": arriereB,
      "Marque": marque,
      "2pneu": twoB,
      "4pneu": fourB,
      "Pneu hiver": pneuHiverB,
      "Dimension": dimension,
      "Géométrie": geometrieB,
    };
  }

  PneumatiqueFacture fromMap(Map map) {
    PneumatiqueFacture pneumatiqueFacture = PneumatiqueFacture();
    pneumatiqueFacture.avantB = map["Avant"];
    pneumatiqueFacture.arriereB = map["Arriere"];
    pneumatiqueFacture.marque = map["Marque"];
    pneumatiqueFacture.twoB = map["2pneu"];
    return pneumatiqueFacture;
  }
}

class FreinageFacture {
  bool selected = false;
  bool? avantB = false;
  bool? arriereB = false;
  bool? disqueAvantB = false;
  bool? disqueArriereB = false;
  bool? freinTambourB = false;
  bool? purgeLiquideB = false;

  FreinageFacture({dynamic});

  Map<String, dynamic> toMap() {
    return {
      "Avant": avantB,
      "Arriere": arriereB,
      "Disque avant": disqueAvantB,
      "Dique arriere": disqueArriereB,
      "Frein tambour": freinTambourB,
      "Purge de liquide de frein": purgeLiquideB,
    };
  }
}

class ControleTechniqueFacture {
  bool selected = false;
  bool? favorable = false;
  bool? contreVisite = false;
  String? contreVisiteTxt = "";

  ControleTechniqueFacture({dynamic});

  Map<String, dynamic> toMap() {
    return {
      "Favorable": favorable,
      "ContreVisite": contreVisite,
      "Commentaire contre visite": contreVisiteTxt,
    };
  }
}

class ElectriciteFacture {
  bool selected = false;
  bool? batterie = false;
  bool? alternateur = false;
  bool? demarreur = false;

  ElectriciteFacture({dynamic});

  Map<String, dynamic> toMap() {
    return {
      "Batterie": batterie,
      "Alternateur": alternateur,
      "Demarreur": demarreur,
    };
  }
}

class CourroieFacture {
  bool selected = false;
  bool? kitDeDistribution = false;
  bool? kitAccessoire = false;

  CourroieFacture({dynamic});

  Map<String, dynamic> toMap() {
    return {
      "Kit de distribution": kitDeDistribution,
      "Kit accessoire": kitAccessoire,
    };
  }
}

class EmbrayageFacture {
  bool selected = false;
  bool? embrayage = false;
  bool? butee = false;
  bool? volantMoteur = false;

  EmbrayageFacture({dynamic});

  Map<String, dynamic> toMap() {
    return {
      "Embrayage": embrayage,
      "Butée": butee,
      "Volant moteur": volantMoteur,
    };
  }
}

class AutreFacture {
  bool selected = false;
  String? commentaire = "";

  AutreFacture({dynamic});

  Map<String, dynamic> toMap() {
    return {
      "Commentaire": commentaire,
    };
  }
}
