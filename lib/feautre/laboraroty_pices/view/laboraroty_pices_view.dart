import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:student_smile/core/core.dart';
import 'package:student_smile/feautre/feautre.dart';

class LaborarotyPicesView extends StatelessWidget {
  LaborarotyPicesView({super.key});
  final LaborarotyPicesController _controller =
      Get.put(LaborarotyPicesController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(AddLaborarotyPices());
        },
        backgroundColor: Palette.primary,
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      body: FutureBuilder(
        future: _controller.getRequiredMaterial(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return ListView.separated(
              itemCount: 5,
              itemBuilder: (context, index) => Shimmer.fromColors(
                baseColor: Palette.grey,
                highlightColor: Palette.primaryLight,
                child: Container(
                  height: 55,
                  margin: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Palette.primaryLight,
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.shade500,
                        offset: const Offset(1.5, 1.5),
                        blurRadius: 2,
                      )
                    ],
                  ),
                ),
              ),
              separatorBuilder: (BuildContext context, int index) =>
                  const SizedBox(height: 10),
            );
          } else if (snapshot.hasError) {
            return const Text("Error");
          } else {
            return GetBuilder(
              init: LaborarotyPicesController(),
              builder: (controller) => ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                itemCount: controller.requiredMaterial.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Column(
                      children: [
                        Slidable(
                          key: Key(
                              controller.requiredMaterial[index].id.toString()),
                          startActionPane: ActionPane(
                            motion: const ScrollMotion(),
                            children: [
                              SlidableAction(
                                onPressed: (_) {
                                  controller.deleteProduct(
                                      controller.requiredMaterial[index].id);
                                },
                                backgroundColor: Palette.red,
                                foregroundColor: Colors.white,
                                icon: Icons.delete,
                                label: 'Delete',
                              ),
                            ],
                          ),
                          child: Container(
                            height: 55,
                            decoration: BoxDecoration(
                              color: Palette.primaryLight,
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(10)),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.shade500,
                                  offset: const Offset(1.5, 1.5),
                                  blurRadius: 2,
                                )
                              ],
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 20.0),
                                  child: Text(
                                    controller.requiredMaterial[index].name,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyLarge
                                        ?.copyWith(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 18),
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    controller.updateSelectedIndex(index);
                                  },
                                  child: Container(
                                    height: MediaQuery.of(context).size.height,
                                    width: 55,
                                    decoration: const BoxDecoration(
                                        color: Palette.primaryDark,
                                        borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(10),
                                          bottomRight: Radius.circular(10),
                                        )),
                                    child: Icon(
                                      controller.selectedMaterila == index
                                          ? Icons.remove
                                          : Icons.add,
                                      color: Palette.background,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        if (controller.selectedMaterila == index)
                          Container(
                            height: 100,
                            width: double.infinity,
                            margin: const EdgeInsets.only(
                                left: 10, right: 10, top: 5),
                            decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: CachedNetworkImage(
                              imageUrl:
                                  controller.requiredMaterial[index].image,
                              httpHeaders: {
                                'X-Token': 'Bearer $tokens()',
                                'Authorization': basicAuth
                              },
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
                                  Shimmer.fromColors(
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
                              fit: BoxFit.fill,
                            ),
                          )
                      ],
                    ),
                  );
                },
              ),
            );
          }
        },
      ),
    );
  }
}
