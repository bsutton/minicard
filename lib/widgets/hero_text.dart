import 'package:flutter/cupertino.dart';

/// This class is to hack around a know problem when
/// using a hero with text.
///
/// https://github.com/flutter/flutter/issues/12463
///
/// Basically the hero screws up the font styling.
/// This specialised version controls the styling directly
class HeroText extends StatelessWidget {
  final String tag;
  final Widget child;

  HeroText({this.tag, this.child});
  @override
  Widget build(BuildContext context) {
    return Hero(
      flightShuttleBuilder: (_,
          Animation<double> animation,
          HeroFlightDirection flightDirection,
          BuildContext fromHeroContext,
          BuildContext toHeroContext) {
        return AnimatedBuilder(
          animation: animation,
          child: child,
          builder: (_, _child) {
            return DefaultTextStyle.merge(
              child: _child,
              style: TextStyle.lerp(
                  DefaultTextStyle.of(fromHeroContext).style,
                  DefaultTextStyle.of(toHeroContext).style,
                  flightDirection == HeroFlightDirection.pop
                      ? 1 - animation.value
                      : animation.value),
            );
          },
        );
      },
      tag: tag,
      child: child,
    );
  }
}
