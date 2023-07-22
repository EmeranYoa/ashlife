import 'dart:io';

import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CacheService extends GetxService {
  Future<void> cacheImageUrls(List<String> imageUrls) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('imageUrls', imageUrls);
  }

  Future<void> cacheImageFilterUrls(List<String> imageUrls) async {
    print('================================');
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('imageFilterUrls', imageUrls);
  }

  Future<List<String>> getCachedImageUrls() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print('-' * 100);
    print(prefs.getStringList('imageUrls'));
    return prefs.getStringList('imageUrls') ?? [];
  }

  Future<List<String>> getCachedImageFilterUrls() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getStringList('imageFilterUrls') ?? [];
  }

  Future<void> deleteCachedImageUrls() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('imageUrls');
  }

  Future<void> deleteCachedImageFilterUrls() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('imageFilterUrls');
  }

  void preloadImage(String imageUrl) async {
    await DefaultCacheManager().downloadFile(imageUrl);
  }

  Future<void> deleteFileCache(List imageUrl) async {
    for (Map image in imageUrl) {
      print('*' * 100);
      print(image);
      await DefaultCacheManager().removeFile(image['url']);
    }
  }

  Future<File?> getImageFile(String imageUrl) async {
    File cachedImage = await DefaultCacheManager().getSingleFile(imageUrl);
    if (cachedImage != null && await cachedImage.exists()) {
      return cachedImage;
    }
    return null;
  }
}
