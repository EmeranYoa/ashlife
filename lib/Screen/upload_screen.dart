import 'package:ashlife/Screen/Auth/register.dart';
import 'package:ashlife/Screen/model_screen.dart';
import 'package:ashlife/Screen/subscription_screen.dart';
import 'package:ashlife/controller/model.controller.dart';
import 'package:ashlife/controller/upload.controller.dart';
import 'package:ashlife/controller/auth.controller.dart';
import 'package:ashlife/models/User.dart';
import 'package:ashlife/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:heroicons/heroicons.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lite_rolling_switch/lite_rolling_switch.dart';

class UploadScreen extends StatefulWidget {
  const UploadScreen({Key? key}) : super(key: key);

  @override
  State<UploadScreen> createState() => _UploadScreenState();
}

class _UploadScreenState extends State<UploadScreen> {
  UploadController controller = Get.put(UploadController());
  late ModelController _modelController;

  final prompt = "woman with cornrows";
  final modelId = "48c07a22-fa65-4143-a7af-f2ea85a0ecaa";

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
    final size = MediaQuery.of(context).size;

    void onImagePress(Map<String, dynamic> image) {
      if (controller.selectedImages.value.isNotEmpty) {
        controller.selectedAndUnselectedImage(image);
      } else {
        controller.nextStape(image['key']);
      }
    }

    void onLongPressImage(Map<String, dynamic> image) {
      controller.selectedAndUnselectedImage(image);
    }

