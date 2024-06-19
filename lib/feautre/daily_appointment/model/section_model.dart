class SectionModel {
  final int id;
  final String name;
  final int clinicID;
  final int clinicNumber;

  SectionModel({
    required this.id,
    required this.name,
    required this.clinicID,
    required this.clinicNumber,
  });

  factory SectionModel.fromJson(Map<String, dynamic> json) {
    return SectionModel(
      id: json['sections']['id'],
      name: json['sections']['name'],
      clinicID: json['id'],
      clinicNumber: json['number'],
    );
  }
}
