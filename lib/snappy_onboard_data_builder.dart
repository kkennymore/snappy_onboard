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
  final String? titleText;
  final String? subTitleText;
  final String? bodyText;

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
    this.titleText,
    this.subTitleText,
    this.bodyText,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
                    color: backgroundColor,
                    constraints: BoxConstraints(
                        minHeight: MediaQuery.of(context).size.height / 2.8,
                        minWidth: MediaQuery.of(context).size.height - 60),
                    child: Image.network(
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
                    color: backgroundColor,
                    constraints: BoxConstraints(
                      minHeight: MediaQuery.of(context).size.height / 2.8,
                    ),
                    child: AnimateEase(
                      duration: const Duration(seconds: 2),
                      child: Image.asset(
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
                    titleText.toString(),
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
                    subTitleText.toString(),
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
                  child: Text(bodyText.toString(),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        color: textBodyColor,
                      )),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
