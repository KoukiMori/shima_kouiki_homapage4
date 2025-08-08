import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
    _slideAnimation =
        Tween<double>(
          begin: -400.0, // 画面外左端から開始
          end: -120.0, // 元の位置へ
        ).animate(
          CurvedAnimation(
            parent: _animationController,
            curve: Curves.easeOutCubic, // スムーズに減速
          ),
        );

    // テキスト：上から下へ
    _textSlideAnimation =
        Tween<double>(
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
      margin: EdgeInsets.only(top: 80),
      width: 1000, // 全体の幅を調整
      height: 900, // 全体の高さを調整
      child: Stack(
        children: [
          // テキスト（上から下へのアニメーション）
          AnimatedBuilder(
            animation: _textSlideAnimation,
            builder: (context, child) {
              return Positioned(
                right: 40,
                child: Container(
                  margin: EdgeInsets.only(top: _textSlideAnimation.value),
                  width: 500,
                  height: 500,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 50,
                    vertical: 20,
                  ),
                  decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 232, 235, 243),
                  ),
                  child: Align(
                    alignment: AlignmentGeometry.topRight,
                    child: Column(
                      spacing: 8,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          '1977年',
                          style: GoogleFonts.zenAntique(
                            fontSize: 65,
                            fontWeight: FontWeight.w300,
                            height: 1.1,
                            decoration: TextDecoration.none,
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          '志摩の介護',
                          style: GoogleFonts.zenAntique(
                            fontSize: 41,
                            fontWeight: FontWeight.w300,
                            height: 1.2,
                            decoration: TextDecoration.none,
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          'ここから\n始まりました。',
                          style: GoogleFonts.zenAntique(
                            fontSize: 30,
                            fontWeight: FontWeight.w500,
                            height: 1.4,
                            color: Colors.black,
                            decoration: TextDecoration.none,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          '私たちは、\n志摩市で最初に設立された\n介護施設として、\n地域の皆さまと歩んできました。\n長年の経験と実績をもとに、\nこれからも安心とぬくもりの\n介護を提供してまいります。',
                          style: GoogleFonts.zenAntique(
                            fontSize: 13,
                            color: Colors.black87,
                            height: 1.7,
                            fontWeight: FontWeight.w500,
                            decoration: TextDecoration.none,
                          ),
                        ),
                      ],
                    ),
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
