import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shima_kouiki_homepage4/colors_setting.dart';

class CarChairAnimation extends StatefulWidget {
  final VoidCallback? onAnimationTrigger;
  const CarChairAnimation({super.key, this.onAnimationTrigger});

  @override
  State<CarChairAnimation> createState() => _CarChairAnimationState();
}

class _CarChairAnimationState extends State<CarChairAnimation>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _slideAnimation;
  late Animation<double> _textSlideAnimation; // テキスト用アニメーション

  @override
  void initState() {
    super.initState();

    // アニメーションコントローラーを初期化
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );

    // 左から右へのスライドアニメーション
    _slideAnimation = Tween<double>(
      begin: -200.0, // 画面外左端から開始
      end: -120.0, // 元の位置へ
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeOutCubic, // スムーズに減速
      ),
    );

    // テキスト：上から下へ
    _textSlideAnimation = Tween<double>(
      begin: 200.0, // 上から開始
      end: 60.0, // 元の位置へ
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeOutCubic,
      ),
    );

    // 初回ロード時（リロード含む）にアニメーション開始
    startAnimation();
  }

  // アニメーションを開始するメソッド
  void startAnimation() {
    _animationController.reset(); // リセット
    _animationController.forward(); // 開始
  }

  @override
  void didUpdateWidget(CarChairAnimation oldWidget) {
    super.didUpdateWidget(oldWidget);
    // ウィジェットが更新された時（トップページボタン押下時）にアニメーション実行
    startAnimation();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Container(
      margin: EdgeInsets.only(top: 120),
      width: width, // 全体の幅を調整
      height: 900, // 全体の高さを調整
      child: Stack(
        children: [
          // テキスト（上から下へのアニメーション）
          AnimatedBuilder(
            animation: _textSlideAnimation,
            builder: (context, child) {
              return Positioned(
                right: width * .08,
                left: width * .08,
                child: Container(
                  margin: EdgeInsets.only(top: _textSlideAnimation.value),
                  width: 2200,
                  height: 500,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 50,
                    vertical: 20,
                  ),
                  decoration: BoxDecoration(
                    color: MainColors.secondaryColor,
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        '施設のご案内',
                        style: GoogleFonts.notoSerifJp(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Column(
                        spacing: 8,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.transparent,
                              elevation: 0,
                              padding: EdgeInsets.all(20),
                            ),
                            child: Text(
                              '特別養護老人ホーム  才庭寮',
                              style: GoogleFonts.notoSansJavanese(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                decoration: TextDecoration.none,
                                color: MainColors.textColor,
                              ),
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.transparent,
                              elevation: 0,
                              padding: EdgeInsets.all(20),
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadiusGeometry.circular(0)),
                            ),
                            child: Text(
                              '特別養護老人ホーム  ともやま苑',
                              style: GoogleFonts.notoSansJavanese(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                decoration: TextDecoration.none,
                                color: MainColors.textColor,
                              ),
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.transparent,
                              elevation: 0,
                              padding: EdgeInsets.all(20),
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadiusGeometry.circular(0)),
                            ),
                            child: Text(
                              '特別養護老人ホーム  花園寮',
                              style: GoogleFonts.notoSansJavanese(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                decoration: TextDecoration.none,
                                color: MainColors.textColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
          // 車椅子画像（左から右へのアニメーション）
          AnimatedBuilder(
            animation: _slideAnimation,
            builder: (context, child) {
              return Positioned(
                top: width > 1240 ? 100 : 200,
                left: _slideAnimation.value, // アニメーションで左位置が変化
                child: Image.asset(
                  'assets/car_chair.png',
                  scale: width > 1240 ? 1.2 : 1.8,
                  fit: BoxFit.cover,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
