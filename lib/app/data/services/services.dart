import 'package:flutter_quran_app/app/data/models/detailsurah_models.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../models/surah_models.dart';

void services() async {
  //Surah
  Uri url = Uri.parse('https://api.quran.sutanlab.id/surah/');
  var response = await http.get(url);

  List data = (json.decode(response.body) as Map<String, dynamic>)['data'];

  //data dari api ke model
  Surah surahAnnas = Surah.fromJson(data[113]);

  //Detail Surah
  Uri urlAnnas =
      Uri.parse('https://api.quran.sutanlab.id/surah/${surahAnnas.number}');
  var responseAnnas = await http.get(urlAnnas);

  var dataAnnas =
      (jsonDecode(responseAnnas.body) as Map<String, dynamic>)['data'];
  //data dari api ke model
  DetailSurah annas = DetailSurah.fromJson(dataAnnas);

  // print(annas.verses![0].text!.arab);

  //Ayat
}
