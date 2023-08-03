import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:ashlife/Screen/generation_result.dart';
import 'package:ashlife/controller/auth.controller.dart';
import 'package:ashlife/controller/home.controller.dart';
import 'package:ashlife/controller/navigation.controller.dart';
import 'package:ashlife/models/Filter.dart';
import 'package:ashlife/models/Generation.dart';
import 'package:ashlife/models/Image.dart' as Img;
import 'package:ashlife/models/User.dart';
import 'package:ashlife/models/UserModel.dart';
import 'package:ashlife/navigation/bottom_navigation.dart';
import 'package:ashlife/services/aws.s3.service.dart';
import 'package:ashlife/services/http.service.dart';
import 'package:ashlife/services/subscription.service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:workmanager/workmanager.dart';

class GeneratorController extends GetxController {
  RxBool isGenerating = false.obs;
  RxBool isError = false.obs;
  RxBool isProcessing = false.obs;
  RxList<dynamic> images = [].obs;
  RxString generationId = "".obs;

  final HttpService _httpService = HttpService();
  final AwsS3 _awsS3 = Get.put(AwsS3());
  final SubscriptionService _subscriptionService = SubscriptionService();
  AuthController authController = Get.put(AuthController());

  @override
  void onInit() {
    super.onInit();
  }

