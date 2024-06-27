import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:student_smile/core/core.dart';
import 'package:student_smile/feautre/feautre.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  final HomeController _controller = Get.put(HomeController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            _headerWidget(),
            _bodyWidget(),
          ],
        ),
      ),
    );
  }

  Widget _bodyWidget() {
    return FutureBuilder(
        future: _controller.selectedIndexButtons.value == 0
            ? _controller.getPatientFromDepartment()
            : _controller.selectedIndexButtons.value == 1
                ? _controller.getPatientFromStudent()
                : _controller.getPatientFromStudent(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: ListView.separated(
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    return Shimmer.fromColors(
                      baseColor: Palette.grey,
                      highlightColor: Palette.primaryLight,
                      child: Container(
                        height: 62,
                        decoration: const BoxDecoration(
                          color: Palette.primaryLight,
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 10),
                ),
              ),
            );
          } else if (snapshot.hasError) {
            return const Center(child: Text("Error"));
          } else {
            return GetBuilder(
              init: HomeController(),
              builder: (controller) => Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: ListView.separated(
                    itemCount: controller.selectedIndexButtons.value == 0
                        ? controller.patienSection.length
                        : controller.selectedIndexButtons.value == 1
                            ? controller.patienStudent.length
                            : controller.patienStudent.length,
                    itemBuilder: (context, index) {
                      return Container(
                        height: 62,
                        decoration: const BoxDecoration(
                          color: Palette.primaryLight,
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        child: Obx(
                          () => ListTile(
                            dense: true,
                            leading: CircleAvatar(
                              child: CachedNetworkImage(
                                imageUrl: controller
                                            .selectedIndexButtons.value ==
                                        0
                                    ? controller
                                        .patienSection[index].patientModel.image
                                    : controller.selectedIndexButtons.value == 1
                                        ? controller.patienStudent[index]
                                            .patientModel.image
                                        : controller.patienStudent[index]
                                            .patientModel.image,
                                placeholder: (context, url) =>
                                    const CircularProgressIndicator(),
                                errorWidget: (context, url, error) =>
                                    const Icon(Icons.error),
                                fit: BoxFit.cover,
                                width: 200,
                                height: double.infinity,
                              ),
                            ),
                            title: Text(controller.selectedIndexButtons.value ==
                                    0
                                ? "${controller.patienSection[index].patientModel.fName} ${controller.patienSection[index].patientModel.lName}"
                                : controller.selectedIndexButtons.value == 1
                                    ? "${controller.patienStudent[index].patientModel.fName} ${controller.patienStudent[index].patientModel.lName}"
                                    : "${controller.patienStudent[index].patientModel.fName} ${controller.patienStudent[index].patientModel.lName}"),
                            subtitle: Text(
                                controller.selectedIndexButtons.value == 0
                                    ? controller.patienSection[index]
                                        .typeOfCaseseModel.nameSection
                                    : controller.selectedIndexButtons.value == 1
                                        ? controller.patienStudent[index]
                                            .typeOfCaseseModel.nameSection
                                        : controller.patienStudent[index]
                                            .typeOfCaseseModel.nameSection),
                            trailing: const Icon(Icons.arrow_forward_ios,
                                color: Palette.primary),
                            onTap: () {
                              int id = 0;
                              int status = 0;
                              status =
                                  controller.selectedIndexButtons.value == 0
                                      ? 0
                                      : 1;
                              controller.selectedIndexButtons.value == 0
                                  ? id = controller.patienSection[index].id
                                  : id = controller.patienStudent[index].id;
                              controller.showAlertDialog(context, id, status);
                            },
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 10),
                  ),
                ),
              ),
            );
          }
        });
  }

  SizedBox _headerWidget() {
    return SizedBox(
      height: 40,
      child: GetBuilder(
        init: HomeController(),
        builder: (controller) => ListView.separated(
          scrollDirection: Axis.horizontal,
          itemCount: 3,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                controller.changeColor(index);
                controller.refreshPage();
              },
              borderRadius: const BorderRadius.all(Radius.circular(20)),
              splashColor: Palette.primaryLight,
              child: Container(
                width: 108,
                decoration: BoxDecoration(
                    color: controller.getColorButtons(index),
                    borderRadius: const BorderRadius.all(Radius.circular(20)),
                    border: Border.all(width: 1, color: Palette.primary)),
                alignment: Alignment.center,
                child: Text(
                  controller.title[index],
                  style: TextStyle(
                      color: controller.getColorText(index), fontSize: 13),
                ),
              ),
            );
          },
          separatorBuilder: (BuildContext context, int index) =>
              const SizedBox(width: 10),
        ),
      ),
    );
  }
}
