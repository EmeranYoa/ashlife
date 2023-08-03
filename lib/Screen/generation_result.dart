import 'dart:io';

import 'package:ashlife/controller/generator.controller.dart';
import 'package:ashlife/services/cache.service.dart';
import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:image_picker/image_picker.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';

class GenerationResult extends StatefulWidget {
  final List images;

  const GenerationResult({Key? key, required this.images}) : super(key: key);

  @override
  State<GenerationResult> createState() => _GenerationResultState();
}

class _GenerationResultState extends State<GenerationResult> {
  final CacheService _cacheService = Get.put(CacheService());
  final GeneratorController _controller = Get.put(GeneratorController());
  int currentIndex = 0;

  void saveImages() {
    _controller.saveGenerateImage(widget.images[currentIndex]);
  }

  bool elementExist() {
    return _controller.images.value
        .any((map) => map.path == widget.images[currentIndex]);
  }

  void terminateGenerationProcess() {
    if (_controller.images.value.isEmpty) {
      return;
    }
    _controller.updateGenerationData();
  }

  Future<void> shareImage() async {
    File? file = await _cacheService.getImageFile(widget.images[currentIndex]);

    if (file != null) {
      await Share.shareXFiles([XFile(file.path)]);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xff253890),
          title: const Text('Generated images'),
          actions: [
            IconButton(
              onPressed: () {
                terminateGenerationProcess();
              },
              icon: const Icon(Icons.save),
              color: Colors.white,
            )
          ],
          centerTitle: true,
        ),
        body: SafeArea(
          child: Obx(() {
            bool isLoading = _controller.isGenerating.value;

            if (!isLoading) {
              return Stack(
                children: [
                  PhotoViewGallery.builder(
                    scrollPhysics: const BouncingScrollPhysics(),
                    builder: (BuildContext context, int index) {
                      return PhotoViewGalleryPageOptions(
                        imageProvider: NetworkImage(widget.images[index]),
                        initialScale: PhotoViewComputedScale.contained * 0.8,
                        heroAttributes: const PhotoViewHeroAttributes(tag: 1),
                      );
                    },
                    itemCount: widget.images.length,
                    loadingBuilder: (context, event) => const Center(
                      child: SizedBox(
                        width: 20.0,
                        height: 20.0,
                        child: CircularProgressIndicator(
                            color: Color(0xff253890), value: 1),
                      ),
                    ),
                    onPageChanged: (index) {
                      setState(() {
                        currentIndex = index;
                      });
                    },
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
                            onPressed: () {
                              shareImage();
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 90,
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
                            icon: const Icon(Icons.save),
                            color: Colors.white,
                            onPressed: () => terminateGenerationProcess(),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 164,
                    right: 16,
                    child: Material(
                      color: const Color(0xff253890),
                      borderRadius: BorderRadius.circular(50),
                      elevation: 5,
                      child: SizedBox(
                        height: 60,
                        width: 60,
                        child: Ink(
                          decoration: ShapeDecoration(
                            color: elementExist()
                                ? Colors.red
                                : const Color(0xff253890),
                            shape: const CircleBorder(),
                          ),
                          child: IconButton(
                            icon: elementExist()
                                ? const HeroIcon(HeroIcons.xMark)
                                : const HeroIcon(HeroIcons.check),
                            color: Colors.white,
                            onPressed: () => saveImages(),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              );
            }
            return const Center(
              child: SizedBox(
                height: 50,
                width: 50,
                child: CircularProgressIndicator(),
              ),
            );
          }),
        ));
  }
}
