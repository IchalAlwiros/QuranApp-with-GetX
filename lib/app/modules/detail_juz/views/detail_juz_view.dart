import 'package:flutter/material.dart';
import 'package:flutter_quran_app/app/data/models/surah_models.dart';

import 'package:get/get.dart';

import '../../../data/models/juz_models.dart' as juz;
import '../../../theme/theme.dart';
import '../controllers/detail_juz_controller.dart';

class DetailJuzView extends GetView<DetailJuzController> {
  final juz.JuzQuran detailJuz = Get.arguments["juz"];
  final List<Surah> allSurahThisJuz = Get.arguments["surah"];

  @override
  Widget build(BuildContext context) {
    allSurahThisJuz.forEach((elemenet) {
      print(elemenet.name!.transliteration!.id);
    });
    return Scaffold(
        appBar: AppBar(
          title: Text('JUZ ${detailJuz.juz}'),
          centerTitle: true,
        ),
        body: ListView.builder(
          itemCount: detailJuz.verses?.length ?? 0,
          itemBuilder: (context, index) {
            if (detailJuz.verses?.length == null ||
                detailJuz.verses?.length == 0) {
              return Center(
                child: Text('Tidak ada data'),
              );
            }
            juz.Verses ayat = detailJuz.verses![index];
            if (index != 0) {
              if (ayat.number?.inSurah == 1) {
                controller.index++;
              }
            }

            return Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: kGreyColor.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                height: 40,
                                width: 40,
                                margin: EdgeInsets.only(right: 15),
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage(
                                      Get.isDarkMode
                                          ? 'assets/number.png'
                                          : 'assets/number.png',
                                    ),
                                  ),
                                ),
                                child: Center(
                                  child: Text('${ayat.number?.inSurah}'),
                                ),
                              ),
                              Text(
                                  '${allSurahThisJuz[controller.index].name?.transliteration?.id ?? ''}')
                            ],
                          ),
                          // CircleAvatar(
                          //   backgroundColor: kInactiveColor,
                          //   child: Text(
                          //     '${index + 1}',
                          //     style: whiteTextStyle.copyWith(
                          //       fontWeight: semiBold,
                          //     ),
                          //   ),
                          // ),
                          Row(
                            children: [
                              IconButton(
                                  onPressed: () {},
                                  icon: const Icon(
                                    Icons.bookmark_add_outlined,
                                  )),
                              IconButton(
                                  onPressed: () {},
                                  icon: const Icon(
                                    Icons.play_arrow,
                                  ))
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Text(
                      '${ayat.text?.arab}',
                      style: defaultTextStyle.copyWith(
                        fontWeight: semiBold,
                        fontSize: 22,
                      ),
                      textAlign: TextAlign.end,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    '${ayat.translation?.en}',
                    style: defaultTextStyle.copyWith(
                      fontWeight: light,
                      fontSize: 14,
                    ),
                    textAlign: TextAlign.end,
                  ),
                  const SizedBox(height: 20),
                  Text(
                    '${ayat.translation?.id}',
                    style: defaultTextStyle.copyWith(
                      fontWeight: medium,
                      fontSize: 16,
                    ),
                    textAlign: TextAlign.justify,
                  ),
                  const SizedBox(height: 30)
                ],
              ),
            );
          },
        ));
  }
}
