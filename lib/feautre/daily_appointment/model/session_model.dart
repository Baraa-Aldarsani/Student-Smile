class SessionModel {
  final int id;
  double? evaluation;
  String? supervisorNotes;
  final String history;
  final String time;
  final String status;

  SessionModel({
    required this.id,
    this.evaluation,
    this.supervisorNotes,
    required this.history,
    required this.time,
    required this.status,
  });

  factory SessionModel.fromJson(Map<String, dynamic> json) {
    return SessionModel(
      id: json['id'],
      evaluation: (json['supervisor_evaluation'] != null)
          ? json['supervisor_evaluation'].toDouble()
          : null,
      supervisorNotes:
          (json['supervisor_notes'] != null) ? json['supervisor_notes'] : 'No comment yet',
      history: json['history'],
      time: json['timeSession'],
      status: json['status_of_session'],
    );
  }
}
