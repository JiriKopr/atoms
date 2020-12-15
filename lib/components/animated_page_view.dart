import 'package:flutter/material.dart';

extension DistortionRatio on double {
  /// Function to calculate the ratio of distortion in
  /// every step of the animation
  /// 1 represents upper limit (fully opaque and initial size)
  /// 0.5 is lower limit (half opacity and half size)
  /// clamp just helps us to remain between defined values
  num getDistortionRatio({double min = 0, double max = 1}) {
    assert(min >= 0 && max <= 1);

    return (max - (this.abs() * (1 - min))).clamp(0.0, 1.0);
  }
}

typedef PageViewAnimatedBuilder = Widget Function(
    BuildContext context, Widget child, int index, double offset);

/// This page view also provides the current offset of
/// the item's position, which in combination with [double.getDistortionRatio]
/// will give us desired animation progress value to use in
/// transformations
///
/// In this example, the current text will be
/// ```
/// builder: (context, child, index, offset) {
///   final scaleDistortionRatio = offset.getDistortionRatio(min: 0.7);
///
///   return Transform.scale(
///     scale: scaleDistortionRatio,
///     child: Text('$index'),
///   );
/// ```
///
class AnimatedPageView extends StatelessWidget {
  final PageController pageViewController;
  final PageViewAnimatedBuilder builder;
  final int itemCount;
  final Axis scrollDirection;
  final void Function(int) onPageChanged;

  const AnimatedPageView({
    Key key,
    @required this.pageViewController,
    @required this.builder,
    @required this.itemCount,
    @required this.scrollDirection,
    @required this.onPageChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      controller: pageViewController,
      itemCount: itemCount,
      scrollDirection: scrollDirection,
      onPageChanged: onPageChanged,
      itemBuilder: (context, index) {
        return AnimatedBuilder(
          animation: pageViewController,
          builder: (context, child) {
            // pageViewController.page represents current selected page
            // and also the progress of slide between pages
            // half way between page 0 and 1 will be 0.5
            // pageController.page can only be accessed after the first build,
            // so in the first build we calculate the statusOffset manually
            double statusOffset = 0;
            if (pageViewController.position.minScrollExtent == null ||
                pageViewController.position.maxScrollExtent == null) {
              statusOffset = pageViewController.initialPage.toDouble() - index;
            } else {
              statusOffset = pageViewController.page - index;
            }

            return builder(context, child, index, statusOffset);
          },
        );
      },
    );
  }
}
