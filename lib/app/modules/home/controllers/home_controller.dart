import 'package:flutter/material.dart';
import 'package:flutter_quran_app/app/data/models/juz_models.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../../data/models/surah_models.dart';
import '../../../theme/theme.dart';

class HomeController extends GetxController {
  //TODO: Implement HomeController

  List<Surah> allSurah = []; //digunakan untuk menampung

  RxBool isDarkMode = false.obs;

  void changeThemeMode() async {
    if (Get.isDarkMode)
      Get.changeThemeMode(ThemeMode.light);
    else
      Get.changeThemeMode(ThemeMode.dark);
    isDarkMode.toggle();

    final box = GetStorage();

    if (Get.isDarkMode) {
      //dark => light
      box.remove('themeDark');
    } else {
      //light => dark
      box.write('themeDark', true);
    }
  }

  Future<List<Surah>> getAllSurah() async {
    Uri url = Uri.parse('https://api.quran.sutanlab.id/surah/');
    var response = await http.get(url);

    List data = (json.decode(response.body) as Map<String, dynamic>)['data'];

    if (data == null || data.isEmpty) {
      return [];
    } else {
      allSurah = data.map((e) => Surah.fromJson(e)).toList();
      return allSurah;
    }
  }

  Future<List<JuzQuran>> getAllJuz() async {
    List<JuzQuran> alljuz = [];
    for (var i = 1; i <= 30; i++) {
      Uri url = Uri.parse('https://api.quran.sutanlab.id/juz/$i');
      var response = await http.get(url);

      Map<String, dynamic> data =
          (json.decode(response.body) as Map<String, dynamic>)['data'];

      JuzQuran juz = JuzQuran.fromJson(data);
      alljuz.add(juz);
    }
    return alljuz;
  }
}
