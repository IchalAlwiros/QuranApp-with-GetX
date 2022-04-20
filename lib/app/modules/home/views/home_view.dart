import 'package:flutter/material.dart';
import 'package:flutter_quran_app/app/routes/app_pages.dart';

import 'package:get/get.dart';

import '../../../data/models/surah_models.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('HomeView'),
        centerTitle: true,
      ),
      body: FutureBuilder<List<Surah>>(
        future: controller.getAllSurah(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
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
                  child: Text("${surah.number}"),
                ),
                title: Text('${surah.name?.translation?.id ?? " Error ... "}'),
                subtitle: Text(
                    "${surah.numberOfVerses} Ayat | ${surah.revelation?.id ?? "Error..."} "),
                trailing: Text("${surah.name?.short ?? "Error..."}"),
              );
            },
          );
        },
      ),
    );
  }
}
