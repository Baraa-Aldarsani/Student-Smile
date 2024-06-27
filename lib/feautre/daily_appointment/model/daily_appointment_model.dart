import 'package:student_smile/feautre/feautre.dart';

class DailyAppointmentModel {
  final SessionModel sessionModel;
  final SupervisorModel supervisorModel;
  final SectionModel sectionModel;
  final ReferralsModel referralsModel;

  DailyAppointmentModel({
    required this.sessionModel,
    required this.supervisorModel,
    required this.sectionModel,
    required this.referralsModel,
  });

  factory DailyAppointmentModel.fromJson(Map<String, dynamic> json) {
    return DailyAppointmentModel(
      sessionModel: SessionModel.fromJson(json),
      supervisorModel: json['supervisor'] != null
          ? SupervisorModel.fromJson(json['supervisor'])
          : SupervisorModel.empty(),
      sectionModel: SectionModel.fromJson(json['clinics']),
      referralsModel: ReferralsModel.fromJson(json['referrals']),
    );
  }
}
