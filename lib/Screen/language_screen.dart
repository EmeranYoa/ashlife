import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:heroicons/heroicons.dart';

class LanguageScreen extends StatefulWidget {
  const LanguageScreen({Key? key}) : super(key: key);

  @override
  State<LanguageScreen> createState() => _LanguageScreenState();
}

class _LanguageScreenState extends State<LanguageScreen> {
  String local = "en_US";
  @override
  initState() {
    super.initState();
    local = Get.locale.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("txt_lang_title".tr),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Material(
              color: local == "fr_FR" ? Colors.blue.withOpacity(0.2) : Colors.grey.withOpacity(0.2),
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              child: InkWell(
                onTap: () {
                  final l = GetStorage();
                  Get.updateLocale(const Locale('fr','FR'));
                  l.write("lang", "fr_FR");
                  setState(() {
                    local = 'fr_FR';
                  });
                },
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            height: 30,
                            width: 40,
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(5)),
                              image: DecorationImage(
                                image: AssetImage('./assets/img/fr.png'),
                                fit: BoxFit.cover
                              ),
                            )
                          ),
                          const SizedBox(width: 5,),
                          Text('txt_fr'.tr,)
                        ],
                      ),),
                      Radio(
                        value: 'fr_FR',
                        groupValue: 'language',
                        onChanged: (String? value) {
                          print(value);
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10,),
            Material(
              color: local == "en_US" ? Colors.blue.withOpacity(0.2) : Colors.grey.withOpacity(0.2),
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              child: InkWell(
                onTap: () {
                  final l = GetStorage();
                  Get.updateLocale(const Locale('en','US'));
                  l.write("lang", "en_US");
                  setState(() {
                    local = 'en_US';
                  });
                },
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                              height: 30,
                              width: 40,
                              decoration: const BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(5)),
                                image: DecorationImage(
                                    image: AssetImage('./assets/img/en.png'),
                                    fit: BoxFit.cover
                                ),
                              )
                          ),
                          const SizedBox(width: 5,),
                          Text('txt_en'.tr,)
                        ],
                      ),),
                      Radio(
                        value: 'en_US',
                        groupValue: 'language',
                        onChanged: (String? value) {
                          print(value);
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
