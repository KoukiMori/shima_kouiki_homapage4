// min などの数学関数は dart:math を使う（プラットフォーム非対応な内部ライブラリは使わない）
import 'dart:math' as math;

import 'package:flutter/material.dart';
// Google Fonts を使うためのインポート
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:shima_kouiki_homepage4/colors_setting.dart';
import 'package:shima_kouiki_homepage4/home_view/car_chair_animation.dart';
import 'package:shima_kouiki_homepage4/topic.dart';

part 'home_view.widgets.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});
  // 施設紹介セクションへのスクロール用キー（UIは変えず、機能のみ追加）
  static final GlobalKey _facilitiesKey = GlobalKey();
  static final GlobalKey _topViewKey = GlobalKey();
  // OverlayTextSection（1977年テキスト開始位置）へのスクロール用キー
  static final GlobalKey _overlayKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: MainColors.bgColor,
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
                  // 背景画像をアセットから表示（Webの相対パス問題を避けるため Image.asset を使用）
                  return Image.asset(
                    key: HomeView._topViewKey,
                    'assets/tomoyama_bay.jpg', // 実在ファイルは .jpg（.png ではない）
                    height: screenSize.height -
                        (screenSize.height * .2 * offScreenPercentage),
                    width: screenSize.width -
                        (screenSize.width * .2 * offScreenPercentage),
                    fit: BoxFit.cover,
                    // 読み込み失敗時にプレースホルダーで崩れを防ぐ
                    errorBuilder: (context, error, stack) => Container(
                      height: screenSize.height -
                          (screenSize.height * .2 * offScreenPercentage),
                      width: screenSize.width -
                          (screenSize.width * .5 * offScreenPercentage),
                      color: const Color(0xFFCCE4F7),
                    ),
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
                  return OverlayTextSection(key: HomeView._overlayKey);
                },
                offsetBuilder: (scrollOffset) => Offset(0, -screenSize.height),
              ),
              ScrollTransformItem(
                builder: (scrollOffset) => TopicSection(),
              ),
              ScrollTransformItem(
                builder: (scrollOffset) =>
                    FacilitiesSection(key: HomeView._facilitiesKey),
              ),
            ],
          ),
          Positioned(
            left: 30,
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
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      // 背景と重なるため、読みやすさ向上のためのシャドー
                      shadows: [
                        Shadow(
                          color: Colors.black,
                          offset: const Offset(0, 2),
                          blurRadius: 3,
                        ),
                      ],
                    ),
                  ),
                  Row(
                    spacing: 10,
                    children: [
                      GestureDetector(
                        onTap: () async {
                          // Topボタンで 1977年テキスト（OverlayTextSection）へスクロール
                          final contextToScroll =
                              HomeView._overlayKey.currentContext;
                          if (contextToScroll != null) {
                            await Scrollable.ensureVisible(
                              contextToScroll,
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.easeInOut,
                              alignment: 0.05, // 画面上部から少し余白
                            );
                          }
                        },
                        child: Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          decoration: BoxDecoration(
                            border: BoxBorder.all(
                                color: MainColors.secondaryColor, width: 1),
                          ),
                          child: Text(
                            'Top',
                            style: GoogleFonts.notoSansJp(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              shadows: [
                                Shadow(
                                  color: Colors.black,
                                  offset: const Offset(0, 2),
                                  blurRadius: 3,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () async {
                          // 施設紹介ボタンで FacilitiesSection にスクロール
                          final contextToScroll =
                              HomeView._facilitiesKey.currentContext;
                          if (contextToScroll != null) {
                            await Scrollable.ensureVisible(
                              contextToScroll,
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.easeInOut,
                              // alignment: 0.05, // 画面上部から少し余白
                            );
                          }
                        },
                        child: Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          decoration: BoxDecoration(
                            border: BoxBorder.all(
                                color: MainColors.secondaryColor, width: 1),
                          ),
                          child: Text(
                            '施設紹介',
                            style: GoogleFonts.notoSansJp(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              shadows: [
                                Shadow(
                                  color: Colors.black,
                                  offset: const Offset(0, 2),
                                  blurRadius: 3,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          decoration: BoxDecoration(
                            border: BoxBorder.all(
                                color: MainColors.secondaryColor, width: 1),
                          ),
                          child: Text(
                            '入所の流れ',
                            style: GoogleFonts.notoSansJp(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              shadows: [
                                Shadow(
                                  color: Colors.black,
                                  offset: const Offset(0, 2),
                                  blurRadius: 3,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          decoration: BoxDecoration(
                            border: BoxBorder.all(
                                color: MainColors.secondaryColor, width: 1),
                          ),
                          child: Text(
                            'その他',
                            style: GoogleFonts.notoSansJp(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              shadows: [
                                Shadow(
                                  color: Colors.black,
                                  offset: const Offset(0, 2),
                                  blurRadius: 3,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          decoration: BoxDecoration(
                              color: MainColors.accentColor,
                              border: Border.all(
                                  width: 1, color: MainColors.secondaryColor)),
                          child: Text(
                            '求人の方はこちら',
                            style: GoogleFonts.notoSansJp(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
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
