import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:ashlife/models/ModelProvider.dart';
import 'package:ashlife/services/auth.service.dart';
import 'package:get/get.dart';

enum ACTION_TYPE { TRAINNING, GENERATION }

class SubscriptionService {
  final AuthService _authService = Get.put(AuthService());

  Future<bool> userCanGenerate() async {
    final username = (await _authService.getCurrentUser())!.username;

    final User user = (await Amplify.DataStore.query(User.classType,
            where: User.PHONE.eq(username)))
        .first;
    final List<SubscriptionPlan> subscriptionPlans =
        await Amplify.DataStore.query(SubscriptionPlan.classType,
            where: SubscriptionPlan.USER.eq(user.id));

    if (subscriptionPlans.isEmpty) {
      return false;
    }

    bool response = false;
    for (final SubscriptionPlan subscriptionPlan in subscriptionPlans) {
      final remainGeneration = subscriptionPlan.remainSX;
      final TemporalDateTime? startDate = subscriptionPlan.startAt;
      final nbrDays = subscriptionPlan.plan!.duration;
      if (!response) {
        if (startDate!.getOffset()!.inDays > nbrDays!) {
          if (subscriptionPlan.status != PLAN_STATUS.END) {
            final updatePlan =
                subscriptionPlan.copyWith(status: PLAN_STATUS.END);

            await Amplify.DataStore.save(updatePlan);
          }
          continue;
        }
        if (remainGeneration == 0) {
          final updatePlan = subscriptionPlan.copyWith(status: PLAN_STATUS.END);

          await Amplify.DataStore.save(updatePlan);
          continue;
        }
        response = true;
      }
    }
    return response;
  }

  Future<bool> userCanGenerateModel() async {
    final username = (await _authService.getCurrentUser())!.username;

    final User user = (await Amplify.DataStore.query(User.classType,
            where: User.PHONE.eq(username)))
        .first;
    final List<SubscriptionPlan> subscriptionPlans =
        await Amplify.DataStore.query(SubscriptionPlan.classType,
            where: SubscriptionPlan.USER.eq(user.id));

    if (subscriptionPlans.isEmpty) {
      return false;
    }

    bool response = false;
    for (final SubscriptionPlan subscriptionPlan in subscriptionPlans) {
      final remainTraining = subscriptionPlan.remainTraining;
      final TemporalDateTime? startDate = subscriptionPlan.startAt;
      final nbrDays = subscriptionPlan.plan!.duration;
      if (!response) {
        if (startDate!.getOffset()!.inDays > nbrDays!) {
          if (subscriptionPlan.status != PLAN_STATUS.END) {
            final updatePlan =
                subscriptionPlan.copyWith(status: PLAN_STATUS.END);

            await Amplify.DataStore.save(updatePlan);
          }
          continue;
        }
        if (remainTraining == 0) {
          final updatePlan = subscriptionPlan.copyWith(status: PLAN_STATUS.END);

          await Amplify.DataStore.save(updatePlan);
          continue;
        }
        response = true;
      }
    }
    return response;
  }

  Future<bool> userCanSubscribeToTrialPlan() async {
    final username = (await _authService.getCurrentUser())!.username;

    final User user = (await Amplify.DataStore.query(User.classType,
            where: User.PHONE.eq(username)))
        .first;
    final List<SubscriptionPlan> subscriptionPlans =
        await Amplify.DataStore.query(SubscriptionPlan.classType,
            where: SubscriptionPlan.USER.eq(user.id));

    if (subscriptionPlans.isEmpty) {
      return true;
    }
    return false;
  }

  Future<void> subscribe(Map<String, dynamic> entryPlan) async {
    try {
      final username = (await _authService.getCurrentUser())!.username;

      final User user = (await Amplify.DataStore.query(User.classType,
              where: User.PHONE.eq(username)))
          .first;

      Plan plan = Plan.fromJson(entryPlan);
      TemporalDateTime startAt = TemporalDateTime.now();
      SubscriptionPlan planSubscribe = SubscriptionPlan(
          user: user,
          plan: plan,
          remainSX: plan.limit,
          remainTraining: plan.nbTraining,
          startAt: startAt,
          status: PLAN_STATUS.NEW);

      await Amplify.DataStore.save(planSubscribe);
    } on Exception catch (e) {
      print("Subscribe Error : ${e.toString()}");
    }
  }

  Future<void> updateSubscription(ACTION_TYPE type) async {
    final username = (await _authService.getCurrentUser())!.username;

    final User user = (await Amplify.DataStore.query(User.classType,
            where: User.PHONE.eq(username)))
        .first;

    final List<SubscriptionPlan> subscriptionPlans =
        await Amplify.DataStore.query(SubscriptionPlan.classType,
            where: SubscriptionPlan.USER.eq(user.id),
            sortBy: [SubscriptionPlan.STARTAT.ascending()]);

    int maxDay = 0;
    late SubscriptionPlan subscription;

    for (final SubscriptionPlan subscriptionPlan in subscriptionPlans) {
      Duration planNbrStartDay = subscriptionPlan.startAt!.getOffset()!;
      if (planNbrStartDay.inDays > maxDay &&
          subscriptionPlan.status == PLAN_STATUS.NEW) {
        subscription = subscriptionPlan;
        continue;
      }

      // check if subscription expired limit
      if (subscription.remainSX == 0) {
        final SubscriptionPlan updateSubscription =
            subscription.copyWith(status: PLAN_STATUS.END);
        await Amplify.DataStore.save(updateSubscription);
      }
    }
    // get the old subscription update the subscription.
    print('*=' * 50);
    print(subscription);
    if (type == ACTION_TYPE.GENERATION) {
      final SubscriptionPlan updateSubscription = subscription.copyWith(
          remainTraining: subscription.remainTraining! - 1);
      await Amplify.DataStore.save(updateSubscription);
      return;
    }
    final SubscriptionPlan updateSubscription =
        subscription.copyWith(remainTraining: subscription.remainSX! - 1);
    await Amplify.DataStore.save(updateSubscription);
  }

  Future<List> userPlans() async {
    final username = (await _authService.getCurrentUser())!.username;

    final User user = (await Amplify.DataStore.query(User.classType,
            where: User.PHONE.eq(username)))
        .first;

    final List<SubscriptionPlan> plans = await Amplify.DataStore.query(
        SubscriptionPlan.classType,
        where: SubscriptionPlan.USER.eq(user.id));
    if (plans != null) {
      return plans;
    }
    return [];
  }
}
