import 'package:ashlife/Screen/Auth/register.dart';
import 'package:ashlife/controller/model.controller.dart';
import 'package:ashlife/controller/upload.controller.dart';
import 'package:ashlife/controller/auth.controller.dart';
import 'package:ashlife/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class ImageGenerated extends StatefulWidget {
  const ImageGenerated({Key? key}) : super(key: key);

  @override
  State<ImageGenerated> createState() => _ImageGeneratedState();
}

class _ImageGeneratedState extends State<ImageGenerated> {
  late ModelController _modelController;
  final modelId = "48c07a22-fa65-4143-a7af-f2ea85a0ecaa";
  final prompt = "woman with cornrows";

  @override
  void initState() {
    super.initState();
    _modelController = Get.put(ModelController());
    
  }

  @override
  void dispose() {
    _modelController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Your Images'),
        ),
        body: Expanded(child: Obx(() {
          List <String> images = [];
          bool loading = _modelController.loading.value;
          //var selectedImages = _modelController.selectedImages.value;
          return loading
              ? const Center(
                  child: CircularProgressIndicator(
                    color: Color(0xff253890),
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.only(left: 16, right: 16),
                  child: GridView.builder(  
                    gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 200,
                      childAspectRatio: 1,
                      crossAxisSpacing: 15,
                      mainAxisSpacing: 15,
                    ),
                    itemCount: images.length,
                    itemBuilder: (_, index) {
                      String imageUrl = images[index]; // Replace with your list of image URLs
                      return Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(
                            image: NetworkImage(imageUrl),
                            fit: BoxFit.cover,
                          ),
                        ),
                      );
                    },
                  )

                );
        })));
  }
}
