import 'dart:io';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:ashlife/models/ModelProvider.dart';
import 'package:ashlife/services/auth.service.dart';
import 'package:ashlife/services/aws.s3.service.dart';
import 'package:ashlife/services/cache.service.dart';
import 'package:ashlife/services/http.service.dart';
import 'package:get/get.dart';
import 'package:workmanager/workmanager.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class ModelController extends GetxController {
  RxList<dynamic> baseModels = [].obs;
  RxList<dynamic> myModels = [].obs;
  RxBool loading = false.obs;
  RxBool myModelLoading = false.obs;
  RxBool nextStep = false.obs;

  final HttpService _httpService = HttpService();
  final CacheService _cache = CacheService();
  final AwsS3 _awsS3 = Get.put(AwsS3());
  final AuthService _authService = Get.put(AuthService());

  @override
  void onInit() {
    super.onInit();
  }

  Future<void> getBaseModel() async {
    try {
      loading.value = true;
      final response = await _httpService.post(_httpService.baseUrl);
      List<Map<String, dynamic>> fResponse = [];
      for (Map<String, dynamic> model in response) {
        if (model['screenshots'].length <= 10) {
          continue;
        }
        File? file = await _cache.getImageFile(model['screenshots']!);
        // print('=' * 100);
        // print(model['screenshots']);
        fResponse.add({
          "model_id": model['model_id'],
          'status': model['status'],
          'model_name': model['model_name'],
          'file': file
        });
      }

      baseModels.value = fResponse;
      loading.value = false;
    } on Exception catch (e) {
      loading.value = false;
      print('Error to get base model to stable diffusion');
    }
  }

  Future<void> getUserModel() async {
    try {
      myModelLoading.value = true;
      final user = await _authService.getCurrentUser();
      if (user != null) {
        final u = (await Amplify.DataStore.query(User.classType,
                where: User.PHONE.eq(user.username)))
            .first;

        List<Map<String, dynamic>> fResponse = [];
        final uM = u.models!;
        for (UserModel model in uM) {
          if (model.status == "processing") {
            continue;
          }
          File? file = await _cache.getImageFile(model.image!.path);
          fResponse.add({
            "model_id": model.modelId,
            'status': model.status,
            'model_name': model.name,
            'file': file
          });
        }
        myModels.value = fResponse;
      }
      myModelLoading.value = false;
    } on Exception catch (e) {
      myModelLoading.value = false;
      print('Error to get base model to stable diffusion');
    }
  }

  Future<void> createModel() async {
    try {
      final user = await _authService.getCurrentUser();
      if (user != null) {
        final u = (await Amplify.DataStore.query(User.classType,
                where: User.PHONE.eq(user.username)))
            .first;

        print(u);
        // "${user.name}_${user.id}",
        //   "${user.name}_${user.id} person", user.datasetId!
        loading.value = true;
        // final response = await _httpService.post('models', {
        //   "name": "${u.name}_${u.id}",
        //   "instance_prompt": "${u.name} person",
        //   "datasetId": u.datasetId,
        // });

        Map response = {
          "sdTrainingJob": {
            "customModelId": "48c07a22-fa65-4143-a7af-f2ea85a0ecaa"
          }
        };

        print("=*" * 10);
        print(response);

        if (response.isNotEmpty) {
          final newUserData = u.copyWith(modelObject: jsonEncode(response));

          await Amplify.DataStore.save(newUserData);

          final String modelId = response['sdTrainingJob']['customModelId'];
          const String prompt =
              "Portrait of a very beautiful young woman in front of flower of life mandala wearing a huge elaborate detailed ornate crown made of all types of colorful flowers, turban of flowers, Visionary art, Cinematic lighting, Portrait, headshot, in style (ARTIST NAME) and baroque styles, symmetrical, hyper realistic,8k image, 3D, supersharp, pearls and oyesters, turban of vibrant flowers, satin ribbons, pearls and chains, perfect symmetry, iridescent, High Definition, Octane render in Maya and Houdini, light,shadows, reflections, photorealistic, masterpiece, smooth gradients, no blur, sharp focus,photorealistic, insanely detailed and intricate, cinematic lighting, real photography, epic scene, 8K";

          await generateImages(modelId: modelId, prompt: prompt);
          // final user = await _authService.getCurrentUser();

          // if (user != null) {
          //   UserModel model = UserModel(
          //       modelId: response['model_id'],
          //       name: prompt,
          //       prompt: prompt,
          //       status: 'processing');
          //   User u = (await Amplify.DataStore.query(User.classType,
          //           where: User.PHONE.eq(user.username)))
          //       .first;

          //   List<UserModel> uModels = [model];
          //   List<UserModel>? uM = u.models;

          //   if (uM != null) {
          //     uModels.addAll(uM);
          //   }
          //   final newUser = u.copyWith(models: uModels);

          //   await Amplify.DataStore.save(newUser);
          // }

          // Workmanager().registerPeriodicTask(
          //   'checkTraining',
          //   "checkTraining",
          //   frequency: const Duration(minutes: 5),
          //   initialDelay: const Duration(minutes: 5),
          //   inputData: {
          //     'id': response['training_id'],
          //     "userId": user!.username
          //   },
          //   // inputData: {'id': response['training_id'], "userId": '+237691489490'},
          //   constraints: Constraints(networkType: NetworkType.connected),
          // );
        }
      }
      nextStep.value = true;
    } on Exception catch (e) {
      loading.value = false;
    }
  }

  Future<void> generateImages(
      {required String modelId,
      required String prompt,
      String negativePrompt = "",
      int numImages = 4}) async {
    final response = await _httpService.post('generations', {
      "prompt": prompt,
      "modelId": modelId,
      "num_images": numImages,
      "negative_prompt": negativePrompt
    });

    //utilisateur courant
    final user = await _authService.getCurrentUser();
    if (user != null) {
      final u = (await Amplify.DataStore.query(User.classType,
              where: User.PHONE.eq(user.username)))
          .first;

      print("==================Response to image generation==================");          
      print(response);

      final String generationlId = response['sdGenerationJob']['generationId'];
      final imageGenerated =
          await _httpService.get('generations', generationlId);
      print("==============Response to image generation=====================");
      print(imageGenerated);

      Workmanager().registerPeriodicTask(
        'checkModelGenerated',
        "checkModelGenerated",
        frequency: const Duration(minutes: 1),
        initialDelay: const Duration(seconds: 10),
        inputData: {'id': response['modelId'], "userId": u.id},
        constraints: Constraints(networkType: NetworkType.connected),
      );
        Workmanager().registerPeriodicTask(
        'checkImagesGenerated',
        "checkImagesGenerated",
        frequency: const Duration(minutes: 1),
        initialDelay: const Duration(minutes: 1),
        inputData: {'id': response['generationlId'], "userId": u.name},
        // inputData: {'id': response['training_id'], "userId": '+237691489490'},
        constraints: Constraints(networkType: NetworkType.connected),
      );
    }
  }
}
