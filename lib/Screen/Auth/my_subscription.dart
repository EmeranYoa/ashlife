import 'dart:io';

import 'package:ashlife/Screen/subscription_screen.dart';
import 'package:ashlife/controller/auth.controller.dart';
import 'package:ashlife/controller/subscription.controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:heroicons/heroicons.dart';
import 'package:intl/intl.dart';

import '../../widgets/form.dart';

class MySubscription extends StatefulWidget {
  const MySubscription({Key? key}) : super(key: key);

  @override
  State<MySubscription> createState() => _MySubscriptionState();
}

class _MySubscriptionState extends State<MySubscription> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    SubscriptionController subscriptionController =
        Get.put(SubscriptionController());

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: const Text("My subscription"),
      ),
      floatingActionButton: Material(
        color: const Color(0xff253890),
        borderRadius: BorderRadius.circular(50),
        child: InkWell(
          splashColor: const Color(0xff253890).withOpacity(0.4),
          borderRadius: BorderRadius.circular(50),
          onTap: () {
            Get.to(
              const SubscriptionScreen(),
              duration: const Duration(milliseconds: 800),
              transition: Transition.downToUp,
            );
          },
          child: SizedBox(
            height: 60,
            width: 60,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const <Widget>[
                Icon(
                  Icons.add,
                  color: Colors.white,
                ),
              ],
            ),
          ),
        ),
      ),
      body: Container(
          color: const Color(0xff253890).withOpacity(0.4),
          child: Obx(() {
            final bool loading = subscriptionController.loading.value;
            final List userPlans = subscriptionController.userPlans.value;
            if (loading) {
              return const Center(
                child: SizedBox(
                  height: 30,
                  width: 30,
                  child: CircularProgressIndicator(
                      color: Colors.white, strokeWidth: 1),
                ),
              );
            }

            return Column(
              children: [
                Container(
                  height: size.height * 0.15,
                  width: size.width,
                  decoration: const BoxDecoration(
                    color: Color(0xff253890),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                    ),
                  ),
                  child: Padding(
                    padding:
                        const EdgeInsets.only(left: 16, right: 16, bottom: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Plans : ${subscriptionController.userPlans.value.length}",
                          style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                              fontSize: 18),
                        ),
                        const Text(
                          'Total models : 3 / 5',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                              fontSize: 18),
                        ),
                        const Text(
                          'Total generation : 10 / 15',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                              fontSize: 18),
                        ),
                      ],
                    ),
                  ),
                ),
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: userPlans.length,
                  itemBuilder: (context, index) {
                    final DateTime date =
                        DateTime.parse(userPlans[index]['startAt'].format());
                    final DateFormat formatter = DateFormat('dd MMM yyyy');
                    return Padding(
                      padding:
                          const EdgeInsets.only(top: 10, left: 16, right: 16),
                      child: Container(
                        height: 100,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: userPlans[index]['color'],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: const EdgeInsets.only(
                            left: 16, right: 16, top: 10, bottom: 10),
                        child: Column(
                          children: [
                            Text(
                              userPlans[index]['name'],
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                letterSpacing: 3,
                              ),
                            ),
                            SizedBox(
                              width: double.infinity,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "StartAt: ${formatter.format(date)}",
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Text(
                                    "Remain Generation: ${userPlans[index]['remainSX'].toString()}",
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Text(
                                    "Remain Model: ${userPlans[index]['remainTraining'].toString()}",
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ],
            );
          })),
    );
  }
}
