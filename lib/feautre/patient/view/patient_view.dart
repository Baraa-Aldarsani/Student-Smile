import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:student_smile/feautre/feautre.dart';

import '../../../core/core.dart';

class PatientView extends StatelessWidget {
  PatientView({super.key});

  final PatientController _controller = Get.put(PatientController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
          future: _controller.getAllPatients(),
          builder: (context, snapshot) {
            if (_controller.isLoading.value ||
                snapshot.connectionState == ConnectionState.waiting) {
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
            if (_controller.patient.isEmpty) {
              return const Center(child: Text("No Patient Now."));
            }
            return ListView.builder(
              itemCount: _controller.patient.length,
              itemBuilder: (context, index) {
                final patient = _controller.patient[index];
                return Card(
                  color: Palette.primaryLight,
                  margin: const EdgeInsets.all(10),
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(10),
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(patient.image),
                      radius: 30,
                    ),
                    title: Text(
                      '${patient.fName} ${patient.lName}',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 5),
                        Text('Email: ${patient.email}'),
                        Text('Gender: ${patient.gender}'),
                        Text('Birthday: ${patient.birthday}'),
                      ],
                    ),
                    trailing: const Icon(Icons.arrow_forward_ios),
                    onTap: () {
                      _controller.getPatientSession(patient.id);
                      Get.to(() => PatientSessionView());
                    },
                  ),
                );
              },
            );
          }),
    );
  }
}
