class DiseasesModel {
  final int id;
  final String name;
  DiseasesModel({
    required this.id,
    required this.name,
  });

  factory DiseasesModel.fromJson(Map<dynamic, dynamic> json,
      {int healthRecord = 0}) {
    if (healthRecord == 0) {
      return DiseasesModel(
        id: json['id'],
        name: json['name'],
      );
    } else {
      return DiseasesModel(
        id: json['preexisting_disease']['id'],
        name: json['preexisting_disease']['name'],
      );
    }
  }
}
