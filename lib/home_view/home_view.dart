// min などの数学関数は dart:math を使う（プラットフォーム非対応な内部ライブラリは使わない）
import 'dart:math' as math;

import 'package:flutter/material.dart';
// Google Fonts を使うためのインポート
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_builder/responsive_builder.dart';

part 'home_view.widgets.dart';

const overlayDescriptionText =
    '私たちは\n志摩市で最初に設立された\n介護施設として\n地域の皆様と歩んできました\n長年の経験と実績をもとに\nこれかkらも安心と温もりの\n介護を提供してまいります';

class HomeView extends StatelessWidget {
  const HomeView({super.key});
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 202, 228, 251),
      body: Stack(
        children: [
          ScrollTransformView(
            children: [
              ScrollTransformItem(
                builder: (scrollOffset) {
                  // 画面外へのはみ出し率（0.0〜1.0）
                  final offScreenPercentage = math.min(
                    scrollOffset / screenSize.height,
                    1.0,
                  );
                  return Image.network(
                    height:
                        screenSize.height -
                        (screenSize.height * .2 * offScreenPercentage),
                    width:
                        screenSize.width -
                        (screenSize.width * .5 * offScreenPercentage),
                    'assets/shima_ago_bay.jpg',
                    fit: BoxFit.cover,
                  );
                },
                offsetBuilder: (scrollOffset) {
                  // 画面外へのはみ出し率（0.0〜1.0）
                  final offScreenPercentage = math.min(
                    scrollOffset / screenSize.height,
                    1.0,
                  );
                  final heightShrinkageAmount =
                      screenSize.height * .2 * offScreenPercentage;
                  final bool startMovingImage =
                      scrollOffset >= screenSize.height;
                  final double onScreenOffset =
                      scrollOffset + heightShrinkageAmount / 2;
                  return Offset(
                    0,
                    !startMovingImage
                        ? onScreenOffset
                        : onScreenOffset -
                              (scrollOffset - screenSize.height * .8),
                  );
                },
              ),

              ScrollTransformItem(
                builder: (scrollOffset) {
                  return const OverlayTextSection();
                },
                offsetBuilder: (scrollOffset) => Offset(0, -screenSize.height),
              ),
              ScrollTransformItem(
                builder: (scrollOffset) => const BottomSection(),
              ),
            ],
          ),
          Positioned(
            left: 20,
            top: 20,
            right: 20,
            child: SizedBox(
              width: screenSize.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    '志摩広域行政組合',
                    style: GoogleFonts.notoSansJp(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),

                  Row(
                    spacing: 10,
                    children: [
                      Text(
                        '施設紹介',
                        style: GoogleFonts.notoSansJp(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        '入所の流れ',
                        style: GoogleFonts.notoSansJp(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        '組合概要',
                        style: GoogleFonts.notoSansJp(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        '例規集',
                        style: GoogleFonts.notoSansJp(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        '入札情報',
                        style: GoogleFonts.notoSansJp(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        'その他',
                        style: GoogleFonts.notoSansJp(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
