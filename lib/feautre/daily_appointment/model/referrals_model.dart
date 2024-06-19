class ReferralsModel {
  final int id;
  final String type;
  final String status;

  ReferralsModel({
    required this.id,
    required this.type,
    required this.status,
  });

  factory ReferralsModel.fromJson(Map<String, dynamic> json) {
    return ReferralsModel(
      id: json['id'],
      type: json['type_of_refarrals'],
      status: json['status_done'],
    );
  }
}
