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
                      fit: BoxFit.cover,
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) {
                          return AnimateEase(
                            duration: const Duration(seconds: 2),
                            child: child,
                          );
                        } else {
                          return AnimateEase(
                            duration: const Duration(seconds: 2),
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
                          duration: const Duration(seconds: 2),
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
                      duration: const Duration(seconds: 2),
                      child: Image.asset(
                        height: imageHeight,
                        width: imageWidth,
                        item.image!,
                        fit: BoxFit.cover,
                        errorBuilder: (context, child, error) {
                          return AnimateEase(
                            duration: const Duration(seconds: 2),
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
                  animate: AnimateEaseType.translateInRight,
                  duration: const Duration(seconds: 1),
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
                  animate: AnimateEaseType.translateInRight,
                  duration: const Duration(seconds: 2),
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
                  animate: AnimateEaseType.fadeIn,
                  duration: const Duration(seconds: 4),
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
