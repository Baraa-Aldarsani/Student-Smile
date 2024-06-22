import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:student_smile/core/core.dart';
import 'package:student_smile/feautre/feautre.dart';

class DailyAppointmentView extends StatelessWidget {
  DailyAppointmentView({super.key});
  final DailyAppointmentController _controller =
      Get.put(DailyAppointmentController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Card(
              elevation: 4,
              margin: const EdgeInsets.symmetric(vertical: 10),
              child: CustomTextField(
                title: _controller.dateController.text,
                readOnly: true,
                icon: Icons.date_range,
                onTap: () => _controller.selectDate(context),
                controller: _controller.dateController,
                color: Palette.primaryLight,
              ),
            ),
            Obx(() {
              if (_controller.isLoading.value) {
                return Expanded(
                  child: ListView.builder(
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
                  ),
                );
              }
              if (_controller.daily.isEmpty) {
                return const Center(
                    child: Text("No appointments for selected date."));
              }
              return Expanded(
                child: ListView.builder(
                  itemCount: _controller.daily.length,
                  itemBuilder: (context, index) {
                    final dailyApp = _controller.daily[index];
                    return Card(
                      elevation: 4,
                      color: Palette.primaryLight,
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      child: ListTile(
                        leading:
                            const Icon(Icons.event, color: Palette.primary),
                        title: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Baraa Aldarsani',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              dailyApp.sessionModel.time,
                              style: const TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        subtitle: Text(
                            'Status: ${dailyApp.referralsModel.status}\nSupervisor: ${dailyApp.supervisorModel.fName} ${dailyApp.supervisorModel.lName}'),
                        trailing: const Icon(Icons.arrow_forward_ios,
                            color: Palette.primary),
                        onTap: () {
                          Get.to(SessionDetailsPage(dailyAppoint: dailyApp));
                        },
                      ),
                    );
                  },
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
