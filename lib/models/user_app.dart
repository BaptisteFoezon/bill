class UserApp {
  String id;
  String nom;
  String email;
  String phone;
  String imgPath;

  UserApp(
      {required this.id,
      required this.nom,
      required this.email,
      required this.phone,
      this.imgPath = ""});
}
