import 'dart:io';
import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:ashlife/Screen/generation_result.dart';
import 'package:ashlife/models/ModelProvider.dart';
import 'package:ashlife/services/auth.service.dart';
import 'package:ashlife/services/aws.s3.service.dart';
import 'package:ashlife/services/cache.service.dart';
import 'package:ashlife/services/http.service.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:workmanager/workmanager.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class ResponseImageItem {
  final String url;
  final bool nsfw;
  final String id;
  final int likeCount;
  var generated_image_variation_generics;

  ResponseImageItem(
      {required this.url,
      this.nsfw = false,
      required this.id,
      required this.likeCount,
      this.generated_image_variation_generics});
}

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
        final request = ModelQueries.list(User.classType,
            where: User.PHONE.eq(user.username));
        final result = await Amplify.API.query(request: request).response;
        final u = result.data?.items.first as User;

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
        var request = ModelQueries.list(User.classType,
            where: User.PHONE.eq(user.username));
        final result = await Amplify.API.query(request: request).response;
        final u = result.data?.items.first;

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
          final newUserData = u?.copyWith(modelObject: jsonEncode(response));

          var request = ModelMutations.update(newUserData!);

          await Amplify.API.mutate(request: request);

          final String modelId = response['sdTrainingJob']['customModelId'];
          const String prompt = "woman with cornrows";

          List<String> imageUrls =
              await generateImages(modelId: modelId, prompt: prompt);
          print("==========MOVING TO GENERATION RESULT PAGE===================");
          Get.to(
            () => GenerationResult(images: imageUrls),
            duration: const Duration(seconds: 15),
            transition: Transition.fade,
          );

          // final user = await _authService.getCurrentUser();

          // if (user != null) {
          //   UserModel model = UserModel(
          //       modelId: response['model_id'],
          //       name: prompt,
          //       prompt: prompt,
          //       status: 'processing');
          //   User u = (await Amplify.API.query(User.classType,
          //           where: User.PHONE.eq(user.username)))
          //       .first;

          //   List<UserModel> uModels = [model];
          //   List<UserModel>? uM = u.models;

          //   if (uM != null) {
          //     uModels.addAll(uM);
          //   }
          //   final newUser = u.copyWith(models: uModels);

          //   await Amplify.API.save(newUser);
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

  Future<List<String>> generateImages(
      {required String modelId,
      required String prompt,
      String negativePrompt = "",
      int numImages = 4}) async {
    print("start");

    final response = await _httpService.post('generations', {
      "prompt": prompt,
      "modelId": "48c07a22-fa65-4143-a7af-f2ea85a0ecaa",
      "num_images": numImages,
      "negative_prompt": negativePrompt
    });
    var items = <ResponseImageItem>[];
    List<String> imageUrls = [];
    print("end");
    print(response);

    //utilisateur courant
    final user = await _authService.getCurrentUser();
    if (user != null) {
      var request = ModelQueries.list(User.classType,
          where: User.PHONE.eq(user.username));
      final result = await Amplify.API.query(request: request).response;
      final u = result.data?.items.first as User;

      await Future.delayed(const Duration(seconds: 15), () async {
        final String generationId = response['sdGenerationJob']['generationId'];

        final imageGenerated =
            await _httpService.get('generations', generationId);

        print("============Response to image generation================");
        print(imageGenerated);

        final urls = imageGenerated['generations_by_pk']['generated_images'];
        for (var element in urls) {
          ResponseImageItem item = ResponseImageItem(
              url: element["url"],
              id: element["id"],
              likeCount: element["likeCount"]);
          items.add(item);
        }
        for (int i = 0; i < numImages; i++) {
          imageUrls.add(items[i].url);
          print(items[i].url);
        }
      });
    }
    return imageUrls;
  }
}
