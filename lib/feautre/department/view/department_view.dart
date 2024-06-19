import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:student_smile/core/core.dart';
import 'package:student_smile/feautre/feautre.dart';

class DepartmentView extends StatelessWidget {
  DepartmentView({super.key});
  final DepartmentController _controller = Get.put(DepartmentController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            _headerWidget(),
            _bodyWidget(),
          ],
        ),
      ),
    );
  }

  Expanded _bodyWidget() {
    return Expanded(
      child: FutureBuilder(
          future: _controller.getInfoDepartment(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Column(
                children: [
                  const SizedBox(height: 20),
                  Shimmer.fromColors(
                    baseColor: Palette.grey,
                    highlightColor: Palette.primaryLight,
                    child: Container(
                      height: 155,
                      decoration: const BoxDecoration(
                        color: Palette.primaryLight,
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Expanded(
                    child: ListView.separated(
                      itemCount: 5,
                      itemBuilder: (context, index) => Shimmer.fromColors(
                        baseColor: Palette.grey,
                        highlightColor: Palette.primaryLight,
                        child: Container(
                          height: 20,
                          color: Palette.primaryLight,
                        ),
                      ),
                      separatorBuilder: (BuildContext context, int index) =>
                          const SizedBox(height: 15),
                    ),
                  )
                ],
              );
            } else if (snapshot.hasError) {
              return const Text("Error");
            } else {
              return Obx(
                () => ListView(
                  children: [
                    Container(
                      height: 155,
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: CachedNetworkImage(
                        imageUrl: _controller
                            .department[_controller.selectedIndexButtons.value]
                            .image,
                        placeholder: (context, url) => Shimmer.fromColors(
                          baseColor: Palette.grey,
                          highlightColor: Palette.primaryLight,
                          child: Container(
                            height: 62,
                            decoration: const BoxDecoration(
                              color: Palette.primaryLight,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                            ),
                          ),
                        ),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                        fit: BoxFit.cover,
                      ),
                    ),
                    Text(
                      _controller
                          .department[_controller.selectedIndexButtons.value]
                          .details,
                      style: const TextStyle(height: 1.8, fontSize: 16),
                    ),
                  ],
                ),
              );
            }
          }),
    );
  }

  Widget _headerWidget() {
    return FutureBuilder(
        future: _controller.getInfoDepartment(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return SizedBox(
              height: 40,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: 3,
                itemBuilder: (context, index) => Shimmer.fromColors(
                  baseColor: const Color.fromRGBO(229, 226, 231, 1),
                  highlightColor: Palette.primaryLight,
                  child: Container(
                    width: 108,
                    decoration: const BoxDecoration(
                      color: Palette.primaryLight,
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                  ),
                ),
                separatorBuilder: (BuildContext context, int index) =>
                    const SizedBox(width: 10),
              ),
            );
          } else if (snapshot.hasError) {
            return const Text("Error");
          } else {
            return SizedBox(
              height: 40,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: _controller.department.length,
                itemBuilder: (context, index) {
                  return Obx(
                    () => InkWell(
                      onTap: () {
                        _controller.changeColor(index);
                      },
                      borderRadius: const BorderRadius.all(Radius.circular(20)),
                      splashColor: Palette.primaryLight,
                      child: Container(
                        width: 108,
                        decoration: BoxDecoration(
                            color: _controller.getColorButtons(index),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(20)),
                            border:
                                Border.all(width: 1, color: Palette.primary)),
                        alignment: Alignment.center,
                        child: Text(
                          _controller.department[index].name,
                          style: TextStyle(
                              color: _controller.getColorText(index),
                              fontSize: 13),
                        ),
                      ),
                    ),
                  );
                },
                separatorBuilder: (BuildContext context, int index) =>
                    const SizedBox(width: 10),
              ),
            );
          }
        });
  }
}