    Future<void> onCreateModelPress() async {
      bool canGenerate = await controller.canGenerateModelCheck();
      if (canGenerate) {
        Get.bottomSheet(
            CreateModelBottomSheet(
              size: size,
            ),
            isDismissible: false);
        return;
      }
      Get.to(
        const SubscriptionScreen(),
        duration: const Duration(milliseconds: 800),
        transition: Transition.fade,
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Obx(() {
          if (controller.selectedImages.value.isNotEmpty) {
            return Container(
              width: double.infinity,
              color: const Color(0xff253890),
              child: Column(
                children: [
                  const SizedBox(
                    height: 30,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 16,
                      right: 16,
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "${controller.selectedImages.value.length.toString()} ${'txt_pictures'.tr}",
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w600),
                        ),
                        Row(
                          children: <Widget>[
                            IconButton(
                              icon: Obx(() {
                                if (controller.selectedImages.value.length ==
                                    controller.images.value.length) {
                                  return const Icon(
                                    Icons.check_circle,
                                    color: Colors.white,
                                  );
                                }
                                return const Icon(
                                  Icons.check_circle_outline,
                                  color: Colors.white,
                                );
                              }),
                              onPressed: () {
                                controller.selectAndUnselectAll();
                              },
                            ),
                            IconButton(
                              icon: const Icon(
                                Icons.delete,
                                color: Colors.white,
                              ),
                              onPressed: () {
                                controller.deleteAllSelectedItems();
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }
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
            var selectedImages = controller.selectedImages.value;
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
                              onTap: () => onImagePress(images[index]),
                              onLongPress: () =>
                                  onLongPressImage(images[index]),
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
                                  Obx(() {
                                    if (images[index]["isSelected"]) {
                                      return const Positioned(
                                        top: 10,
                                        left: 10,
                                        child: Icon(
                                          Icons.check_circle,
                                          color: Colors.white,
                                        ),
                                      );
                                    }
                                    return const Text('');
                                  }),
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
            if (controller.selectedImages.value.length >= 8) {
              return CustomButton(
                  text: "txt_create_m".tr, //'txt_create_m'.tr,
                  textColor: Colors.white,
                  color: const Color(0xff253890),
                  pressed: _modelController.createModel,
                  isLoading: false);
            }          
            return CustomButton(
                text: 'txt_create_m'.tr,
                textColor: Colors.white,
                color: const Color(0xff253890),
                pressed: _modelController.createModel,
/*                 pressed: () {

                  _modelController.createModel();
                  // if (controller.images.length >= 20) {
                  //   Get.snackbar('Error',
                  //       "You have reached the maximum number of maximum files to upload");
                  //   return;
                  // }
                  // Get.bottomSheet(
                  //     BottomSheet(size: size, controller: controller));
                }, */
                isLoading: false);
          }),
        ),
      ],
    );
  }
}

class BottomSheet extends StatelessWidget {
  const BottomSheet({
    super.key,
    required this.size,
    required this.controller,
  });

  final Size size;
  final UploadController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size.height * 0.25,
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16), topRight: Radius.circular(16))),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(
              height: 100,
              width: 100,
              child: Material(
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                color: const Color(0xff253890),
                child: InkWell(
                    onTap: () => controller.getImages(ImageSource.camera),
                    child: const HeroIcon(
                      HeroIcons.camera,
                      color: Colors.white,
                    )),
              ),
            ),
            SizedBox(
              height: 100,
              width: 100,
              child: Material(
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                color: const Color(0xff253890),
                child: InkWell(
                    onTap: () => controller.getImages(ImageSource.gallery),
                    child: const HeroIcon(
                      HeroIcons.photo,
                      color: Colors.white,
                    )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CreateModelBottomSheet extends StatefulWidget {
  const CreateModelBottomSheet({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  State<CreateModelBottomSheet> createState() => _CreateModelBottomSheetState();
}

class _CreateModelBottomSheetState extends State<CreateModelBottomSheet> {
  // late TextEditingController _genderController;
  // late TextEditingController _promptController;
  late ModelController _modelController;

  @override
  void initState() {
    // _genderController = TextEditingController();
    // _promptController = TextEditingController();
    _modelController = Get.put(ModelController());
    super.initState();
  }

  @override
  void dispose() {
    // _genderController.dispose();
    // _promptController.dispose();
    _modelController.dispose();
    super.dispose();
  }

  Future<void> startGeneration() async {
    // if (_modelController.loading.value) {
    //   return;
    // }
    // if (_genderController.text.isEmpty) {
    //   _genderController.text = 'men';
    // }

    // if (_genderController.text.isEmpty | _promptController.text.isEmpty) {
    //   Get.snackbar('Error', 'Please fill all data');
    //   return;
    // }

    _modelController.createModel();
  }

  // Get.find<UploadController>().selectedImages.value,
  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.size.height * 0.4,
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16), topRight: Radius.circular(16))),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Obx(() {
          bool loading = _modelController.loading.value;
          bool nextStep = _modelController.nextStep.value;

          if (loading) {
            return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const CircularProgressIndicator(
                    color: Color(0xff253890),
                    strokeWidth: 1,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  const Text(
                    'Nous sommes en train de générer votre modèle. Veuillez patienter quelques instants pendant que nous travaillons pour vous fournir la meilleure expérience possible. Pour garantir une génération réussie, veuillez vous assurer que votre appareil est connecté à Internet en permanence. Merci de votre confiance et de votre patience.',
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  if (nextStep)
                    CustomButton(
                      text: 'Understood',
                      textColor: Colors.white,
                      color: const Color(0xff253890),
                      isLoading: false,
                      pressed: () => Get.back(),
                    ),
                ]);
          }
          return Column(
            children: [
              const Text(
                'Veuillez completer les informations suivant pour demarrer la generation de votre model',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
              const SizedBox(
                height: 15,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Text(
                    'Prompt',
                    style: TextStyle(
                        color: Colors.black38,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    height: 50,
                    child: TextField(
                      // controller: _promptController,
                      style: const TextStyle(color: Colors.black87),
                      decoration: const InputDecoration(
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.only(top: 14),
                          prefixIcon: Icon(
                            Icons.tag,
                            color: Colors.black45,
                          ),
                          hintText: 'prompt',
                          hintStyle: TextStyle(color: Colors.black38)),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  // LiteRollingSwitch(
                  //   value: true,
                  //   textOn: 'txt_male'.tr,
                  //   textOff: 'txt_female'.tr,
                  //   colorOn: const Color(0xff253890),
                  //   textOffColor: Colors.white,
                  //   textOnColor: Colors.white,
                  //   colorOff: const Color(0xff050B29),
                  //   iconOn: Icons.male,
                  //   iconOff: Icons.female,
                  //   textSize: 16.0,
                  //   // onChanged: (bool state) {
                  //   //   if (state) {
                  //   //     _genderController.text = "men";
                  //   //   } else {
                  //   //     _genderController.text = "female";
                  //   //   }
                  //   // },
                  //   onDoubleTap: () {
                  //     //log here
                  //   },
                  //   onTap: () {
                  //     //log here
                  //   },
                  //   onSwipe: () {
                  //     //log here
                  //   },
                  // ),
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              CustomButton(
                text: 'Create now',
                textColor: Colors.white,
                color: const Color(0xff253890),
                isLoading: false,
                pressed: () => startGeneration(),
              ),
            ],
          );
        }),
      ),
    );
  }
}
