import 'dart:io';

import 'package:ashlife/Screen/view_share_image.dart';
import 'package:ashlife/controller/auth.controller.dart';
import 'package:ashlife/controller/category.controller.dart';
import 'package:ashlife/controller/home.controller.dart';
import 'package:ashlife/controller/navigation.controller.dart';
import 'package:ashlife/services/notify.dart';
import 'package:ashlife/widgets/custom_button.dart';
import 'package:ashlife/widgets/image.dart';
import 'package:ashlife/widgets/skeleton.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:convert';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  CategoryController _categoryController = Get.put(CategoryController());
  AuthController _authController = Get.put(AuthController());
  HomeController _homeController = Get.put(HomeController());
  final List _filterImage = [];

  @override
  void initState() {
    // _categoryController.inittialData();
    _categoryController.getFilters();
    _authController.getCurrentUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, top: 15),
      child: Column(
        children: [
          const SizedBox(
            height: 30,
          ),
          Row(
            children: <Widget>[
              Obx(() {
                String name = Get.find<AuthController>().user.value.name ?? 'A';
                String avatar = Get.find<AuthController>().avatar.value;
                if (avatar == '') {
                  return CircleAvatar(
                    radius: 30,
                    backgroundColor: const Color(0xff253890),
                    child: Text(
                      name[0].toUpperCase(),
                      style: const TextStyle(
                          color: Colors.white, fontWeight: FontWeight.w600),
                    ),
                  );
                }
                return CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.white,
                  backgroundImage: FileImage(File(avatar)),
                );
              }),
              const SizedBox(
                width: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'welcome'.tr,
                    style: const TextStyle(
                        color: Color(0xff253890),
                        fontSize: 30,
                        fontWeight: FontWeight.w700),
                  ),
                  Obx(() {
                    String name = _authController.user.value.name ?? '';
                    return Text(
                      name,
                      style: const TextStyle(
                          color: Colors.black54,
                          fontSize: 21,
                          fontWeight: FontWeight.w700),
                    );
                  })
                ],
              ),
            ],
          ),
          const SizedBox(height: 15),
          SizedBox(
            height: 110,
            child: Obx(() {
              bool loading = _categoryController.filterLoading.value;
              List filters = _categoryController.filters.value;
              if (loading) {
                return ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) => const SizedBox(
                          width: 110,
                          height: 110,
                          child: Skeleton(width: 110, height: 110),
                        ),
                    separatorBuilder: (context, _) => const SizedBox(
                          width: 5,
                        ),
                    itemCount: 3);
              }
              return ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) => FilterItem(
                        filter: filters[index],
                        controller: _homeController,
                      ),
                  separatorBuilder: (context, _) => const SizedBox(
                        width: 5,
                      ),
                  itemCount: filters.length);
            }),
          ),
          const SizedBox(height: 15),
          Expanded(child: Obx(() {
            List images = _homeController.images.value;
            bool isLoading = _homeController.isLoading.value;

            if (isLoading) {
              return const Center(
                child: SizedBox(
                  height: 50,
                  width: 50,
                  child: CircularProgressIndicator(
                    color: Color(0xff253890),
                  ),
                ),
              );
            }
            return images.isEmpty
                ? Padding(
                    padding: const EdgeInsets.all(60),
                    child: Column(
                      children: [
                        const SizedBox(height: 50),
                        const AshlifeImage(
                          height: 200,
                          width: 200,
                          path: 'assets/img/empty.png',
                        ),
                        CustomButton(
                            text: 'txt_get_starting'.tr,
                            textColor: Colors.white,
                            color: const Color(0xff253890),
                            pressed: () {
                              // final payload = json.encode({'to': 'main'});
                              // Notify().showNotification(
                              //     title: 'Model generation',
                              //     body:
                              //         'Your model has been generated successfully',
                              //     payLoad: payload);
                              Get.find<NavigationController>().changePage(1);
                            },
                            isLoading: false)
                      ],
                    ),
                  )
                : GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithMaxCrossAxisExtent(
                            maxCrossAxisExtent: 200,
                            childAspectRatio: 1,
                            crossAxisSpacing: 15,
                            mainAxisSpacing: 15),
                    itemCount: images.length,
                    itemBuilder: (_, index) {
                      return Material(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(10),
                        child: InkWell(
                          onTap: () {
                            Get.to(
                                ViewShareImage(
                                  path: images[index]["file"].path,
                                ),
                                duration: const Duration(milliseconds: 800),
                                transition: Transition.rightToLeft);
                          },
                          onLongPress: () {},
                          child: Stack(
                            children: [
                              Container(
                                width: double.infinity,
                                height: double.infinity,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  image: DecorationImage(
                                    image: FileImage(images[index]["file"]),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
          })),
        ],
      ),
    );
  }
}

class FilterItem extends StatelessWidget {
  final Map<String, dynamic> filter;
  final HomeController controller;

  const FilterItem({
    super.key,
    required this.filter,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () => controller.changeFilter(id: filter['id']),
        child: Obx(() {
          String id = controller.filterId.value;

          if (filter['id'] == id) {
            return Container(
              height: 100,
              width: 100,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                image: DecorationImage(
                    image: FileImage(filter['file']),
                    fit: BoxFit.cover,
                    colorFilter: const ColorFilter.mode(
                        Colors.white, BlendMode.overlay)),
              ),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    gradient: LinearGradient(colors: [
                      const Color(0xff253890).withOpacity(0.6),
                      const Color(0xff1c40f3).withOpacity(0.6),
                    ], stops: [
                      0.0,
                      1
                    ], begin: Alignment.center)),
                child: Center(
                  child: Text(
                    filter['name'],
                    style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: 16),
                  ),
                ),
              ),
            );
          }
          return Container(
            height: 100,
            width: 100,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              image: DecorationImage(
                image: FileImage(filter['file']),
                fit: BoxFit.cover,
              ),
            ),
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  gradient: LinearGradient(colors: [
                    const Color(0xff253890).withOpacity(0.6),
                    const Color(0xff1c40f3).withOpacity(0.6),
                  ], stops: [
                    0.0,
                    1
                  ], begin: Alignment.center)),
              child: Center(
                child: Text(
                  filter['name'],
                  style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: 16),
                ),
              ),
            ),
          );
        }));
  }
}
