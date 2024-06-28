import 'package:animate_ease/animate_ease.dart';
import 'package:animate_ease/animate_ease_type.dart';
import 'package:flutter/material.dart';
import 'package:snappy_onboard/snappy_onboarding_item_model.dart';

class SnappyOnboardingControls extends StatelessWidget {
  final Color? backgroundColor;
  final AnimateEaseType? animations;
  final Duration? animationDuration;
  final Color? controlsTextColor;
  final IconData? backArrow;
  final IconData? forwardArrow;
  final int? currentIndex;
  final void Function()? onSkip;
  final void Function()? onNext;
  final void Function()? onPrev;
  final void Function()? onCompleted;
  final String? getStartedText;
  final String? skipText;

  final List<SnappyOnboardingItemModel>? items;

  const SnappyOnboardingControls({
    super.key,
    this.animations,
    this.animationDuration,
    this.backgroundColor,
    this.backArrow,
    this.forwardArrow,
    this.controlsTextColor,
    this.currentIndex,
    this.onSkip,
    this.onNext,
    this.onPrev,
    this.onCompleted,
    this.items,
    this.getStartedText,
    this.skipText,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
        bottom: 30,
        left: 16,
        right: 16,
        child: AnimateEase(
          animate: animations!,
          duration: animationDuration!,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (currentIndex != items!.length - 1)
                TextButton(
                  onPressed: onSkip,
                  child: Text(
                    skipText!,
                    style: TextStyle(
                      fontSize: 14.0,
                      color: controlsTextColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              Row(
                children: List.generate(items!.length, (index) {
                  return Container(
                    margin: const EdgeInsets.symmetric(horizontal: 4.0),
                    width: currentIndex == index ? 12.0 : 8.0,
                    height: currentIndex == index ? 12.0 : 8.0,
                    decoration: BoxDecoration(
                      color: currentIndex == index
                          ? controlsTextColor
                          : Colors.grey,
                      shape: BoxShape.circle,
                    ),
                  );
                }),
              ),
              if (currentIndex == items!.length - 1)
                TextButton(
                  onPressed: onCompleted,
                  child: Text(
                    getStartedText!,
                    style: TextStyle(
                      fontSize: 14.0,
                      color: controlsTextColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )
              else
                Row(
                  children: [
                    IconButton(
                      onPressed: onPrev,
                      icon: Icon(
                        backArrow,
                        color: controlsTextColor,
                      ),
                    ),
                    IconButton(
                      onPressed: onNext,
                      icon: Icon(
                        forwardArrow,
                        color: controlsTextColor,
                      ),
                    ),
                  ],
                ),
            ],
          ),
        ),
    );
  }
}
