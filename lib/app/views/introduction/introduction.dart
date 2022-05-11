import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:project/app/constant/color.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../routes/route.dart';

class IntroductionPage extends StatefulWidget {
  const IntroductionPage({Key? key}) : super(key: key);

  @override
  State<IntroductionPage> createState() => _IntroductionPageState();
}

class _IntroductionPageState extends State<IntroductionPage> {
  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    List<PageViewModel> pageView = [
      PageViewModel(
        title: "What is Bredify?",
        bodyWidget: const AutoSizeText(
          "Breadify adalah aplikasi marketplace yang berfokus pada penjualan Roti",
          maxLines: 2,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 17),
        ),
        image: SvgPicture.asset(
          "assets/images/intro1.svg",
          height: _size.height * 0.2,
          width: _size.width * 0.6,
        ),
      ),
      PageViewModel(
        title: "Bredify Chat",
        bodyWidget: const AutoSizeText(
          "Aplikasi ini menyediakan fitur chat sebagai media komunikasi antar pengguna",
          style: TextStyle(
            fontSize: 17,
          ),
          maxLines: 2,
          textAlign: TextAlign.center,
        ),
        image: SvgPicture.asset(
          "assets/images/intro2.svg",
          height: _size.height * 0.2,
          width: _size.width * 0.6,
        ),
      ),
      PageViewModel(
        title: "Bredify Priority",
        bodyWidget: const AutoSizeText(
          "Kenyamanan dan Keamanan pengguna adalah prioritas utama aplikasi kami",
          maxLines: 2,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 17),
        ),
        footer: ElevatedButton(
          onPressed: () async {
            final pref = await SharedPreferences.getInstance();
            pref.setBool("intro", false);
            Navigator.pushReplacementNamed(context, Routes.login);
          },
          child: const Text("Spend your money!"),
          style: ElevatedButton.styleFrom(
            padding:
                const EdgeInsets.only(left: 50, right: 50, top: 10, bottom: 10),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
          ),
        ),
        image: SvgPicture.asset(
          "assets/images/intro3.svg",
          height: _size.height * 0.2,
          width: _size.width * 0.6,
        ),
      ),
    ];
    return IntroductionScreen(
      scrollPhysics: const NeverScrollableScrollPhysics(),
      dotsDecorator: DotsDecorator(
        color: Colors.white,
        activeColor: MyColor.yellow,
        size: const Size(10, 10),
        activeSize: const Size(20, 10),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      pages: pageView,
      showSkipButton: true,
      skip: const Text(
        "Skip",
        style: TextStyle(fontSize: 16),
      ),
      next: const Text(
        "Next",
        style: TextStyle(fontSize: 16),
      ),
      done: const Text(
        "Done",
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),
      onDone: () async {
        final pref = await SharedPreferences.getInstance();
        pref.setBool("intro", false);
        Navigator.pushReplacementNamed(context, Routes.login);
      },
      showDoneButton: true,
    );
  }
}
