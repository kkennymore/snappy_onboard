library eazy_onboarding;
import 'package:animate_ease/animate_ease.dart';
import 'package:animate_ease/animate_ease_type.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:snappy_onboard/snappy_onboard_data_builder.dart';
import 'package:snappy_onboard/snappy_onboarding_item_model.dart';
export 'package:animate_ease/animate_ease_type.dart';
export 'package:snappy_onboard/snappy_onboarding_item_model.dart';

class SnappyOnboard extends StatefulWidget {
  final Color backgroundColor;
  final AnimateEaseType animations;
  final  Duration animationDuration;
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
  final String? titleText;
  final String? subTitleText;
  final String? bodyText;

  const SnappyOnboard({
    super.key, 
    this.backgroundColor = Colors.white70,
    this.animations = AnimateEaseType.slideInLeftFade,
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
    this.titleText,
    this.subTitleText,
    this.bodyText
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
        alignment: Alignment.center,
        padding: const EdgeInsets.only(left: 25, right: 25),
        child: Stack(
          children: [
            SnappyOnboardDataBuilder(
              pageController: _pageController,
              onPageChanged: _onPageChanged,
              backgroundColor: widget.backgroundColor,
              items: widget.items,
              imagePreloadIndicatorColors: widget.imagePreloadIndicatorColors,
              titleText: widget.titleText,
              subTitleText: widget.subTitleText,
              bodyText: widget.bodyText,
              textTitleColor: widget.titleTextColor,
              textSubTitleColor: widget.subTitleTextColor,
              textBodyColor: widget.bodyTextColor,
            ),
            Positioned(
              bottom: 30,
              left: 16,
              right: 16,
              child: AnimateEase(
                animate: widget.animations,
                duration: widget.animationDuration,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    if (_currentIndex != widget.items!.length - 1)
                      TextButton(
                        onPressed: _onSkip,
                        child: Text(
                          widget.skipText,
                          style: TextStyle(
                            fontSize: 14.0,
                            color: widget.controlsTextColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    Row(
                      children: List.generate(widget.items!.length, (index) {
                        return Container(
                          margin: const EdgeInsets.symmetric(horizontal: 4.0),
                          width: _currentIndex == index ? 12.0 : 8.0,
                          height: _currentIndex == index ? 12.0 : 8.0,
                          decoration: BoxDecoration(
                            color: _currentIndex == index
                                ?
                                widget.controlsTextColor
                                : Colors.grey,
                            shape: BoxShape.circle,
                          ),
                        );
                      }),
                    ),
                    if (_currentIndex == widget.items!.length - 1)
                      TextButton(
                        onPressed: widget.onCompleted,
                        child: Text(
                           widget.getStartedText,
                          style: TextStyle(
                            fontSize: 14.0,
                            color:widget.controlsTextColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )
                    else
                      Row(
                        children: [
                          IconButton(
                            onPressed: _onPrev,
                            icon: Icon(
                              widget.backArrow,
                              color: widget.controlsTextColor,
                            ),
                          ),
                          IconButton(
                            onPressed: _onNext,
                            icon: Icon(
                              widget.forwardArrow,
                              color: widget.controlsTextColor,
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
      ),
    );
  }
}

