import 'package:student_smile/feautre/common/common.dart';

class ReferralsModel {
  final int id;
  final int pateintId;
  final String type;
  final String status;
  final PatientModel patient;

  ReferralsModel({
    required this.id,
    required this.pateintId,
    required this.type,
    required this.status,
    required this.patient,
  });

  factory ReferralsModel.fromJson(Map<String, dynamic> json) {
    return ReferralsModel(
      id: json['id'],
      pateintId: json['patient_cases']['id'],
      type: json['type_of_refarrals'],
      status: json['status_done'],
      patient: PatientModel.fromJson(json['patient_cases']['patient']),
    );
  }
}
