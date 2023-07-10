import 'package:ashlife/Screen/category_screen.dart';
import 'package:ashlife/controller/model.controller.dart';
import 'package:ashlife/controller/navigation.controller.dart';
import 'package:ashlife/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class ModelScreen extends StatefulWidget {
  final String imageKey;

  const ModelScreen({Key? key, required this.imageKey}) : super(key: key);

  @override
  State<ModelScreen> createState() => _ModelScreenState();
}

class _ModelScreenState extends State<ModelScreen>
    with SingleTickerProviderStateMixin {
  final ModelController _controller = Get.put(ModelController());
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _controller.getBaseModel();
    _controller.getUserModel();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff253890),
        title: const Text('Models'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                'Choose Model',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 40, fontWeight: FontWeight.w600),
              ),
              const SizedBox(
                height: 5,
              ),
              const Text(
                'Please select one of our templates for generating your images. If none of our templates meet your expectations, you can create your own custom template.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black87,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              TabBar(
                controller: _tabController,
                indicatorSize: TabBarIndicatorSize.tab,
                labelColor: Colors.white,
                isScrollable: false,
                unselectedLabelColor: const Color(0xff253890),
                indicator: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: const Color(0xff253890),
                ),
                tabs: const [
                  Tab(
                    text: "Base models",
                  ),
                  Tab(
                    text: "My models",
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    Obx(() {
                      bool loading = _controller.loading.value;
                      List baseModel = _controller.baseModels.value;

                      if (loading) {
                        return const Center(
                          child: CircularProgressIndicator(
                            color: Color(0xff253890),
                          ),
                        );
                      }
                      return GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithMaxCrossAxisExtent(
                                maxCrossAxisExtent: 200,
                                childAspectRatio: 1,
                                crossAxisSpacing: 15,
                                mainAxisSpacing: 15),
                        itemCount: baseModel.length,
                        itemBuilder: (_, index) {
                          return Material(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(10),
                            child: InkWell(
                              onTap: () => {
                                Get.to(
                                    CategoryScreen(
                                        imageKey: widget.imageKey,
                                        modelId: baseModel[index]['model_id']),
                                    duration: const Duration(milliseconds: 800),
                                    transition: Transition.rightToLeft)
                              },
                              child: Container(
                                height: 100,
                                width: 100,
                                decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(10)),
                                    image: DecorationImage(
                                        image:
                                            FileImage(baseModel[index]['file']),
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
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(10)),
                                      gradient: LinearGradient(colors: [
                                        const Color(0xff253890)
                                            .withOpacity(0.6),
                                        const Color(0xff1c40f3)
                                            .withOpacity(0.6),
                                      ], stops: const [
                                        0.0,
                                        1
                                      ], begin: Alignment.center)),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Center(
                                      child: Text(
                                        baseModel[index]['model_name'],
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w700,
                                          fontSize: 16,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    }),
                    Obx(() {
                      bool loading = _controller.loading.value;
                      List myModels = _controller.myModels.value;

                      if (loading) {
                        return const Center(
                          child: CircularProgressIndicator(
                            color: Color(0xff253890),
                          ),
                        );
                      }

                      if (myModels.isEmpty) {
                        return Column(
                          children: [
                            const SizedBox(height: 50),
                            const Image(
                              image: AssetImage('assets/img/empty.png'),
                              fit: BoxFit.contain,
                              height: 200,
                              width: 200,
                            ),
                            SizedBox(
                              width: size.width * 0.5,
                              child: CustomButton(
                                  text: 'Create new model',
                                  textColor: Colors.white,
                                  color: const Color(0xff253890),
                                  pressed: () {
                                    Get.back(canPop: false);
                                  },
                                  isLoading: false),
                            )
                          ],
                        );
                      }
                      return GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithMaxCrossAxisExtent(
                                maxCrossAxisExtent: 200,
                                childAspectRatio: 1,
                                crossAxisSpacing: 15,
                                mainAxisSpacing: 15),
                        itemCount: myModels.length,
                        itemBuilder: (_, index) {
                          return Material(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(10),
                            child: InkWell(
                              onTap: () => {
                                Get.to(
                                  CategoryScreen(
                                    imageKey: widget.imageKey,
                                    modelId: myModels[index]['model_id'],
                                    modelType: 'custom',
                                  ),
                                  duration: const Duration(milliseconds: 800),
                                  transition: Transition.rightToLeft,
                                )
                              },
                              child: Container(
                                height: 100,
                                width: 100,
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(10)),
                                  image: DecorationImage(
                                      image: FileImage(myModels[index]['file']),
                                      fit: BoxFit.cover),
                                  gradient: LinearGradient(colors: [
                                    const Color(0xff253890).withOpacity(0.6),
                                    const Color(0xff1c40f3).withOpacity(0.6),
                                  ], stops: const [
                                    0.0,
                                    1
                                  ], begin: Alignment.center),
                                ),
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(10)),
                                      gradient: LinearGradient(colors: [
                                        const Color(0xff253890)
                                            .withOpacity(0.6),
                                        const Color(0xff1c40f3)
                                            .withOpacity(0.6),
                                      ], stops: const [
                                        0.0,
                                        1
                                      ], begin: Alignment.center)),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Center(
                                      child: Text(
                                        myModels[index]['model_name'],
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w700,
                                          fontSize: 16,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    }),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
