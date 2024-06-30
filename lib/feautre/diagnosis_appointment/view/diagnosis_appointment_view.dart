import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:student_smile/core/core.dart';
import 'package:student_smile/feautre/diagnosis_appointment/diagnosis_appointment.dart';
import 'package:student_smile/feautre/feautre.dart';

class DiagnosisAppointmentView extends StatelessWidget {
  DiagnosisAppointmentView({super.key});
  final DiagnosisAppointmentController _controller =
      Get.put(DiagnosisAppointmentController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
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
        if (_controller.diagnosis.isEmpty) {
          return const Center(child: Text("No diagnosis appointments."));
        }

        return GetBuilder(
          init: DiagnosisAppointmentController(),
          builder: (controller) => ListView.builder(
            itemCount: controller.diagnosis.length,
            itemBuilder: (context, index) {
              final diagnosis = controller.diagnosis[index];
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
                    radius: 30,
                    child:CachedNetworkImage(
                      imageUrl: '${controller.diagnosis[index].patient.image}',
                      httpHeaders: {
                        'X-Token': 'Bearer $tokens()',
                        'Authorization': basicAuth
                      },
                      placeholder: (context, url) =>
                          const CircularProgressIndicator(),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                      fit: BoxFit.cover,
                      width: 200,
                      height: double.infinity,
                    ),
                  ),
                  title: Text(
                    '${diagnosis.patient.fName} ${diagnosis.patient.lName}',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 5),
                      Text('Email: ${diagnosis.patient.email}'),
                      Text('Gender: ${diagnosis.patient.gender}'),
                      Text('Birthday: ${diagnosis.patient.birthday}'),
                    ],
                  ),
                  trailing: const Icon(Icons.arrow_forward_ios),
                  onTap: () {
                    controller.showLabItemsDialog(
                        context, controller.diagnosis[index]);
                  },
                ),
              );
            },
          ),
        );
      }),
    );
  }
}
