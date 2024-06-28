import 'package:animate_ease/animate_ease.dart';
import 'package:animate_ease/animate_ease_type.dart';
import 'package:flutter/material.dart';
import 'package:snappy_onboard/snappy_onboarding_item_model.dart';

class SnappyOnboardDataBuilder extends StatelessWidget {
  final PageController? pageController;
  final ValueChanged<int>? onPageChanged;
  final List<SnappyOnboardingItemModel>? items;
  final Color? backgroundColor;
  final Color? imagePreloadIndicatorColors;
  final Color? textTitleColor;
  final Color? textSubTitleColor;
  final Color? textBodyColor;
  final bool? isVisibleChek;
  final double? imageHeight;
  final double? imageWidth;
  final double? imageBoxHeight;
  final double? imageBoxWidth;
  final Color? imageBoxBorderColor;
  final BorderStyle? imageBoxBorderStyle;
  final double? imageBoxBorderWidth;
  final Color? imageBoxBackgroundColor;
  final double? boxBorderRadius;
  final BoxFit? imageFit;
  final AnimateEaseType? animations;
  final int? duration;

  const SnappyOnboardDataBuilder({
    super.key,
    this.pageController,
    this.onPageChanged,
    this.items,
    this.backgroundColor,
    this.imagePreloadIndicatorColors,
    this.textTitleColor,
    this.textSubTitleColor,
    this.textBodyColor,
    this.isVisibleChek,
    this.imageHeight,
    this.imageWidth,
    this.imageBoxWidth,
    this.imageBoxHeight,
    this.imageBoxBorderColor,
    this.imageBoxBorderStyle,
    this.imageBoxBorderWidth,
    this.imageBoxBackgroundColor,
    this.boxBorderRadius,
    this.imageFit,
    this.animations,
    this.duration,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: imageBoxHeight,
      width: imageBoxWidth,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(boxBorderRadius!) ),
        color: imageBoxBackgroundColor,
        border: Border.all(
          color: imageBoxBorderColor!,
          style: imageBoxBorderStyle!,
          width: imageBoxBorderWidth!,
        ),
      ),
      padding: const EdgeInsets.only(),
      child: PageView.builder(
        controller: pageController,
        itemCount: items!.length,
        onPageChanged: onPageChanged,
        itemBuilder: (context, index) {
          final item = items![index];
          return Padding(
            padding: const EdgeInsets.all(0.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 20),
                if (item.image!.startsWith('http'))
                  Container(
                    height: imageHeight,
                    width: imageWidth,
                    color: backgroundColor,
                    child: Image.network(
                      height: imageHeight,
                      width: imageWidth,
                      item.image!,
                      fit: imageFit,
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) {
                          return AnimateEase(
                            animate: animations!,
                            duration:  Duration(seconds: duration!),
                            child: child,
                          );
                        } else {
                          return AnimateEase(
                            duration:  Duration(seconds: duration!),
                            animate: animations!,
                            child: SizedBox(
                              height: 20.0,
                              width: 20.0,
                              child: CircularProgressIndicator(
                                color: imagePreloadIndicatorColors,
                              ),
                            ),
                          );
                        }
                      },
                      errorBuilder: (context, child, error) {
                        return AnimateEase(
                          animate: animations!,
                          duration:  Duration(seconds: duration!),
                          child: CircularProgressIndicator(
                            color: imagePreloadIndicatorColors,
                          ),
                        );
                      },
                    ),
                  )
                else
                  Container(
                    height: imageHeight,
                    width: imageWidth,
                    color: backgroundColor,
                    child: AnimateEase(
                      isVisibleChek: isVisibleChek,
                      duration:  Duration(seconds: duration!),
                      animate: animations!,
                      child: Image.asset(
                        height: imageHeight,
                        width: imageWidth,
                        item.image!,
                        fit: imageFit,
                        errorBuilder: (context, child, error) {
                          return AnimateEase(
                            duration:  Duration(seconds: duration!),
                            child: CircularProgressIndicator(
                              color: imagePreloadIndicatorColors,
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                const SizedBox(height: 30),
                AnimateEase(
                  animate: animations!,
                  duration:  Duration(seconds: duration! - 1),
                  child: Text(
                    items![index].title!,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: textTitleColor,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                AnimateEase(
                  animate: animations!,
                  duration:  Duration(seconds: duration! + 1),
                  child: Text(
                    items![index].subtitle!,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18,
                      color: textSubTitleColor,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                AnimateEase(
                  animate: animations!,
                  duration:  Duration(seconds: duration! + 2),
                  child: Text(items![index].body!,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        color: textBodyColor,
                      ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
