import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:ashlife/models/ModelProvider.dart';
import 'package:ashlife/services/auth.service.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';

enum ACTION_TYPE { TRAINNING, GENERATION }

class SubscriptionService {
  final AuthService _authService = Get.put(AuthService());

  Future<bool> userCanGenerate() async {
    final username = (await _authService.getCurrentUser())!.username;

    final request = ModelQueries.list(User.classType);
    final result = await Amplify.API.query(request: request).response;

    final user =
        result.data?.items.where((element) => element?.phone == username).first;

    final req = ModelQueries.list(SubscriptionPlan.classType,
        where: SubscriptionPlan.USER.eq(user?.id));

    final res = await Amplify.API.query(request: req).response;
    final List<SubscriptionPlan?>? subscriptionPlans = res.data?.items;
    if (subscriptionPlans != null && subscriptionPlans.isEmpty) {
      return false;
    }

    bool response = false;
    if (subscriptionPlans != null) {
      for (final SubscriptionPlan? subscriptionPlan in subscriptionPlans) {
        final remainGeneration = subscriptionPlan?.remainSX;
        final TemporalDateTime? startDate = subscriptionPlan?.startAt;
        final nbrDays = subscriptionPlan?.plan!.duration;
        if (!response) {
          if (startDate!.getOffset()!.inDays > nbrDays!) {
            if (subscriptionPlan?.status != PLAN_STATUS.END) {
              final updatePlan =
                  subscriptionPlan?.copyWith(status: PLAN_STATUS.END);

              final request = ModelMutations.update(updatePlan!);
              await Amplify.API.mutate(request: request);
            }
            continue;
          }
          if (remainGeneration == 0) {
            final updatePlan =
                subscriptionPlan?.copyWith(status: PLAN_STATUS.END);

            final request = ModelMutations.update(updatePlan!);
            await Amplify.API.mutate(request: request);
            continue;
          }
          response = true;
        }
      }
    }
    return response;
  }

  Future<bool> userCanGenerateModel() async {
    final username = (await _authService.getCurrentUser())!.username;

    var request =
        ModelQueries.list(User.classType, where: User.PHONE.eq(username));
    final result = await Amplify.API.query(request: request).response;
    final user = result.data?.items.first;

    final req = ModelQueries.list(SubscriptionPlan.classType,
        where: SubscriptionPlan.USER.eq(user?.id));
    final res = await Amplify.API.query(request: req).response;
    final List<SubscriptionPlan?>? subscriptionPlans = res.data?.items;

    if (subscriptionPlans != null && subscriptionPlans.isEmpty) {
      return false;
    }

    bool response = false;
    if (subscriptionPlans != null) {
      for (final SubscriptionPlan? subscriptionPlan in subscriptionPlans) {
        final remainTraining = subscriptionPlan?.remainTraining;
        final TemporalDateTime? startDate = subscriptionPlan?.startAt;
        final nbrDays = subscriptionPlan?.plan!.duration;
        if (!response) {
          if (startDate!.getOffset()!.inDays > nbrDays!) {
            if (subscriptionPlan?.status != PLAN_STATUS.END) {
              final updatePlan =
                  subscriptionPlan?.copyWith(status: PLAN_STATUS.END);

              final request = ModelMutations.update(updatePlan!);
              await Amplify.API.mutate(request: request);
            }
            continue;
          }
          if (remainTraining == 0) {
            final updatePlan =
                subscriptionPlan?.copyWith(status: PLAN_STATUS.END);

            final request = ModelMutations.update(updatePlan!);
            await Amplify.API.mutate(request: request);
            continue;
          }
          response = true;
        }
      }
    }
    return response;
  }

