import 'package:ashlife/Screen/Auth/register.dart';
import 'package:ashlife/controller/model.controller.dart';
import 'package:ashlife/controller/upload.controller.dart';
import 'package:ashlife/controller/auth.controller.dart';
import 'package:ashlife/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class ImageScreen extends StatefulWidget {
  const ImageScreen({Key? key}) : super(key: key);

  @override
  State<ImageScreen> createState() => _ImageScreenState();
}

class _ImageScreenState extends State<ImageScreen> {
  UploadController controller = Get.put(UploadController());
  late ModelController _modelController;

  @override
  void initState() {
    controller.getInitialData();
    _modelController = Get.put(ModelController());
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    _modelController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Obx(() {
          return const SizedBox(
            height: 30,
          );
        }),
        Padding(
          padding: const EdgeInsets.only(left: 16, right: 16, top: 10),
          child: Text(
            'txt_my_pictures'.tr,
            style: const TextStyle(fontSize: 30, fontWeight: FontWeight.w500),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Expanded(
          child: Obx(() {
            List images = controller.images;
            bool loading = controller.loading.value;
            return loading
                ? const Center(
                    child: CircularProgressIndicator(
                      color: Color(0xff253890),
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.only(left: 16, right: 16),
                    child: GridView.builder(
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
                              child: Stack(
                                children: [
                                  Container(
                                    width: double.infinity,
                                    height: double.infinity,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      image: DecorationImage(
                                          image:
                                              FileImage(images[index]["file"]),
                                          fit: BoxFit.cover,
                                          colorFilter: images[index]
                                                  ["isSelected"]
                                              ? const ColorFilter.mode(
                                                  Color(0xff253890),
                                                  BlendMode.color)
                                              : const ColorFilter.mode(
                                                  Colors.white,
                                                  BlendMode.darken)),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }),
                  );
          }),
        ),
        const SizedBox(
          height: 15,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 30, right: 30, bottom: 15),
          child: Obx(() {
              return CustomButton(
                  text: "txt_create_m".tr, //'txt_create_m'.tr,
                  textColor: Colors.white,
                  color: const Color(0xff253890),
                  pressed: _modelController.createModel,
                  isLoading: false);
          }),
        ),
      ],
    );
  }
}