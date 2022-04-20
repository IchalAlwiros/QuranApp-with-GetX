import 'package:flutter_quran_app/app/data/models/detailsurah_models.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:get/get.dart';

class DetailSurahController extends GetxController {
  //TODO: Implement DetailSurahController

  Future<DetailSurah> getDetailSurah(String id) async {
    Uri url = Uri.parse('https://api.quran.sutanlab.id/surah/${id}');
    var response = await http.get(url);

    Map<String, dynamic> data =
        (json.decode(response.body) as Map<String, dynamic>)['data'];

    return DetailSurah.fromJson(data);
  }
}