  Future<bool> userCanSubscribeToTrialPlan() async {
    final username = (await _authService.getCurrentUser())!.username;

    var request =
        ModelQueries.list(User.classType, where: User.PHONE.eq(username));
    final result = await Amplify.API.query(request: request).response;
    final user = result.data?.items.first;

    final req = ModelQueries.list(SubscriptionPlan.classType,
        where: SubscriptionPlan.USER.eq(user?.id));
    final res = await Amplify.API.query(request: req).response;
    final List<SubscriptionPlan?>? subscriptionPlans = res.data?.items;

    if (subscriptionPlans != null && subscriptionPlans.isEmpty) {
      return true;
    }
    return false;
  }

  Future<void> subscribe(Map<String, dynamic> entryPlan) async {
    try {
      final username = (await _authService.getCurrentUser())!.username;

      var request =
          ModelQueries.list(User.classType, where: User.PHONE.eq(username));
      final result = await Amplify.API.query(request: request).response;
      final user = result.data?.items.first;
      Plan plan = Plan.fromJson(entryPlan);
      TemporalDateTime startAt = TemporalDateTime.now();
      SubscriptionPlan planSubscribe = SubscriptionPlan(
          user: user!,
          plan: plan,
          remainSX: plan.limit,
          remainTraining: plan.nbTraining,
          startAt: startAt,
          status: PLAN_STATUS.NEW);

      final req = ModelMutations.create(planSubscribe);
      await Amplify.API.mutate(request: req);
    } on Exception catch (e) {
      print("Subscribe Error : ${e.toString()}");
    }
  }

  Future<void> updateSubscription(ACTION_TYPE type) async {
    final username = (await _authService.getCurrentUser())!.username;

    var request =
        ModelQueries.list(User.classType, where: User.PHONE.eq(username));
    final result = await Amplify.API.query(request: request).response;
    final user = result.data?.items.first;

    final req = ModelQueries.list(SubscriptionPlan.classType,
        where: SubscriptionPlan.USER.eq(user?.id));
    final res = await Amplify.API.query(request: req).response;
    final List<SubscriptionPlan?>? subscriptionPlans = res.data?.items;

    //sortBy: [SubscriptionPlan.STARTAT.ascending()]);

    int maxDay = 0;
    late SubscriptionPlan subscription;

    if (subscriptionPlans != null) {
      for (final SubscriptionPlan? subscriptionPlan in subscriptionPlans) {
        Duration planNbrStartDay = subscriptionPlan!.startAt!.getOffset()!;
        if (planNbrStartDay.inDays > maxDay &&
            subscriptionPlan.status == PLAN_STATUS.NEW) {
          subscription = subscriptionPlan;
          continue;
        }

        // check if subscription expired limit
        if (subscription.remainSX == 0) {
          final SubscriptionPlan updateSubscription =
              subscription.copyWith(status: PLAN_STATUS.END);

          final request = ModelMutations.update(updateSubscription);
          await Amplify.API.mutate(request: request);
        }
      }
    }
    // get the old subscription update the subscription.
    print('*=' * 50);
    print(subscription);
    if (type == ACTION_TYPE.GENERATION) {
      final SubscriptionPlan updateSubscription = subscription.copyWith(
          remainTraining: subscription.remainTraining! - 1);
      final request = ModelMutations.update(updateSubscription);
      await Amplify.API.mutate(request: request);
      return;
    }
    final SubscriptionPlan updateSubscription =
        subscription.copyWith(remainTraining: subscription.remainSX! - 1);
    final req1 = ModelMutations.update(updateSubscription);
    await Amplify.API.mutate(request: req1);
  }

  Future<List> userPlans() async {
    final username = (await _authService.getCurrentUser())!.username;

    var request =
        ModelQueries.list(User.classType, where: User.PHONE.eq(username));
    final result = await Amplify.API.query(request: request).response;
    final user = result.data?.items.first;

    final req2 = ModelQueries.list(SubscriptionPlan.classType,
        where: SubscriptionPlan.USER.eq(user?.id));

    final res = await Amplify.API.query(request: req2).response;
    final List<SubscriptionPlan?>? plans = res.data?.items;

    if (plans != null) {
      return plans;
    }
    return [];
  }
}
