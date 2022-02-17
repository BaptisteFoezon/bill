class Facture {
  String nom;
  DateTime date;
  String commentaire;
  String carid;
  String scanurl = "";

  Facture({
    required this.nom,
    required this.date,
    required this.commentaire,
    required this.carid,
    this.scanurl = "",
  });
}
