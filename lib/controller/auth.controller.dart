import 'dart:convert';
import 'dart:io';

import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:ashlife/models/Image.dart';
import 'package:ashlife/models/User.dart';
import 'package:ashlife/services/auth.service.dart';
import 'package:ashlife/services/aws.s3.service.dart';
import 'package:ashlife/services/cache.service.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

class AuthController extends GetxController {
  RxList<dynamic> selectedImages = [].obs;
  RxBool isLoading = false.obs;
  Rx<User> user = User().obs;
  Rx<String> avatar = "".obs;
  final AuthService authService = Get.put(AuthService());

  final ImagePicker _picker = ImagePicker();

  final AwsS3 _awsS3 = Get.put(AwsS3());

  final CacheService cache = Get.put(CacheService());

  Future<bool> checkAuthenticateUser() async {
    return await authService.checkAuthenticateUser();
  }

  Future<void> signInUser(String username, String password) async {
    print(selectedImages);
    print('=' * 100);
    try {
      isLoading.value = true;
      await authService.signIn(username, password);
      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
    }
  }

  Future<void> getCurrentUser() async {
    try {
      print(selectedImages);
      print('=' * 100);
      isLoading.value = true;
      bool isAuth = await checkAuthenticateUser();

      if (isAuth) {
        isLoading.value = false;
        final us = await authService.getCurrentUser();
        final u = (await Amplify.DataStore.query(
          User.classType,
          where: User.PHONE.eq(us?.username),
        ))
            .first;

        user.value = u;
        await getUserAvatar();
      }
      isLoading.value = false;
      return null;
    } catch (e) {
      return null;
      isLoading.value = false;
    }
  }

  Future<void> signUpUser(String username, String password,
      Map<CognitoUserAttributeKey, String> attribute) async {
    try {
      isLoading.value = true;
      await authService.signUp(username, password, attribute);
      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
    }
  }

  Future<void> editUserInformation(String name, String email) async {
    try {
      isLoading.value = true;
      await authService.editUserInfo(name, email);
      final userWithId = await Amplify.DataStore.query(
        User.classType,
        where: User.ID.eq(user.value.id),
      );

      final oldUser = userWithId.first;
      final newUser = oldUser.copyWith(name: name, email: email);

      await Amplify.DataStore.save(newUser);
      await getCurrentUser();
      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
    }
  }

  Future<void> changeProfilePicture() async {
    try {
      isLoading.value = true;
      XFile? pick = await _picker.pickImage(
        source: ImageSource.gallery,
      );
      if (pick != null) {
        File? croppedFile = await _imageCropper(image: pick);
        if (croppedFile != null) {
          const uuid = Uuid();
          final ext = _awsS3.getExtension(file: croppedFile);
          final key = "${uuid.v4()}.$ext";
          final uploadKey =
              await _awsS3.uploadFile(local: croppedFile, key: key);

          final userWithId = await Amplify.DataStore.query(
            User.classType,
            where: User.ID.eq(user.value.id),
          );

          final oldUser = userWithId.first;
          final newUser = oldUser.copyWith(avatar: Image(path: uploadKey!));

          await Amplify.DataStore.save(newUser);
          await getCurrentUser();
        }
      }
      isLoading.value = false;
    } on Exception catch (e) {
      isLoading.value = false;
      Get.snackbar("Error", e.toString());
    }
  }

  Future<void> getUserAvatar() async {
    bool newUrlCached = false;
    List<String> cachedImageUrls = await cache.getCachedImageUrls();
    if (user.value.avatar != null) {
      Map<dynamic, dynamic> keyUrl = cachedImageUrls
          .map((url) => jsonDecode(url))
          .firstWhere((map) => map.containsValue(user.value.avatar!.path),
              orElse: () => {});

      if (keyUrl.isNotEmpty) {
        File? file = await cache.getImageFile(keyUrl['url']);
        if (file != null) {
          avatar.value = file.path;
        }
      } else {
        String? imgUrl = await _awsS3.getFileUrl(key: user.value.avatar!.path);

        if (imgUrl != null) {
          newUrlCached = true;
          cache.preloadImage(imgUrl);

          File? file = await cache.getImageFile(imgUrl);
          if (file != null) {
            Map<String, dynamic> img = {
              "key": user.value.avatar!.path,
              "url": imgUrl
            };
            cachedImageUrls.add(jsonEncode(img));
            avatar.value = file.path;
          }
        }
      }
    }
  }

  Future<File?> _imageCropper({required XFile image}) async {
    CroppedFile? croppedFile = await ImageCropper()
        .cropImage(sourcePath: image.path, maxHeight: 512, maxWidth: 512);
    if (croppedFile != null) return File(croppedFile.path);
    return null;
  }
}
