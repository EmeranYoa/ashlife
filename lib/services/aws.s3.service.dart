import 'dart:io';

import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:get/get.dart';
import 'package:amplify_flutter/amplify_flutter.dart';

class AwsS3 extends GetxService {
  Future<String?> uploadFile(
      {required File local, required key, Function? onProgress}) async {
    try {
      if (onProgress != null) {
        final UploadFileResult result = await Amplify.Storage.uploadFile(
            local: local, key: key, onProgress: onProgress());
        return result.key;
      }
      final UploadFileResult result =
          await Amplify.Storage.uploadFile(local: local, key: key);
      return result.key;
    } on StorageException catch (e) {
      safePrint('Error uploading file: $e');
      return null;
    }
  }

  String getExtension({required File file}) {
    return file.path.split("/").last.split('.').last;
  }

  Future<String?> getFileUrl({required key}) async {
    try {
      final GetUrlResult result = await Amplify.Storage.getUrl(key: key);
      return result.url;
    } on StorageException catch (e) {
      safePrint('Error uploading file: $e');
      return null;
    }
  }

  Future<List<StorageItem>?> listFileUrl() async {
    try {
      final ListResult result = await Amplify.Storage.list();
      StorageItem st;
      return result.items;
    } on StorageException catch (e) {
      safePrint('Error uploading file: $e');
      return null;
    }
  }

  Future<bool> removeFile(List<String> keys) async {
    try {
      for (String key in keys) {
        final result = await Amplify.Storage.remove(
          key: key,
        );
      }
      return true;
    } on StorageException catch (e) {
      safePrint(e.message);
      return false;
    }
  }
}
