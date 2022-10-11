import 'package:flutter/material.dart';

class CustomRoutes extends PageRouteBuilder {
  final Widget child;
  final AxisDirection direction;
  CustomRoutes({required this.child, this.direction = AxisDirection.right})
      : super(
          transitionDuration: const Duration(milliseconds: 150),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            Offset getBeginOffSet() {
              switch (direction) {
                case AxisDirection.up:
                  return const Offset(0, -1);
                case AxisDirection.down:
                  return const Offset(0, 1);
                case AxisDirection.right:
                  return const Offset(1, 0);
                case AxisDirection.left:
                  return const Offset(-1, 0);
              }
            }

            return SlideTransition(
              position: Tween<Offset>(
                begin: getBeginOffSet(),
                end: Offset.zero,
              ).animate(animation),
              child: child,
            );
          },
          pageBuilder: (context, animation, secondaryAnimation) => child,
        );
}
