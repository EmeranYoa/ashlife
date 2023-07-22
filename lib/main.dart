import 'dart:convert';

import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_datastore/amplify_datastore.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:amplify_storage_s3/amplify_storage_s3.dart';
import 'package:ashlife/amplifyconfiguration.dart';
import 'package:ashlife/constante.dart';
import 'package:ashlife/custom_router.dart';
import 'package:ashlife/languages.dart';
import 'package:ashlife/models/Image.dart' as ModelImage;
import 'package:ashlife/models/ModelProvider.dart';
import 'package:ashlife/services/http.service.dart';
import 'package:ashlife/services/notify.dart';
import 'package:ashlife/services/subscription.service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:workmanager/workmanager.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await _configureAmplify();
  await GetStorage.init();
  Notify().initNotification();
  Workmanager().initialize(callbackDispatcher, isInDebugMode: true);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      translations: Languages(),
      locale: getLocale(),
      fallbackLocale: const Locale('en', 'US'),
      title: 'Ashlife',
      theme: ThemeData(
        primarySwatch: mainAppColor,
      ),
      onGenerateRoute:
          CustomRouter.generateRoute, //Gestion des routes de l'application
      initialRoute: '/',
    );
  }
}

Future<void> _configureAmplify() async {
  final authPlugin = AmplifyAuthCognito();
  final apiPlugin = AmplifyAPI(modelProvider: ModelProvider.instance);
  final dataStorePlugin =
      AmplifyDataStore(modelProvider: ModelProvider.instance);
  final storagePlugin = AmplifyStorageS3();

  await Amplify.addPlugins(
      [dataStorePlugin, authPlugin, apiPlugin, storagePlugin]);

  try {
    await Amplify.configure(amplifyconfig);
    await Amplify.DataStore.clear();
  } on AmplifyAlreadyConfiguredException {
    safePrint(
        "Tried to reconfigure Amplify; this can occur when your app restarts on Android.");
  }
}

Locale getLocale() {
  List<String> languageCodes = [];
  final local = GetStorage();
  final lang = local.read("lang");
  if (lang != null) {
    final l = lang.split('_');
    languageCodes.add(l[0]);
    languageCodes.add(l[1]);
    return Locale(languageCodes[0], languageCodes[1]);
  }
  languageCodes = Get.deviceLocale.toString().split('_');
  final supportLang = ['fr_FR', 'en_US'];

  if (supportLang.any((e) => e.contains(Get.deviceLocale.toString()))) {
    return Locale(languageCodes[0], languageCodes[1]);
  }
  return const Locale('en', 'US');
}

void callbackDispatcher() {
  Workmanager().executeTask((taskName, inputData) async {
    if (taskName == 'checkTraining') {
      try {
        HttpService httpService = HttpService();
        final SubscriptionService subscriptionService = SubscriptionService();
        await _configureAmplify();
        String id = inputData!['id'];
        String userId = inputData!['userId'];

        final u = (await Amplify.DataStore.query(User.classType,
                where: User.PHONE.eq(userId)))
            .first;

        List<UserModel>? uM = u!.models;

        UserModel userModel =
            uM!.where((element) => element.modelId == id).first;

        if (userModel.status != "model_ready") {
          final response = await httpService.post(
              "https://stablediffusionapi.com/api/v3/fine_tune_status/$id");

          if (response['model_training_status'] == 'model_ready') {
            if (uM != null) {
              uM = uM.map((element) {
                if (element.modelId == id) {
                  final imageInstance =
                      ModelImage.Image(path: response['test_image']);
                  return element.copyWith(
                      status: response['model_training_status'],
                      image: imageInstance);
                }

                return element;
              }).toList();
            }

            final newUser = u.copyWith(models: uM);
            await Amplify.DataStore.save(newUser);

            subscriptionService.updateSubscription(ACTION_TYPE.GENERATION);
            Notify().showNotification(
                title: 'Model generation',
                body: 'Your model has been generated successfully',
                payLoad: '/main');
            return Future.value(true);
          }

          return Future.value(false);
        }
        return Future.value(true);
      } on ApiException catch (e) {
        return Future.value(false);
      }
    }

    if (taskName == 'checkModelRelaod') {
      try {
        HttpService httpService = HttpService();
        String modelId = inputData!['modelId'];

        final checkModelResponse = await httpService
            .post(httpService.dreamboothGetModelStatus + modelId);

        if (checkModelResponse['model_training_status'] == "model_ready") {
          Notify().showNotification(
              title: 'Model Loaded',
              body:
                  'Your model has been loaded successfully, you can use it now!',
              payLoad: '/main');

          return Future.value(true);
        }
        return Future.value(false);
      } on Exception catch (e) {
        return Future.value(false);
      }
    }

    if (taskName == 'checkGenerationResult') {
      try {
        HttpService httpService = HttpService();
        String generationId = inputData!['generationId'];

        final checkGenerationResponse = await httpService
            .post(httpService.dreamboothCheckGenerationResult + generationId);

        if (checkGenerationResponse['status'] == "success") {
          Notify().showNotification(
            title: 'Generation finish',
            body: 'We are finish to generate your image',
            payLoad: jsonEncode(checkGenerationResponse),
          );

          return Future.value(true);
        }

        if (checkGenerationResponse['status'] == "failed") {
          Notify().showNotification(
            title: 'Generation Error',
            body:
                'We encountered an error while generating your images, try again later',
            payLoad: jsonEncode(checkGenerationResponse),
          );

          return Future.value(true);
        }
        print('*=' * 100);
        print('Proccesing');
        return Future.value(false);
      } on Exception catch (e) {
        return Future.value(false);
      }
    }

    return Future.value(false);
  });
}
