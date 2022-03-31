class Facture {
  String nom;
  DateTime date;
  String commentaire;
  String carid;
  String scanurl = "";
  String factureid = "";

  Facture({
    required this.nom,
    required this.date,
    required this.commentaire,
    required this.carid,
    required this.scanurl,
    required this.factureid,
  });
}
