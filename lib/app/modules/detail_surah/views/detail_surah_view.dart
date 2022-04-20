import 'package:flutter/material.dart';
import 'package:flutter_quran_app/app/data/models/detailsurah_models.dart'
    as detail;
import 'package:flutter_quran_app/app/data/models/surah_models.dart';
import 'package:flutter_quran_app/app/theme/theme.dart';

import 'package:get/get.dart';

import '../controllers/detail_surah_controller.dart';

class DetailSurahView extends GetView<DetailSurahController> {
  Surah surah = Get.arguments;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Surah ${surah.name!.transliteration!.id!.toUpperCase()}'),
        centerTitle: true,
      ),
      body: ListView(
        padding: EdgeInsets.all(20),
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Text(
                    '${surah.name?.transliteration!.id!.toUpperCase() ?? 'error'}',
                    style: blackTextStyle,
                  ),
                  Text(
                    '${surah.name?.translation!.id!.toUpperCase() ?? 'error'}',
                    style: blackTextStyle,
                  ),
                  SizedBox(height: 20),
                  Text(
                    '${surah.numberOfVerses ?? 'error'} ayat | ${surah}',
                    style: blackTextStyle,
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 20),
          FutureBuilder<detail.DetailSurah>(
            future: controller.getDetailSurah(surah.number.toString()),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (!snapshot.hasData) {
                return Center(
                  child: Text('Tidak ada Data'),
                );
              }
              // print(snapshot.data);
              return Expanded(
                child: ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: snapshot.data?.verses?.length ?? 0,
                    itemBuilder: (context, index) {
                      if (snapshot.data?.verses?.length == 0) {
                        return SizedBox();
                      }
                      detail.Verse? ayat = snapshot.data?.verses?[index];
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Card(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 5),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  CircleAvatar(
                                    child: Text('${index + 1}'),
                                  ),
                                  Row(
                                    children: [
                                      IconButton(
                                          onPressed: () {},
                                          icon: Icon(
                                            Icons.bookmark_add_outlined,
                                          )),
                                      IconButton(
                                          onPressed: () {},
                                          icon: Icon(
                                            Icons.play_arrow,
                                          ))
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: 20),
                          Text(
                            '${ayat!.text?.arab}',
                            style: blackTextStyle.copyWith(
                              fontWeight: semiBold,
                              fontSize: 22,
                            ),
                            textAlign: TextAlign.end,
                          ),
                          SizedBox(height: 20),
                          Text(
                            '${ayat.translation?.en}',
                            style: blackTextStyle.copyWith(
                              fontWeight: light,
                              fontSize: 14,
                            ),
                            textAlign: TextAlign.end,
                          ),
                          SizedBox(height: 20),
                          Text(
                            '${ayat.translation?.id}',
                            style: blackTextStyle.copyWith(
                              fontWeight: medium,
                              fontSize: 16,
                            ),
                            textAlign: TextAlign.justify,
                          ),
                          SizedBox(height: 30)
                        ],
                      );
                    }),
              );
            },
          )
        ],
      ),
    );
  }
}
