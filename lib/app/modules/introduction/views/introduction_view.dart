import 'package:flutter/material.dart';
import 'package:flutter_quran_app/app/routes/app_pages.dart';
import 'package:flutter_quran_app/app/theme/theme.dart';

import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../controllers/introduction_controller.dart';

class IntroductionView extends GetView<IntroductionController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Alquran Apps',
              style: blackTextStyle.copyWith(
                fontWeight: semiBold,
                fontSize: 25,
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
              ),
              child: Text(
                'Bacalah dan pahamilah makna \nalquran dalam kehidupanmu',
                textAlign: TextAlign.center,
                style: blackTextStyle.copyWith(
                  fontWeight: medium,
                  fontSize: 16,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Container(
              width: 250,
              height: 250,
              child: Lottie.asset("assets/animasi_quran.json"),
            ),
            const SizedBox(height: 100),
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Material(
                child: InkWell(
                  onTap: (() {
                    Get.offAllNamed(Routes.HOME);
                  }),
                  highlightColor: kRedColor.withOpacity(0.3),
                  splashColor: kPrimaryColor.withOpacity(0.5),
                  child: Ink(
                    height: 55,
                    width: MediaQuery.of(context).size.width / 2,
                    decoration: BoxDecoration(
                      color: kBackgroundColor,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Center(
                      child: Text(
                        'Get Started',
                        style: whiteTextStyle.copyWith(
                          fontWeight: semiBold,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
