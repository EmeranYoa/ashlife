import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:ashlife/controller/navigation.controller.dart';
import 'package:ashlife/data.dart';
import 'package:ashlife/models/ModelProvider.dart';
import 'package:ashlife/navigation/bottom_navigation.dart';
import 'package:ashlife/services/subscription.service.dart';
import 'package:get/get.dart';

class SubscriptionController extends GetxController {
  RxDouble currentPage = 0.0.obs;
  RxList plans = [].obs;
  RxList userPlans = [].obs;
  RxBool loading = false.obs;
  final SubscriptionService _subscriptionService = SubscriptionService();

  @override
  void onInit() {
    initializePlan();
    getAllUserPlan();
    super.onInit();
  }

  void changePage(double page) {
    currentPage.value = page;
  }

  Future<void> initializePlan() async {
    loading.value = true;
    final bool userCanTrial =
    await _subscriptionService.userCanSubscribeToTrialPlan();
    if (userCanTrial) {
      plans.value = planData;
      loading.value = false;
      return;
    }

    final List<Map<String, dynamic>> finalPlans = [];
    for (Map<String, dynamic> plan in planData) {
      if (plan['name'] == PLAN_TYPE.TRIAL.name) {
        continue;
      }
      finalPlans.add(plan);
    }
    plans.value = finalPlans;

    loading.value = false;
  }

  Future<void> subscribeTo() async {
    try {
      loading.value = true;
      await _subscriptionService.subscribe(plans[currentPage.value.toInt()]);
      getAllUserPlan();
      Get.back();

      Get.snackbar('Success',
          "You have successfully subscribed to the ${plans[currentPage.value
              .toInt()]['name']} plan");
      loading.value = false;
    } on Exception catch (e) {
      Get.snackbar('Error',
          "Error to subscribe to the ${plans[currentPage.value
              .toInt()]['name']} plan");
      loading.value = false;
    }
  }

  Future<void> getAllUserPlan() async {
    loading.value = true;
    final subscriptions = await _subscriptionService.userPlans();
    List pF = [];
    for (SubscriptionPlan sub in subscriptions) {
      pF.add(_getPlanCompleteMap(sub));
    }

    userPlans.value = pF;
    loading.value = false;
  }

  Map? _getPlanCompleteMap(SubscriptionPlan sub) {
    for (var p in planData) {
      if (p['name'] == sub.plan!.name.name &&
          (sub.status != PLAN_STATUS.END ||
              sub.status != PLAN_STATUS.CANCELED)) {
        final subMap = sub.toMap();
        return {...p, ...subMap};
      }
    }
    return null;
  }
}
