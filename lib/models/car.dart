class Car {
  String modele;
  String marque;
  String annee;
  String userId;
  String carId;
  String nbKilometre;
  String numChassi;
  String numImmatriculation;
  String urlcartegrise = "";
  String urlassurance = "";

  Car({
    required this.marque,
    required this.annee,
    required this.modele,
    required this.userId,
    required this.nbKilometre,
    required this.numImmatriculation,
    required this.numChassi,
    this.carId = "",
    this.urlassurance = "",
    this.urlcartegrise = "",
  });
}
