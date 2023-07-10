import 'package:ashlife/controller/subscription.controller.dart';
import 'package:ashlife/models/ModelProvider.dart';
import 'package:ashlife/widgets/custom_button.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class SubscriptionScreen extends StatelessWidget {
  const SubscriptionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final PageController _pageController = PageController(initialPage: 0);
    SubscriptionController _subscriptionController =
        Get.put(SubscriptionController());

    final size = MediaQuery.of(context).size;
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
      ),
      child: Scaffold(
        body: Obx(() {
          bool loading = _subscriptionController.loading.value;

          if (loading) {
            return Container(
              width: double.infinity,
              height: double.infinity,
              color: Colors.white,
              child: const Center(
                child: SizedBox(
                  height: 30,
                  width: 30,
                  child: CircularProgressIndicator(
                    color: Color(0xff253890),
                    strokeWidth: 1,
                  ),
                ),
              ),
            );
          }
          return Stack(
            children: [
              PageView.builder(
                controller: _pageController,
                onPageChanged: (int page) {
                  _subscriptionController.changePage(page.toDouble());
                },
                itemCount: _subscriptionController.plans.value.length,
                itemBuilder: (BuildContext context, int index) {
                  return PlanSubscription(
                      size: size, plan: _subscriptionController.plans[index]);
                },
              ),
              Positioned(
                bottom: 30,
                left: 100,
                right: 100,
                child: CustomButton(
                  color: const Color(0xff253890),
                  text: _subscriptionController.plans.value[
                              _subscriptionController.currentPage.value
                                  .toInt()]['name'] ==
                          PLAN_TYPE.TRIAL.name
                      ? 'Try'
                      : 'buy now',
                  textColor: Colors.white,
                  pressed: () {
                    _subscriptionController.subscribeTo();
                  },
                  isLoading: false,
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: DotsIndicator(
                  dotsCount: _subscriptionController.plans.value.length,
                  position: _subscriptionController.currentPage.value,
                  decorator: DotsDecorator(
                      size: const Size.square(9),
                      color: Colors.black26,
                      activeSize: const Size(18.0, 9.0),
                      activeShape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5))),
                  // decorator: DotsDecorator(
                  //   spacing: const EdgeInsets.all(10.0),
                  // ),
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}

class PlanSubscription extends StatelessWidget {
  const PlanSubscription({
    super.key,
    required this.size,
    required this.plan,
  });

  final Size size;
  final Map<String, dynamic> plan;

  @override
  Widget build(BuildContext context) {
    List<Color> colors = plan['color'];
    var f = NumberFormat.currency(name: "");

    return Stack(
      children: [
        Column(
          children: [
            ClipPath(
              clipper: SubscriptionFormClipper(),
              child: Container(
                height: size.height * 0.5,
                width: size.width,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: colors,
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        plan['description'],
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            height: 1.5),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        plan['name'].toUpperCase(),
                        style: const TextStyle(
                          color: const Color(0xff253890),
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 2,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            f.format(plan['price']).toUpperCase(),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 50,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 2,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          Text(
                            "${plan['currency']}".toUpperCase(),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 2,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.check_circle,
                        color: Colors.blueGrey,
                        size: 28,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Expanded(
                        child: Text(
                          'Our service allows you to generate up to ${plan['limit']} unique image sets, each containing  ${plan['size']} images. With our advanced technology, you can easily and quickly create up to ${plan['limit'] * plan['size']} high-quality images to suit your business or personal needs.',
                          style: const TextStyle(color: Colors.black54),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      const Icon(
                        Icons.check_circle,
                        color: Colors.blueGrey,
                        size: 28,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Expanded(
                        child: Text(
                          'You can generate ${plan['nbTraining']} custom templates for your custom images.',
                          style: const TextStyle(color: Colors.black54),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      const Icon(
                        Icons.check_circle,
                        color: Colors.blueGrey,
                        size: 28,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Expanded(
                        child: Text(
                          'you can use this plan for ${plan["duration"]} days',
                          style: const TextStyle(color: Colors.black54),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
        Positioned(
          bottom: 0,
          child: ClipPath(
            clipper: SubscriptionBottomFormClipper(),
            child: Container(
              width: size.width,
              height: 150,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: colors,
                    begin: Alignment.bottomLeft,
                    end: Alignment.topRight),
              ),
            ),
          ),
        )
      ],
    );
  }
}

class SubscriptionFormClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();

    path.lineTo(0, size.height * 0.7);

    path.quadraticBezierTo(
        size.width * 0.9, size.height + 30, size.width, size.height * 0.85);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}

class SubscriptionBottomFormClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path0 = Path();

    path0.moveTo(size.width * 0.1498917, size.height * 0.4264429);
    path0.quadraticBezierTo(size.width * 0.0835333, size.height * 0.4272429, 0,
        size.height * 0.5550286);
    path0.lineTo(size.width * 0.0002500, size.height * 0.9996429);
    path0.lineTo(size.width * 0.5463583, size.height * 0.9991143);
    path0.quadraticBezierTo(size.width * 0.2666333, size.height * 0.4277857,
        size.width * 0.1498917, size.height * 0.4264429);
    path0.close();
    return path0;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}
