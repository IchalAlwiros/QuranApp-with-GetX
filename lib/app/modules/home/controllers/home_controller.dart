import 'package:flutter_quran_app/app/data/models/juz_models.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../../data/models/surah_models.dart';
import '../../../theme/theme.dart';

class HomeController extends GetxController {
  //TODO: Implement HomeController
  RxBool isDarkMode = false.obs;

  Future<List<Surah>> getAllSurah() async {
    Uri url = Uri.parse('https://api.quran.sutanlab.id/surah/');
    var response = await http.get(url);

    List data = (json.decode(response.body) as Map<String, dynamic>)['data'];

    if (data == null || data.isEmpty) {
      return [];
    } else {
      return data.map((e) => Surah.fromJson(e)).toList();
    }
  }

  Future<List<Juz>> getAllJuz() async {
    List<Juz> alljuz = [];
    for (var i = 1; i <= 30; i++) {
      Uri url = Uri.parse('https://api.quran.sutanlab.id/juz/$i');
      var response = await http.get(url);

      Map<String, dynamic> data =
          (json.decode(response.body) as Map<String, dynamic>)['data'];

      Juz juz = Juz.fromJson(data);
      alljuz.add(juz);
    }
    return alljuz;
  }
}