  Future<void> startGeneration(Map<String, dynamic> filter, String modelId,
      String imageKey, String modelType) async {
    try {
      isGenerating.value = true;
      String? imgUrl = await _awsS3.getFileUrl(key: imageKey);
      if (imgUrl != null) {
        final modelStatusResponse = await _httpService
            .post("${_httpService.dreamboothGetModelStatus}$modelId");

        if (modelStatusResponse['model_training_status'] == "model_ready" ||
            modelStatusResponse['messege'] == "training id not found") {
          User u = authController.user.value;

          String promp = '';

          if (modelStatusResponse['model_training_status'] == "model_ready") {
            UserModel model =
                u.models!.where((element) => element.modelId == modelId).first;

            promp = "${model.name} ${filter['prompt']}";
          } else {
            promp = "${filter['prompt']}";
          }

          Map<String, dynamic> data = {
            "model_id": modelId,
            "prompt": promp,
            "negative_prompt": filter['negativePrompt'],
            "init_image": imgUrl,
            "width": "512",
            "height": "512",
            "samples": 4,
            "num_inference_steps": 30,
            "guidance_scale": 7.5,
            "strength": 0.7,
          };

          final response = await _httpService.post(
              _httpService.dreamboothImageToImage, data);
          print('*' * 100);
          print(response);
          if (response['status'] == "processing") {
            Workmanager().registerPeriodicTask(
              'checkGenerationResult',
              "checkGenerationResult",
              frequency: const Duration(minutes: 5),
              initialDelay: const Duration(minutes: 5),
              inputData: {
                'generationId': response['id'],
              },
              constraints: Constraints(networkType: NetworkType.connected),
            );

            isProcessing.value = true;
            isGenerating.value = false;
            Get.back();

            Get.dialog(
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: Container(
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(
                          Radius.circular(20),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Material(
                          color: Colors.white,
                          child: Column(
                            children: [
                              const SizedBox(height: 10),
                              const Text(
                                "Image generating",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(height: 15),
                              const Text(
                                "Your generations are in progress. You will receive the results in a moment !!",
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 20),
                              Row(
                                children: [
                                  Expanded(
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        minimumSize: const Size(0, 45),
                                        primary: const Color(0xff253890),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                      ),
                                      onPressed: () {
                                        Get.to(
                                          const BottomNavigation(),
                                        );
                                      },
                                      child: const Text(
                                        'Okay',
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                  // const SizedBox(width: 10),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              barrierDismissible: false,
            );
            return;
          }

          if (response['status'] == "failed") {
            isGenerating.value = false;
            isError.value = true;
            Get.back();
            Get.dialog(
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: Container(
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(
                          Radius.circular(20),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Material(
                          color: Colors.white,
                          child: Column(
                            children: [
                              const SizedBox(height: 10),
                              const Text(
                                "Image generating",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(height: 15),
                              const Text(
                                "An error has occurred. try again later",
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 20),
                              Row(
                                children: [
                                  Expanded(
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        minimumSize: const Size(0, 45),
                                        primary: const Color(0xff253890),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                      ),
                                      onPressed: () {
                                        Get.to(
                                          const BottomNavigation(),
                                        );
                                      },
                                      child: const Text(
                                        'Okay',
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                  // const SizedBox(width: 10),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              barrierDismissible: false,
            );
            return;
          }

          await createGeneration(
              filter: filter, generationResult: response, user: u);
          isGenerating.value = false;
          Get.back();
          Get.to(GenerationResult(images: response['output']),
              duration: const Duration(milliseconds: 800),
              transition: Transition.rightToLeft);

          return;
        }

        final reloadModelResponse = await _httpService
            .post(_httpService.dreamboothModelReload, {"model_id": modelId});

        if (reloadModelResponse['messege'] == "Model is reloading") {
          Workmanager().registerPeriodicTask(
            'checkModelRelaod',
            "checkModelRelaod",
            frequency: const Duration(minutes: 5),
            initialDelay: const Duration(minutes: 5),
            inputData: {
              'modelId': modelId,
            },
            constraints: Constraints(networkType: NetworkType.connected),
          );
        }
      }
    } on Exception catch (e) {
      isGenerating.value = false;
      Get.back();
      Get.snackbar('Error', 'Une erreur est survenue ressayer plus tard');
    }
  }

  void saveGenerateImage(url) {
    List<dynamic> copyImages = List.from(images.value);
    if (copyImages.any((map) => map.path == url)) {
      copyImages.forEach((el) {
        if (el.path == url) {
          int index = copyImages.indexOf(el);
          copyImages.removeAt(index);
        }
      });
      return;
    }
    copyImages.add(Img.Image(path: url));
    images.value = copyImages;
  }

  Future<void> updateGenerationData() async {
    try {
      isGenerating.value = true;
      var request = ModelQueries.get(Generation.classType, generationId.value);
      final result = await Amplify.API.query(request: request).response;
      final oldGeneration = result.data!;
      List<Img.Image> generatedImageList = [];
      for (var image in images) {
        generatedImageList.add(Img.Image(path: image.path));
      }

      final newGeneration = oldGeneration.copyWith(images: generatedImageList);
      request = ModelMutations.update(newGeneration);

      await Amplify.API.mutate(request: request);
      _subscriptionService.updateSubscription(ACTION_TYPE.GENERATION);
      Get.find<NavigationController>().changePage(0);
      Get.find<HomeController>().changeFilter(id: newGeneration.filter.id);
      isGenerating.value = false;
      generationId.value = "";
      Get.to(const BottomNavigation(),
          duration: const Duration(milliseconds: 800),
          transition: Transition.leftToRight);
    } on AmplifyException catch (e) {
      generationId.value = "";
      Get.snackbar('Error',
          "Désoler nous n'avons pas reuissi a sauvegarder vos images, verifier votre connexion internet et réessayer");
      isGenerating.value = false;
    }
  }

  Future<void> createGeneration(
      {required Map<String, dynamic> filter,
      required Map<String, dynamic> generationResult,
      required User user}) async {
    var request = ModelQueries.get(Filter.classType, filter['id']);

    final result = await Amplify.API.query(request: request).response;
    Filter filt = result.data!;
    final generation = Generation(
        user: user,
        filter: filt,
        process: generationResult['status'],
        data: generationResult.toString(),
        providerId: generationResult['id'].toString());

    request = ModelMutations.update(filt);

    await Amplify.API.mutate(request: request);
    generationId.value = generationResult['id'].toString();
  }
}
