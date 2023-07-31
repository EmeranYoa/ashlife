import 'dart:io';

import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:ashlife/models/Filter.dart';
import 'package:ashlife/models/Generation.dart';
import 'package:ashlife/models/Image.dart';
import 'package:ashlife/services/aws.s3.service.dart';
import 'package:ashlife/services/cache.service.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  RxList<dynamic> images = [].obs;
  RxString filterId = "".obs;
  RxBool isLoading = false.obs;

  final AwsS3 _awsS3 = Get.put(AwsS3());
  final CacheService cache = Get.put(CacheService());

  @override
  void onInit() {
    ever(filterId, (value) => _getGeneratedImage());
    super.onInit();
  }

  Future<void> _getGeneratedImage() async {
    try {
      isLoading.value = true;
      var request = ModelQueries.list(Generation.classType);
      final result = await Amplify.API.query(request: request).response;
      final generations = result.data?.items;
      //where: Generation.FILTER.eq(filterId.value));

      List<dynamic> filterGenerations = [];

      for (var element in generations!) {
        final img = element?.images;

        if (img != null) {
          for (var el in img) {
            cache.preloadImage(el.path);
            File? file = await cache.getImageFile(el.path);
            if (file != null) {
              // filterGenerations.add({'file': file, 'height': el.height, 'width':el.width});
              filterGenerations.add({'file': file});
            }
          }
        }
      }
      images.value = filterGenerations;
      isLoading.value = false;
    } on Exception catch (e) {
      isLoading.value = false;
      Get.snackbar('Error', "Impossible de charger les images");
    }
  }

  void changeFilter({required String id}) {
    filterId.value = id;
  }
}
