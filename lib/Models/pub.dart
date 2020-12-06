class Pub {
  int id;
  String titre;
  String detail;
  String photo;

  Pub({this.id, this.titre, this.detail, this.photo});

  factory Pub.fromJson(Map<String, dynamic> json) {
    return Pub(
      id: json['id'] as int,
      titre: json['titre'] as String,
      detail: json['detail'] as String,
      photo: json['photo'] as String
    );
  }
}
