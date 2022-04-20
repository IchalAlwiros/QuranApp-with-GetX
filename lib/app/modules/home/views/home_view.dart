import 'package:flutter/material.dart';
import 'package:flutter_quran_app/app/routes/app_pages.dart';
import 'package:flutter_quran_app/app/theme/theme.dart';
import 'package:flutter_quran_app/app/widgets/shimmer_loading.dart';

import 'package:get/get.dart';

import '../../../data/models/surah_models.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kBackgroundColor,
        title: Text(
          'Quran Apps',
          style: whiteTextStyle.copyWith(
            fontWeight: bold,
            fontSize: 18,
          ),
        ),
        centerTitle: true,
      ),
      body: FutureBuilder<List<Surah>>(
        future: controller.getAllSurah(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return ListView.separated(
                itemBuilder: (context, index) => ShimmerSkelton(),
                separatorBuilder: (context, index) => const SizedBox(
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
                  Get.toNamed(Routes.DETAIL_SURAH, arguments: surah);
                },
                leading: CircleAvatar(
                  backgroundColor: kInactiveColor,
                  child: Text(
                    "${surah.number}",
                    style: whiteTextStyle.copyWith(
                      fontWeight: bold,
                    ),
                  ),
                ),
                title: Text(
                  '${surah.name?.translation?.id ?? " Error ... "}',
                  style: blackTextStyle.copyWith(
                    fontSize: 16,
                    fontWeight: semiBold,
                  ),
                ),
                subtitle: Text(
                  "${surah.numberOfVerses} Ayat | ${surah.revelation?.id ?? "Error..."} ",
                  style: blackTextStyle.copyWith(
                    fontWeight: medium,
                  ),
                ),
                trailing: Text(
                  "${surah.name?.short ?? "Error..."}",
                  style: blackTextStyle.copyWith(
                    fontWeight: medium,
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
