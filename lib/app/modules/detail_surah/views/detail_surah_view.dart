import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter_quran_app/app/data/models/detailsurah_models.dart'
    as detail;
import 'package:flutter_quran_app/app/data/models/surah_models.dart';
import 'package:flutter_quran_app/app/theme/theme.dart';
import 'package:flutter_quran_app/app/widgets/shimmer_loading.dart';

import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../controllers/detail_surah_controller.dart';

class DetailSurahView extends GetView<DetailSurahController> {
  Surah surah = Get.arguments;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kBackgroundColor,
        title: Text(
          'Surah ${surah.name!.transliteration!.id!.toUpperCase()}',
          style: whiteTextStyle.copyWith(
            fontWeight: semiBold,
          ),
        ),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          InkWell(
            onTap: (() {
              Get.dialog(Dialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Get.isDarkMode ? kBackgroundColor : kWhiteColor,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    children: [
                      Text(
                        "Tafsir ${surah.name?.translation!.id!.toLowerCase() ?? "error"}",
                        style: defaultTextStyle.copyWith(
                          color: kWhiteColor,
                          fontWeight: bold,
                        ),
                      ),
                      Text(
                        "${surah.tafsir?.id ?? "Tidak ada tafsir"}",
                        textAlign: TextAlign.justify,
                        style: defaultTextStyle.copyWith(
                          color: kWhiteColor,
                          fontWeight: light,
                        ),
                      ),
                    ],
                  ),
                ),
              ));
              // Get.defaultDialog(
              //     backgroundColor:
              //         Get.isDarkMode ? kBackgroundColor : kWhiteColor ,
              //     title:
              //         "Tafsir ${surah.name?.translation!.id!.toLowerCase() ?? "error"}",
              //     titleStyle: defaultTextStyle
              //         .copyWith(
              //           color: kWhiteColor,
              //         )
              //         .copyWith(
              //           fontWeight: bold,
              //         ),
              //     contentPadding: const EdgeInsets.symmetric(
              //       horizontal: 20,
              //       vertical: 10,
              //     ),
              //     content: Container(
              //       child: Text(
              //         "${surah.tafsir?.id ?? "Tidak ada tafsir"}",
              //         textAlign: TextAlign.center,
              //         style: defaultTextStyle
              //             .copyWith(
              //               color: kWhiteColor,
              //             )
              //             .copyWith(
              //               fontWeight: light,
              //             ),
              //       ),
              //     ));
            }),
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  gradient: LinearGradient(
                    colors: [
                      kBackgroundColor,
                      kInactiveColor,
                    ],
                  )),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    Text(
                      '${surah.name?.transliteration!.id!.toUpperCase() ?? 'error'}',
                      style: defaultTextStyle.copyWith(
                        color: kWhiteColor,
                        fontWeight: bold,
                        fontSize: 18,
                      ),
                    ),
                    Text(
                      '${surah.name?.translation!.id!.toUpperCase() ?? 'error'}',
                      style: defaultTextStyle.copyWith(
                        color: kWhiteColor,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      '${surah.numberOfVerses ?? 'error'} ayat | ${surah}',
                      style: defaultTextStyle.copyWith(
                        color: kWhiteColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          FutureBuilder<detail.DetailSurah>(
            future: controller.getDetailSurah(surah.number.toString()),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: LoadingAnimationWidget.staggeredDotsWave(
                    color: kPurpleLightColor,
                    size: 40.0,
                  ),
                );
              }
              if (!snapshot.hasData) {
                return Center(
                  child: Text('Tidak ada Data', style: defaultTextStyle),
                );
              }
              // print(snapshot.data);
              return ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: snapshot.data?.verses?.length ?? 0,
                  itemBuilder: (context, index) {
                    if (snapshot.data?.verses?.length == 0) {
                      return const SizedBox();
                    }
                    detail.Verse? ayat = snapshot.data?.verses?[index];
                    return Column(
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
                                Container(
                                  height: 40,
                                  width: 40,
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
                                    child: Text('${index + 1}'),
                                  ),
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
                        Text(
                          '${ayat!.text?.arab}',
                          style: defaultTextStyle.copyWith(
                            fontWeight: semiBold,
                            fontSize: 22,
                          ),
                          textAlign: TextAlign.end,
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
                    );
                  });
            },
          )
        ],
      ),
    );
  }
}
