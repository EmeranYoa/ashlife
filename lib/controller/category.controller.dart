import 'dart:convert';
import 'dart:io';

import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:ashlife/controller/home.controller.dart';
import 'package:ashlife/models/Image.dart';
import 'package:ashlife/services/auth.service.dart';
import 'package:ashlife/models/Filter.dart';
import 'package:ashlife/services/aws.s3.service.dart';
import 'package:ashlife/services/cache.service.dart';
import 'package:get/get.dart';

class CategoryController extends GetxController {
  RxList<dynamic> filters = [].obs;
  RxBool filterLoading = false.obs;

  final AwsS3 _awsS3 = Get.put(AwsS3());
  final CacheService cache = Get.put(CacheService());

  @override
  void onInit() {
    super.onInit();
  }

  Future<void> inittialData() async {
    await Amplify.DataStore.save(Filter(
        name: "cyborg",
        prompt:
            "photo of boss as instaport style, headshot portrait of  man 30 years old small beard transparant frame glasses  wavy hair action, expressive face, sharp eyes, by greg rutkowski and norman rockwell, beautiful, technical, futuristic military, trending on artstation, highly detailed, award winning ((ultra realistic eyes)) ((detailed face)), DSLR photography, sharp focus, Unreal Engine 5, Octane Render, Redshift, ((cinematic lighting)), f/1.4, ISO 200, 1/160s, 8K, RAW, unedited, symmetrical balance, in-frame, symmetrical face, symmetrical body, symmetric hands",
        negativePrompt: "",
        image: Image(path: 'filters/filter2.png')));
    await Amplify.DataStore.save(Filter(
        name: "anime",
        prompt:
            "photo of boss as instaport style, headshot portrait of  man 30 years old small beard transparant frame glasses  wavy hair action, expressive face, sharp eyes, by greg rutkowski and norman rockwell, beautiful, technical, futuristic military, trending on artstation, highly detailed, award winning ((ultra realistic eyes)) ((detailed face)), DSLR photography, sharp focus, Unreal Engine 5, Octane Render, Redshift, ((cinematic lighting)), f/1.4, ISO 200, 1/160s, 8K, RAW, unedited, symmetrical balance, in-frame, symmetrical face, symmetrical body, symmetric hands",
        negativePrompt: "",
        image: Image(path: 'filters/filter2.png')));
  }

  Future<void> getFilters() async {
    try {
      filterLoading.value = true;
      final f = await Amplify.DataStore.query(Filter.classType);
      List<Map<String, dynamic>> filterWithImage = [];

      List<String> cachedImageFilterUrls =
          await cache.getCachedImageFilterUrls();
      bool newUrlCached = false;

      for (Filter filter in f) {
        Map<dynamic, dynamic> keyUrl = cachedImageFilterUrls
            .map((url) => jsonDecode(url))
            .firstWhere((map) => map.containsValue(filter.image.path),
                orElse: () => {});

        if (keyUrl.isNotEmpty) {
          File? file = await cache.getImageFile(keyUrl['url']);
          if (file != null) {
            filterWithImage.add({
              'id': filter.id,
              "name": filter.name,
              'model': filter.model,
              'prompt': filter.prompt,
              'negativePrompt': filter.negativePrompt,
              "file": file
            });
          }
        } else {
          String? imgUrl = await _awsS3.getFileUrl(key: filter.image.path);

          if (imgUrl != null) {
            newUrlCached = true;
            cache.preloadImage(imgUrl);

            File? file = await cache.getImageFile(imgUrl);
            if (file != null) {
              Map<String, dynamic> img = {
                "key": filter.image.path,
                "url": imgUrl
              };
              filterWithImage.add({
                'id': filter.id,
                "name": filter.name,
                'model': filter.model,
                'prompt': filter.prompt,
                'negativePrompt': filter.negativePrompt,
                "file": file
              });

              cachedImageFilterUrls.add(jsonEncode(img));
            }
          }
        }
      }

      if (newUrlCached) {
        await cache.deleteCachedImageFilterUrls();
        await cache.cacheImageFilterUrls(cachedImageFilterUrls);
      }

      if (filterWithImage.isNotEmpty) {
        filters.value = filterWithImage;
        Get.find<HomeController>().changeFilter(id: filterWithImage[0]['id']);
      }
      filterLoading.value = false;
    } on DataStoreException catch (e) {
      filterLoading.value = false;
      print('Query failed: $e');
    }
  }
}
