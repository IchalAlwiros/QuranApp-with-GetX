import 'package:flutter/material.dart';
import 'package:flutter_quran_app/app/routes/app_pages.dart';
import 'package:flutter_quran_app/app/theme/theme.dart';
import 'package:flutter_quran_app/app/widgets/shimmer_loading.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';

import '../../../data/models/surah_models.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    if (Get.isDarkMode) {
      controller.isDark.value = true;
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: kBackgroundColor,
        title: Text(
          'Quran Apps',
          style: defaultTextStyle.copyWith(
            fontWeight: bold,
            fontSize: 18,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Get.toNamed(Routes.SEARCH);
            },
            icon: const Icon(
              Icons.search,
            ),
          )
        ],
        centerTitle: true,
      ),
      body: DefaultTabController(
        length: 3,
        child: Padding(
          padding: const EdgeInsets.only(
            top: 20,
            right: 20,
            left: 20,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Assalamualaikum',
                style: defaultTextStyle.copyWith(
                  fontSize: 20,
                  fontWeight: semiBold,
                ),
              ),
              Text(
                "Selamat datang",
                style: defaultTextStyle,
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 20),
                height: 150,
                width: Get.width,
                decoration: BoxDecoration(
                  color: kBackgroundColor,
                  borderRadius: BorderRadius.circular(20),
                  gradient: LinearGradient(
                    colors: [
                      kBackgroundColor,
                      kInactiveColor,
                    ],
                  ),
                ),
                child: Material(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () {
                      Get.toNamed(Routes.LAST_READ);
                    },
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                      child: Stack(
                        children: [
                          Positioned(
                            bottom: -40,
                            right: 0,
                            child: Container(
                              width: 150,
                              height: 150,
                              child: SvgPicture.asset(
                                "assets/Quran.svg",
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      Icons.book,
                                      color: kWhiteColor,
                                    ),
                                    const SizedBox(width: 10),
                                    Text(
                                      'Terakhir dibaca',
                                      style: defaultTextStyle.copyWith(
                                        color: kWhiteColor,
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(height: 20),
                                Text(
                                  'Al-Fatihah',
                                  style: defaultTextStyle.copyWith(
                                    color: kWhiteColor,
                                  ),
                                ),
                                Text(
                                  'Ayat 7',
                                  style: defaultTextStyle.copyWith(
                                    color: kWhiteColor,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              TabBar(
                tabs: [
                  Tab(
                    child: Text(
                      'Surah',
                      style: defaultTextStyle.copyWith(
                        // color: kPrimaryColor,
                        fontWeight: semiBold,
                      ),
                    ),
                  ),
                  Tab(
                    child: Text(
                      'Juz',
                      style: defaultTextStyle.copyWith(
                        // color: kPrimaryColor,
                        fontWeight: semiBold,
                      ),
                    ),
                  ),
                  Tab(
                    child: Text(
                      'Tab 1',
                      style: defaultTextStyle.copyWith(
                        // color: kPrimaryColor,
                        fontWeight: semiBold,
                      ),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: TabBarView(children: [
                  //SURAH
                  FutureBuilder<List<Surah>>(
                    future: controller.getAllSurah(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return ListView.separated(
                            itemBuilder: (context, index) => ShimmerSkelton(),
                            separatorBuilder: (context, index) =>
                                const SizedBox(
                                  height: 10,
                                ),
                            itemCount: 8);
                      }

                      if (!snapshot.hasData) {
                        return Text('Tidak Ada data');
                      }
                      return ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          Surah surah = snapshot.data![index];
                          return ListTile(
                            onTap: () {
                              Get.toNamed(Routes.DETAIL_SURAH,
                                  arguments: surah);
                            },
                            leading: Obx(() => Container(
                                  height: 50,
                                  width: 50,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage(controller.isDark.isTrue
                                          ? 'assets/number.png'
                                          : 'assets/number_dark.png'),
                                    ),
                                  ),
                                  child: Center(
                                    child: Text('${surah.number}'),
                                  ),
                                )),

                            // CircleAvatar(
                            //   backgroundColor: kInactiveColor,
                            //   child: Text(
                            //     "${surah.number}",
                            //     style: whiteTextStyle.copyWith(
                            //       fontWeight: bold,
                            //     ),
                            //   ),
                            // ),
                            title: Text(
                              '${surah.name?.translation?.id ?? " Error ... "}',
                              // style: defaultTextStyle.copyWith(
                              //   fontSize: 16,
                              //   fontWeight: semiBold,
                              //   color:
                              //       Get.isDarkMode ? kWhiteColor : kBlackColor,
                              // ),
                            ),
                            subtitle: Text(
                              "${surah.numberOfVerses} Ayat | ${surah.revelation?.id ?? "Error..."} ",
                              style: defaultTextStyle.copyWith(
                                  fontWeight: medium, color: kGreyColor),
                            ),
                            trailing: Text(
                              "${surah.name?.short ?? "Error..."}",
                              // style: blackTextStyle.copyWith(
                              //   fontWeight: medium,
                              //   color:
                              //       Get.isDarkMode ? kWhiteColor : kBlackColor,
                              // ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                  // JUZ
                  ListView.builder(
                      itemCount: 30,
                      itemBuilder: (context, index) {
                        return ListTile(
                          leading: Obx(() => Container(
                                height: 50,
                                width: 50,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage(controller.isDark.isTrue
                                        ? 'assets/number.png'
                                        : 'assets/number_dark.png'),
                                  ),
                                ),
                                child: Center(
                                  child: Text('${index + 1}'),
                                ),
                              )),

                          // Container(
                          //   height: 50,
                          //   width: 50,
                          //   decoration: BoxDecoration(
                          //       image: DecorationImage(
                          //           image: AssetImage('assets/number.png'))),
                          //   child: Center(
                          //     child: Text('${index + 1}'),
                          //   ),
                          // ),

                          // CircleAvatar(
                          //   backgroundColor: kInactiveColor,
                          //   child: Text(
                          //     "${surah.number}",
                          //     style: whiteTextStyle.copyWith(
                          //       fontWeight: bold,
                          //     ),
                          //   ),
                          // ),
                          title: Text(
                            'Juz  -  ${index + 1}',
                            style: blackTextStyle.copyWith(
                              fontSize: 16,
                              fontWeight: semiBold,
                            ),
                          ),
                        );
                      }),
                  Text('data3'),
                ]),
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          controller.isDark.toggle();
          // Get.isDarkMode
          //     ? Get.changeTheme(themeLight)
          //     : Get.changeTheme(themeDark);
          // Get.changeTheme(
          //   Get.isDarkMode ? ThemeData.light() : ThemeData.dark(),
          // );
        },
        child: Icon(
          Icons.color_lens,
          color: Get.isDarkMode ? kBlackColor : kWhiteColor,
        ),
      ),
      // FutureBuilder<List<Surah>>(
      //   future: controller.getAllSurah(),
      //   builder: (context, snapshot) {
      //     if (snapshot.connectionState == ConnectionState.waiting) {
      //       return ListView.separated(
      //           itemBuilder: (context, index) => ShimmerSkelton(),
      //           separatorBuilder: (context, index) => const SizedBox(
      //                 height: 10,
      //               ),
      //           itemCount: 8);
      //     }

      //     if (!snapshot.hasData) {
      //       return Text('Tidak Ada data');
      //     }
      //     return ListView.builder(
      //       itemCount: snapshot.data!.length,
      //       itemBuilder: (context, index) {
      //         Surah surah = snapshot.data![index];
      //         return ListTile(
      //           onTap: () {
      //             Get.toNamed(Routes.DETAIL_SURAH, arguments: surah);
      //           },
      //           leading: CircleAvatar(
      //             backgroundColor: kInactiveColor,
      //             child: Text(
      //               "${surah.number}",
      //               style: whiteTextStyle.copyWith(
      //                 fontWeight: bold,
      //               ),
      //             ),
      //           ),
      //           title: Text(
      //             '${surah.name?.translation?.id ?? " Error ... "}',
      //             style: blackTextStyle.copyWith(
      //               fontSize: 16,
      //               fontWeight: semiBold,
      //             ),
      //           ),
      //           subtitle: Text(
      //             "${surah.numberOfVerses} Ayat | ${surah.revelation?.id ?? "Error..."} ",
      //             style: blackTextStyle.copyWith(
      //               fontWeight: medium,
      //             ),
      //           ),
      //           trailing: Text(
      //             "${surah.name?.short ?? "Error..."}",
      //             style: blackTextStyle.copyWith(
      //               fontWeight: medium,
      //             ),
      //           ),
      //         );
      //       },
      //     );
      //   },
      // ),
    );
  }
}
