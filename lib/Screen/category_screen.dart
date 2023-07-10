import 'package:ashlife/Screen/model_screen.dart';
import 'package:ashlife/controller/category.controller.dart';
import 'package:ashlife/controller/generator.controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CategoryScreen extends StatelessWidget {
  final String imageKey;
  final String modelId;
  final String modelType;

  const CategoryScreen({
    Key? key,
    required this.imageKey,
    required this.modelId,
    this.modelType = 'base',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    CategoryController controller = Get.put(CategoryController());
    GeneratorController gController = Get.put(GeneratorController());

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff253890),
        title: const Text('Filters'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'Choose Category',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 40, fontWeight: FontWeight.w600),
            ),
            const SizedBox(
              height: 5,
            ),
            const Text(
              'We have carefully prepared several categories to meet your specific needs. Please choose the one that best meets your expectations.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black38,
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Expanded(
              child: Obx(() {
                bool loading = controller.filterLoading.value;
                List filters = controller.filters.value;
                if (loading) {
                  return const Center(
                    child: CircularProgressIndicator(
                      color: Color(0xff253890),
                    ),
                  );
                }
                return GridView.builder(
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 200,
                      childAspectRatio: 1,
                      crossAxisSpacing: 15,
                      mainAxisSpacing: 15),
                  itemCount: filters.length,
                  itemBuilder: (_, index) {
                    return InkWell(
                      onTap: () {
                        gController.startGeneration(
                            filters[index], modelId, imageKey, modelType);
                        Get.dialog(
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 40),
                                child: Container(
                                  decoration: const BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(20),
                                    ),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(20.0),
                                    child: Material(
                                      color: Colors.white,
                                      child: Column(
                                        children: const [
                                          SizedBox(height: 10),
                                          Text(
                                            "Image generating",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          SizedBox(height: 15),
                                          Text(
                                            "Your image is being generated please wait",
                                            textAlign: TextAlign.center,
                                          ),
                                          SizedBox(height: 20),
                                          //Buttons

                                          CircularProgressIndicator(
                                            color: Color(0xff253890),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          barrierDismissible: false,
                        );
                      },
                      child: Container(
                        height: 100,
                        width: 100,
                        decoration: BoxDecoration(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10)),
                            image: DecorationImage(
                                image: FileImage(filters[index]['file']),
                                fit: BoxFit.cover),
                            gradient: LinearGradient(colors: [
                              const Color(0xff253890).withOpacity(0.6),
                              const Color(0xff1c40f3).withOpacity(0.6),
                            ], stops: const [
                              0.0,
                              1
                            ], begin: Alignment.center)),
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(10)),
                              gradient: LinearGradient(colors: [
                                const Color(0xff253890).withOpacity(0.6),
                                const Color(0xff1c40f3).withOpacity(0.6),
                              ], stops: const [
                                0.0,
                                1
                              ], begin: Alignment.center)),
                          child: Center(
                            child: Text(
                              filters[index]['name'],
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                );
              }),
            )
          ],
        ),
      ),
    );
  }
}
