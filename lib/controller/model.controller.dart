import 'dart:io';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:ashlife/models/ModelProvider.dart';
import 'package:ashlife/services/auth.service.dart';
import 'package:ashlife/services/aws.s3.service.dart';
import 'package:ashlife/services/cache.service.dart';
import 'package:ashlife/services/http.service.dart';
import 'package:get/get.dart';
import 'package:workmanager/workmanager.dart';

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
      final response = await _httpService.post(_httpService.baseModelUrl);
      List<Map<String, dynamic>> fResponse = [];

      for (Map<String, dynamic> model in response) {
        File? file = await _cache.getImageFile(model['screenshots']!);
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

  Future<void> createModel(List images, String prompt, String gender) async {
    try {
      loading.value = true;
      List<String> imageUrls = [];

      for (Map<String, dynamic> image in images) {
        String? url = await _awsS3.getFileUrl(key: image['key']);
        if (url != null) {
          imageUrls.add(url);
        }
      }

      final response =
          await _httpService.post(_httpService.dreamboothTraining, {
        "instance_prompt": prompt,
        "class_prompt": gender,
        "images": imageUrls,
        "seed": "0",
        "training_type": gender,
        "max_train_steps": "2000"
      });

      // Map response = {
      //   "status": "success",
      //   "messege": "deploying_gpu",
      //   "data": "it will take upto 45 minutes.",
      //   "training_id": "jN3lL5g74Vb2M0cACe19fzJZd",
      //   "model_id": "jN3lL5g74Vb2M0cACe19fzJZd"
      // };

      if (response['status'] == "success") {
        final user = await _authService.getCurrentUser();

        if (user != null) {
          UserModel model = UserModel(
              modelId: response['model_id'],
              name: prompt,
              prompt: prompt,
              status: 'processing');
          User u = (await Amplify.DataStore.query(User.classType,
                  where: User.PHONE.eq(user.username)))
              .first;

          List<UserModel> uModels = [model];
          List<UserModel>? uM = u.models;

          if (uM != null) {
            uModels.addAll(uM);
          }
          final newUser = u.copyWith(models: uModels);

          await Amplify.DataStore.save(newUser);
        }

        Workmanager().registerPeriodicTask(
          'checkTraining',
          "checkTraining",
          frequency: const Duration(minutes: 5),
          initialDelay: const Duration(minutes: 5),
          inputData: {'id': response['training_id'], "userId": user!.username},
          // inputData: {'id': response['training_id'], "userId": '+237691489490'},
          constraints: Constraints(networkType: NetworkType.connected),
        );
      }

      nextStep.value = true;
    } on Exception catch (e) {
      loading.value = false;
    }
  }
}
