library eazy_onboarding;

import 'package:animate_ease/animate_ease_type.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:snappy_onboard/snappy_onboard_data_builder.dart';
import 'package:snappy_onboard/snappy_onboarding_controls.dart';
import 'package:snappy_onboard/snappy_onboarding_item_model.dart';
export 'package:animate_ease/animate_ease_type.dart';
export 'package:snappy_onboard/snappy_onboarding_item_model.dart';

class SnappyOnboard extends StatefulWidget {
  final Color backgroundColor;
  final AnimateEaseType animations;
  final AnimateEaseType controlsAnimations;
  final Duration animationDuration;
  final String skipText;
  final String getStartedText;
  final Color controlsTextColor;
  final IconData backArrow;
  final IconData forwardArrow;
  final void Function()? onCompleted;
  final List<SnappyOnboardingItemModel>? items;
  final Color? imagePreloadIndicatorColors;
  final Color? titleTextColor;
  final Color? subTitleTextColor;
  final Color? bodyTextColor;

  final bool? isVisibleChek;
  final double imageBoxHeight;
  final double imageBoxWidth;
  final Color imageBoxBackgroundColor;
  final Color imageBoxBorderColor;
  final BorderStyle imageBoxBorderStyle;
  final double imageBoxBorderWidth;
  final double boxBorderRadius;

  const SnappyOnboard({
    super.key,
    this.backgroundColor = Colors.white70,
    this.animations = AnimateEaseType.slideInLeftFade,
    this.controlsAnimations = AnimateEaseType.bounceIn,
    this.animationDuration = const Duration(seconds: 1),
    this.skipText = "Skip",
    this.getStartedText = "Get Started",
    this.controlsTextColor = Colors.black,
    this.backArrow = Icons.arrow_back,
    this.forwardArrow = Icons.arrow_forward,
    this.onCompleted,
    this.items = const [],
    this.imagePreloadIndicatorColors,
    this.titleTextColor = Colors.black,
    this.subTitleTextColor = Colors.black12,
    this.bodyTextColor = Colors.black54,
    this.isVisibleChek = false,
    this.imageBoxHeight = 400.0,
    this.imageBoxWidth = 400.0,
    this.imageBoxBackgroundColor = Colors.white70,
    this.imageBoxBorderColor = Colors.white38,
    this.imageBoxBorderStyle = BorderStyle.solid,
    this.imageBoxBorderWidth = 1.0,
    this.boxBorderRadius = 10.0,
  });
  @override
  SnappyOnboardState createState() => SnappyOnboardState();
}

class SnappyOnboardState extends State<SnappyOnboard> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onPageChanged(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  void _onSkip() {
    _pageController.jumpToPage(widget.items!.length - 1);
  }

  void _onNext() {
    if (_currentIndex < widget.items!.length - 1) {
      _pageController.nextPage(
          duration: const Duration(milliseconds: 300), curve: Curves.easeIn);
    }
  }

  void _onPrev() {
    if (_currentIndex > 0) {
      _pageController.previousPage(
          duration: const Duration(milliseconds: 300), curve: Curves.easeIn);
    }
  }

  @override
  Widget build(BuildContext context) {
    // Determine the brightness of the current theme
    final isDarkTheme = Theme.of(context).brightness == Brightness.dark;
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: isDarkTheme ? Brightness.light : Brightness.dark,
    ));

    return Scaffold(
      backgroundColor: widget.backgroundColor,
      body: Container(
        height: MediaQuery.of(context).size.height,
        alignment: Alignment.center,
        padding: const EdgeInsets.only(left: 25, right: 25),
        child: Stack(
          children: [
            // slide images and texts
            Container(
              padding: const EdgeInsets.only(),
              child: SnappyOnboardDataBuilder(
                pageController: _pageController,
                onPageChanged: _onPageChanged,
                backgroundColor: widget.backgroundColor,
                items: widget.items,
                imagePreloadIndicatorColors: widget.imagePreloadIndicatorColors,
                textTitleColor: widget.titleTextColor,
                textSubTitleColor: widget.subTitleTextColor,
                textBodyColor: widget.bodyTextColor,
                isVisibleChek: widget.isVisibleChek,
                imageBoxHeight: widget.imageBoxHeight,
                imageBoxWidth: widget.imageBoxWidth,
                imageBoxBackgroundColor: widget.imageBoxBackgroundColor,
                imageBoxBorderColor: widget.imageBoxBorderColor,
                imageBoxBorderStyle: widget.imageBoxBorderStyle,
                imageBoxBorderWidth: widget.imageBoxBorderWidth,
                imageHeight: widget.imageBoxHeight/2.0,
                imageWidth: widget.imageBoxWidth,
                boxBorderRadius: widget.boxBorderRadius,
              ),
            ),
            // the controls
            Positioned(
              bottom: 30,
              left: 16,
              right: 16,
              child: Container(
                height: 100,
                alignment: Alignment.bottomCenter,
                padding: const EdgeInsets.only(),
                child: SnappyOnboardingControls(
                  items: widget.items,
                  animations: widget.controlsAnimations,
                  animationDuration: widget.animationDuration,
                  backArrow: widget.backArrow,
                  forwardArrow: widget.forwardArrow,
                  controlsTextColor: widget.controlsTextColor,
                  getStartedText: widget.getStartedText,
                  skipText: widget.skipText,
                  currentIndex: _currentIndex,
                  onCompleted: widget.onCompleted,
                  onNext: _onNext,
                  onPrev: _onPrev,
                  onSkip: _onSkip,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
