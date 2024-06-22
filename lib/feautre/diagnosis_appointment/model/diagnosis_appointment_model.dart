import 'package:student_smile/feautre/feautre.dart';

class DiagnosisAppointmentModel {
  final int id;
  final String date;
  final String time;
  final String status;
  final String reason;
  final PatientModel patient;

  DiagnosisAppointmentModel({
    required this.id,
    required this.date,
    required this.time,
    required this.status,
    required this.reason,
    required this.patient,
  });

  factory DiagnosisAppointmentModel.fromJson(Map<String, dynamic> json) {
    return DiagnosisAppointmentModel(
      id: json['id'],
      date: json['date'],
      time: json['timeDiagnosis'],
      status: json['order_status'],
      reason: json['reason'],
      patient: PatientModel.fromJson(json['patient']),
    );
  }
}
