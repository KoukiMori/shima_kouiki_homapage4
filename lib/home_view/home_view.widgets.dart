part of 'home_view.dart';

class FacilitiesSection extends StatelessWidget {
  const FacilitiesSection({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Container(
      height: screenSize.height,
      width: screenSize.width,
      color: MainColors.bgColor,
      child: Stack(
        children: [
          Positioned.fill(
            top: -50,
            child: Center(child: CarChairAnimation()),
          ),
        ],
      ),
    );
  }
}

class TopicSection extends StatelessWidget {
  const TopicSection({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Container(
      height: screenSize.height * 0.6,
      width: screenSize.width,
      color: MainColors.bgColor,
      child: Stack(
        children: [
          Positioned.fill(
            child: Padding(
              padding: EdgeInsets.symmetric(
                  vertical: 30.0, horizontal: screenSize.width * .2),
              child: Stack(
                children: [
                  Container(
                    width: screenSize.width * 2, // 幅を画面幅の80%に設定
                    height: 500,
                    padding: const EdgeInsets.only(
                        top: 50, left: 20, right: 20, bottom: 20),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: MainColors.accentColor,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: topics.map((topic) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  '${topic.date}  ',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                    decoration: TextDecoration.none,
                                    color: MainColors.textColor,
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    topic.content,
                                    style: TextStyle(
                                      fontSize: 18,
                                      decoration: TextDecoration.none,
                                      color: MainColors.textColor,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 0,
                    left: 0,
                    child: Container(
                      width: 120,
                      height: 40,
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20),
                        ),
                        color: MainColors.accentColor,
                      ),
                      padding: const EdgeInsets.only(left: 20, top: 4),
                      child: const Text(
                        'お知らせ',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          decoration: TextDecoration.none,
                        ),
                      ),
                    ),
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

class OverlayTextSection extends StatefulWidget {
  const OverlayTextSection({super.key});

  @override
  State<OverlayTextSection> createState() => _OverlayTextSectionState();
}

class _OverlayTextSectionState extends State<OverlayTextSection> {
  double _opacity = 0.0; // フェードイン用の透明度（0.0 = 透明, 1.0 = 不透明）

  @override
  void initState() {
    super.initState();
    // 初回表示時にゆっくりフェードインさせる
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      setState(() => _opacity = 1.0);
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return AnimatedOpacity(
      opacity: _opacity,
      duration: const Duration(milliseconds: 1200), // ゆっくり表示
      curve: Curves.easeOut,
      child: Container(
        margin: EdgeInsets.only(left: screenSize.width * .06),
        height: screenSize.height,
        width: screenSize.width,
        child: Stack(
          children: [
            // 「1977」の後ろにくる「年」だけ少し小さく表示する
            _TitleText(
              text: '1977',
              smallText: '年',
              top: 180,
              fontsSize: 160,
              smallTextOffsetY: null, // 必要なら微調整値をここで指定
            ),
            _TitleText(text: '志摩の介護', top: 400, fontsSize: 70),
            _TitleText(text: 'ここから', top: 500, fontsSize: 60),
            _TitleText(text: '始まりました', top: 580, fontsSize: 60),
            Positioned(
              right: screenSize.width * .08,
              top: 365,
              child: Container(
                width: 460,
                height: 400,
                decoration: BoxDecoration(
                  color: Colors.grey.withAlpha(100),
                ),
                child: Center(
                  child: Text(
                    '私たちは\n志摩市で最初に設立された\n介護施設として\n地域の皆様と歩んできました\n長年の経験と実績をもとに\nこれからも安心と温もりの\n介護を提供してまいります',
                    style: GoogleFonts.notoSerifJp(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1,
                      height: 1.5,
                      // 背景に溶け込まないよう軽いシャドー
                      shadows: [
                        Shadow(
                          color: Colors.black,
                          offset: const Offset(0, 2),
                          blurRadius: 6,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TitleText extends StatelessWidget {
  final double? top;
  final String text; // メインの文字列（例: 1977）
  final String? smallText; // 後ろに続く小さめ文字（例: 年）
  final double fontsSize;
  final double? smallTextOffsetY; // 小さい文字の縦位置微調整（下端を揃えるため）
  const _TitleText({
    required this.text,
    this.smallText,
    this.top,
    required this.fontsSize,
    this.smallTextOffsetY,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: top,
      child: smallText == null
          // 単体表示
          ? Text(
              text,
              style: GoogleFonts.notoSerifJp(
                fontSize: fontsSize,
                fontWeight: FontWeight.w900,
                color: Colors.white,
                shadows: [
                  Shadow(
                    color: Colors.black,
                    offset: const Offset(0, 2),
                    blurRadius: 6,
                  ),
                ],
              ),
            )
          // 「年」だけ小さくしつつ、下端を揃えるために縦位置を微調整
          : RichText(
              text: TextSpan(
                style: GoogleFonts.notoSerifJp(
                  fontSize: fontsSize,
                  fontWeight: FontWeight.w900,
                  color: Colors.white,
                  shadows: [
                    Shadow(
                      color: Colors.black,
                      offset: const Offset(0, 2),
                      blurRadius: 6,
                    ),
                  ],
                ),
                children: [
                  TextSpan(text: text),
                  WidgetSpan(
                    alignment: PlaceholderAlignment.baseline,
                    baseline: TextBaseline.ideographic, // 日本語のベースライン
                    child: Transform.translate(
                      // デフォルトでは小さい文字の下端が少し下に出るので上に持ち上げる
                      offset: Offset(0, smallTextOffsetY ?? -(fontsSize * 0.2)),
                      child: Text(
                        smallText!,
                        style: GoogleFonts.notoSerifJp(
                          fontSize: fontsSize * 0.7, // 少し小さく
                          fontWeight: FontWeight.w900,
                          color: Colors.white,
                          shadows: [
                            Shadow(
                              color: Colors.black,
                              offset: const Offset(0, 2),
                              blurRadius: 6,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
