import 'package:flutter/material.dart';
import 'package:flutter_first_app/utility/constant.dart';

class PageRouteTransition {
  PageRouteTransition._();

  static final shared = PageRouteTransition._();

  // [路由動畫](https://openhome.cc/Gossip/Flutter/RouteAnimation.html)
  // [收藏不迷路 —— Flutter 轉場動效大合集 - 掘金](https://juejin.cn/post/7026720404530004004)
  PageRouteBuilder<dynamic> animation(TransitionPosition position,
      {required Widget nextPage,
      Duration duration = const Duration(milliseconds: 250)}) {
    final routeBuilder = PageRouteBuilder(
      transitionDuration: duration,
      pageBuilder: (context, animation, secondaryAnimation) {
        return nextPage;
      },
      transitionsBuilder: (context, animation, secondaryAnimation, child) =>
          SlideTransition(
        position: position.offset.animate(animation),
        child: child,
      ),
    );

    return routeBuilder;
  }
}
