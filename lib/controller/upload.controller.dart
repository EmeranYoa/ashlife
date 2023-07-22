import 'dart:convert';
import 'dart:io';

import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:ashlife/Screen/model_screen.dart';
import 'package:ashlife/Screen/subscription_screen.dart';
import 'package:ashlife/models/Image.dart';
import 'package:ashlife/models/User.dart';
import 'package:ashlife/services/auth.service.dart';
import 'package:ashlife/services/aws.s3.service.dart';
import 'package:ashlife/services/cache.service.dart';
import 'package:ashlife/services/subscription.service.dart';
import 'package:ashlife/widgets/Recommended.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

class UploadController extends GetxController {
  RxList<dynamic> uploadImages = [].obs;
  RxList<dynamic> images = [].obs;
  RxList<dynamic> selectedImages = [].obs;
  RxList<dynamic> imageKeys = [].obs;

  RxBool isUploading = false.obs;
  RxBool loading = false.obs;

  final ImagePicker _picker = ImagePicker();
  final AwsS3 _awsS3 = Get.put(AwsS3());
  final CacheService cache = Get.put(CacheService());
  final SubscriptionService _subscriptionService = SubscriptionService();
  final AuthService authService = Get.put(AuthService());

  @override
  void onInit() {
    _showRecommendedImageBottomSheet();
    everAll([uploadImages, imageKeys], (value) {
      if (value is List<File>) {
        _upload(value);
      } else {
        _updateUserDataAddFile(value);
      }
    });
    super.onInit();
  }

  Future<void> getInitialData() async {
    print('=======================INIT DATA=======================');
    List<Map<String, dynamic>> imagesList = [];
    try {
      loading.value = true;
      final phoneNumber = (await authService.getCurrentUser())?.username;
      final user = (await Amplify.DataStore.query(
        User.classType,
        where: User.PHONE.eq(phoneNumber),
      ))
          .first;

      List<String> cachedImageUrls = await cache.getCachedImageUrls();

      bool newUrlCached = false;

      if (user.images != null) {
        for (Image image in user.images!) {
          Map<dynamic, dynamic> keyUrl = cachedImageUrls
              .map((url) => jsonDecode(url))
              .firstWhere((map) => map.containsValue(image.path), //Retourne le 1er élément contient imgpath
                  orElse: () => {});

          if (keyUrl.isNotEmpty) {
            File? file = await cache.getImageFile(keyUrl['url']);
            if (file != null) {
              imagesList.add(
                  {"key": keyUrl['key'], "file": file, 'isSelected': false});
            }
          } else {
            String? imgUrl = await _awsS3.getFileUrl(key: image.path);
            if (imgUrl != null) {
              newUrlCached = true;
              cache.preloadImage(imgUrl);

              File? file = await cache.getImageFile(imgUrl);
              if (file != null) {
                Map<String, dynamic> img = {"key": image.path, "url": imgUrl};
                imagesList.add(
                    {"key": image.path, "file": file, 'isSelected': false});
                cachedImageUrls.add(jsonEncode(img));
              }
            }
          }
        }
      }

      if (newUrlCached) {
        await cache.deleteCachedImageUrls();
        await cache.cacheImageUrls(cachedImageUrls);
      }

      images.value = imagesList;
      loading.value = false;
    } on Exception catch (e) {
      loading.value = false;
      Get.snackbar("Error", e.toString());
    }
  }

  Future<void> getImages(ImageSource source) async {
    List<File> pickerImages = [];
    if (source == ImageSource.gallery) {
      List<XFile> picks = await _picker.pickMultiImage(imageQuality: 100);
      for (XFile f in picks) {
        File? croppedFile = await _imageCropper(image: f);
        pickerImages.add(croppedFile!);
      }
    } else {
      XFile? pick = await _picker.pickImage(
        source: source,
      );
      if (pick != null) {
        File? croppedFile = await _imageCropper(image: pick);
        if (croppedFile != null) {
          pickerImages.add(File(croppedFile.path));
        }
      }
    }
    uploadImages.value = pickerImages;
  }

  Future<File?> _imageCropper({required XFile image}) async {
    CroppedFile? croppedFile = await ImageCropper()
        .cropImage(sourcePath: image.path, maxHeight: 512, maxWidth: 512);
    if (croppedFile != null) return File(croppedFile.path);
    return null;
  }

