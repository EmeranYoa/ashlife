import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:heroicons/heroicons.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:share_plus/share_plus.dart';

class ViewShareImage extends StatelessWidget {
  final String path;

  const ViewShareImage({Key? key, required this.path}) : super(key: key);

  Future<void> shareFile() async {
    XFile xfile = XFile(path);
    await Share.shareXFiles([xfile]);
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text(''),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Stack(
          children: [
            PhotoViewGallery.builder(
              scrollPhysics: const BouncingScrollPhysics(),
              builder: (BuildContext context, int index) {
                return PhotoViewGalleryPageOptions(
                  imageProvider: FileImage(File(path)),
                  initialScale: PhotoViewComputedScale.contained * 0.8,
                  heroAttributes: const PhotoViewHeroAttributes(tag: 1),
                );
              },
              itemCount: 1,
              loadingBuilder: (context, event) => const Center(
                child: SizedBox(
                  width: 20.0,
                  height: 20.0,
                  child: CircularProgressIndicator(value: 1),
                ),
              ),
            ),
            Positioned(
              bottom: 16,
              right: 16,
              child: Material(
                color: const Color(0xff253890),
                borderRadius: BorderRadius.circular(50),
                elevation: 5,
                child: SizedBox(
                  height: 60,
                  width: 60,
                  child: Ink(
                    decoration: const ShapeDecoration(
                      color: Color(0xff253890),
                      shape: CircleBorder(),
                    ),
                    child: IconButton(
                      icon: const HeroIcon(HeroIcons.share),
                      color: Colors.white,
                      onPressed: () => shareFile(),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}