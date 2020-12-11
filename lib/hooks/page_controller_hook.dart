import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

/// Hook for getting [PageController]
PageController usePageController({
  int initialPage = 0,
  bool keepPage = true,
  double viewportFraction = 1.0,
}) {
  return use(_PageControllerHook(
    initialPage: initialPage,
    keepPage: keepPage,
    viewportFraction: viewportFraction,
  ));
}

class _PageControllerHook extends Hook<PageController> {
  final int initialPage;
  final bool keepPage;
  final double viewportFraction;

  const _PageControllerHook({
    @required this.initialPage,
    @required this.keepPage,
    @required this.viewportFraction,
  });

  @override
  _PageControllerHookState createState() => _PageControllerHookState();
}

class _PageControllerHookState
    extends HookState<PageController, _PageControllerHook> {
  PageController _pageController;

  @override
  void initHook() {
    super.initHook();
    _pageController = PageController(
      initialPage: hook.initialPage,
      keepPage: hook.keepPage,
      viewportFraction: hook.viewportFraction,
    );
  }

  @override
  void dispose() {
    _pageController?.dispose();
    super.dispose();
  }

  @override
  PageController build(BuildContext context) => _pageController;
}
