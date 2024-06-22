import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:student_smile/core/core.dart';
import 'package:student_smile/feautre/feautre.dart';

class PatientSessionView extends StatelessWidget {
  PatientSessionView({super.key});
  final PatientController _controller = Get.put(PatientController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('Number of Sessions ${_controller.patientSession.length}'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Obx(() {
          if (_controller.isLoading.value) {
            return ListView.builder(
              itemCount: 5,
              itemBuilder: (context, index) {
                return Shimmer.fromColors(
                  baseColor: Colors.grey[300]!,
                  highlightColor: Colors.grey[100]!,
                  child: Card(
                    elevation: 4,
                    color: Palette.primaryLight,
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    child: ListTile(
                      leading: Container(
                        width: 40,
                        height: 40,
                        color: Colors.white,
                      ),
                      title: Container(
                        width: double.infinity,
                        height: 20,
                        color: Colors.white,
                      ),
                      subtitle: Container(
                        width: double.infinity,
                        height: 20,
                        color: Colors.white,
                      ),
                      trailing: const Icon(Icons.arrow_forward_ios,
                          color: Palette.primary),
                    ),
                  ),
                );
              },
            );
          }
          if (_controller.patientSession.isEmpty) {
            return const Center(
                child: Text("No appointments for selected date."));
          }
          return ListView.builder(
            itemCount: _controller.patientSession.length,
            itemBuilder: (context, index) {
              final patientSessions = _controller.patientSession[index];
              return Card(
                elevation: 4,
                color: Palette.primaryLight,
                margin: const EdgeInsets.symmetric(vertical: 10),
                child: ListTile(
                  leading: const Icon(Icons.event, color: Palette.primary),
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Baraa Aldarsani',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        patientSessions.sessionModel.time,
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  subtitle: Text(
                      'Status: ${patientSessions.referralsModel.status}\nSupervisor: ${patientSessions.supervisorModel.fName} ${patientSessions.supervisorModel.lName}'),
                  trailing: const Icon(Icons.arrow_forward_ios,
                      color: Palette.primary),
                  onTap: () {
                    Get.to(SessionDetailsPage(dailyAppoint: patientSessions));
                  },
                ),
              );
            },
          );
        }),
      ),
    );
  }
}
