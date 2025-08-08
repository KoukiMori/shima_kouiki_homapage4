part of 'home_view.dart';

class BottomSection extends StatelessWidget {
  const BottomSection({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Container(
      height: screenSize.height,
      width: screenSize.width,
      color: const Color(0xffB10D31),
      child: Stack(
        children: [
          Positioned.fill(
            top: -50,
            child: Center(
              child: Text(
                'I AM FILLEDSTACKS.\nA CREATOR OF THINGS.\nSOMETIMES I GO EXPLORE\nAND MAKE THINGS\nTHAT I FIND INTERESTING',
                textAlign: TextAlign.center,
                style: GoogleFonts.biryani(
                  color: Colors.white,
                  fontSize: 80,
                  fontWeight: FontWeight.w800,
                  height: 1.2,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class OverlayTextSection extends StatelessWidget {
  const OverlayTextSection({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return SizedBox(
      height: screenSize.height,
      width: screenSize.width,
      child: Stack(
        children: [
          _TitleText(text: '1977年', top: 180, left: 100, fontsSize: 160),
          _TitleText(text: '志摩の介護', top: 400, left: 100, fontsSize: 70),
          _TitleText(text: 'ここから', top: 500, left: 100, fontsSize: 60),
          _TitleText(text: '始まりました', top: 580, left: 100, fontsSize: 60),
          Positioned(
            right: 20,
            top: 410,
            child: SizedBox(
              width: 470,
              child: Text(
                overlayDescriptionText,
                style: GoogleFonts.notoSerifJp(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _TitleText extends StatelessWidget {
  final double? top;
  final double? left;
  final String text;
  final double fontsSize;
  const _TitleText({
    required this.text,
    this.top,
    this.left,
    required this.fontsSize,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: top,
      left: left,
      child: Text(
        text,
        style: GoogleFonts.notoSerifJp(
          fontSize: fontsSize,
          fontWeight: FontWeight.w900,
          color: Colors.white,
        ),
      ),
    );
  }
}
