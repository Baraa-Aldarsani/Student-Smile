class SupervisorModel {
  final int id;
  final String fName;
  final String lName;
  final String type;
  SupervisorModel({
    required this.id,
    required this.fName,
    required this.lName,
    required this.type,
  });

  factory SupervisorModel.fromJson(Map<String, dynamic> json) {
    return SupervisorModel(
      id: json['id'],
      fName: json['first_name'],
      lName: json['last_name'],
      type: json['type'],
    );
  }

  factory SupervisorModel.empty() {
    return SupervisorModel(
      id: -1,
      fName: '',
      lName: '',
      type: '',
    );
  }
}