  Future<void> _upload(List<File> files) async {
    try {
      isUploading.value = true;
      const uuid = Uuid();
      List<String> keyList = [];

      for (File file in files) {
        final ext = _awsS3.getExtension(file: file);
        final key = "${uuid.v4()}.$ext";
        final uploadKey = await _awsS3.uploadFile(local: file, key: key);
        keyList.add(uploadKey!);
      }
      imageKeys.value = keyList;
    } on Exception catch (e) {
      isUploading.value = false;
      Get.snackbar('Error', e.toString());
    }
  }

  Future<void> _updateUserData(List<String> keys) async {
    try {
      final phoneNumber = (await authService.getCurrentUser())?.username;
      final user = (await Amplify.DataStore.query(
        User.classType,
        where: User.PHONE.eq(phoneNumber),
      ))
          .first;
      List<Image> userImages = [];

      for (String key in keys) {
        userImages.add(Image(path: key, height: 512, width: 512));
      }
      final newUserData = user.copyWith(images: userImages);

      await Amplify.DataStore.save(newUserData);
      getInitialData();
      isUploading.value = false;
    } on Exception catch (e) {
      isUploading.value = false;
      safePrint(e.toString());
    }
  }
  
  Future<void> _updateUserDataAddFile(List<String> keys) async {
    try {
      final phoneNumber = (await authService.getCurrentUser())?.username;
      final user = (await Amplify.DataStore.query(
        User.classType,
        where: User.PHONE.eq(phoneNumber),
      ))
          .first;
      List<Image> userImages = user.images ?? [];

      for (String key in keys) {
        userImages.add(Image(path: key, height: 512, width: 512));
      }
      final newUserData = user.copyWith(images: userImages);

      await Amplify.DataStore.save(newUserData);
      getInitialData();
      isUploading.value = false;
    } on Exception catch (e) {
      isUploading.value = false;
      safePrint(e.toString());
    }
  }

  void selectedAndUnselectedImage(Map<String, dynamic> image) {
    var index = images.indexWhere((element) => element['key'] == image['key']);
    if (index != -1) {
      var selected = images[index]['isSelected'];
      images[index]['isSelected'] = !selected;
      if (selected) {
        selectedImages.remove(image);
      } else {
        selectedImages.add(image);
      }
    }
  }

  void selectAndUnselectAll() {
    if (images.length == selectedImages.length) {
      List<Map<String, dynamic>> imagesList = [];
      for (var image in images) {
        imagesList.add(
            {'key': image['key'], 'file': image['file'], 'isSelected': false});
      }
      images.value = imagesList;
      selectedImages.value = [];
    } else {
      List<Map<String, dynamic>> imagesList = [];
      for (var image in images) {
        imagesList.add(
            {'key': image['key'], 'file': image['file'], 'isSelected': true});
      }
      images.value = imagesList;
      selectedImages.value = imagesList;
    }
  }

  Future<void> deleteAllSelectedItems() async {
    for (Map image in selectedImages) {
      images.contains(image) ? images.remove(image) : images = images;
    }
    List<dynamic> imageKeys = selectedImages;

    await _awsS3.removeFile(imageKeys);
    await cache.deleteCachedImageUrls();
    List<String> keys = images.map((item) => item['key'] as String).toList();
    await _updateUserData(keys);
    // await cache.deleteFileCache(imageKeys);
    await getInitialData();
  }

  void deleteImages() {
    if (images.length == selectedImages.length) {
      List<Map<String, dynamic>> imagesList = [];
      for (var image in images) {
        imagesList.add(
            {'key': image['key'], 'file': image['file'], 'isSelected': false});
      }
      images.value = imagesList;
      selectedImages.value = [];
    } else {
      List<Map<String, dynamic>> imagesList = [];
      for (var image in images) {
        imagesList.add(
            {'key': image['key'], 'file': image['file'], 'isSelected': true});
      }
      images.value = imagesList;
      selectedImages.value = imagesList;
    }
  }

  Future<void> _showRecommendedImageBottomSheet() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    bool isFirst = prefs.getBool('isFirstRun') ?? true;
    if (!isFirst) {
      Get.bottomSheet(const Recommended());
    }
  }

  Future<void> nextStape(String key) async {
    final bool userCanGenerate = await _subscriptionService.userCanGenerate();
    if (userCanGenerate) {
      Get.to(
        ModelScreen(
          imageKey: key,
        ),
        duration: const Duration(milliseconds: 800),
        transition: Transition.fade,
      );
      return;
    }
    Get.to(
      const SubscriptionScreen(),
      duration: const Duration(milliseconds: 800),
      transition: Transition.fade,
    );
  }

  Future<bool> canGenerateModelCheck() async {
    return await _subscriptionService.userCanGenerateModel();
  }
}
