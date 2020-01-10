import 'package:flutter/material.dart';
import 'package:minicard/theme/nj_theme.dart';

class Shadow extends StatelessWidget {
  final Widget child;
  final SurfaceElevation elevation;
  final EdgeInsetsGeometry padding;

  Shadow(
      {@required this.child,
      this.elevation = SurfaceElevation.E4,
      this.padding});
  @override
  Widget build(BuildContext context) {
    EdgeInsetsGeometry usePadding;
    if (padding == null) {
      usePadding = EdgeInsets.all(NJTheme.padding);
    } else {
      usePadding = padding;
    }

    return Stack(children: [
      Positioned(
          left: 20,
          top: 20,
          child:
              Container(color: Colors.red, child: child, padding: usePadding)),
      child
    ]);
  }

  static Color color(SurfaceElevation elevation) {
    Color color;

    switch (elevation) {
      case SurfaceElevation.E0:
        color = NJColors.surface0dp;
        break;
      case SurfaceElevation.E1:
        color = NJColors.surface1dp;
        break;
      case SurfaceElevation.E2:
        color = NJColors.surface2dp;
        break;
      case SurfaceElevation.E3:
        color = NJColors.surface3dp;
        break;
      case SurfaceElevation.E4:
        color = NJColors.surface4dp;
        break;
      case SurfaceElevation.E6:
        color = NJColors.surface6dp;
        break;
      case SurfaceElevation.E8:
        color = NJColors.surface8dp;
        break;
      case SurfaceElevation.E12:
        color = NJColors.surface12dp;
        break;
      case SurfaceElevation.E16:
        color = NJColors.surface16dp;
        break;
      case SurfaceElevation.E24:
        color = NJColors.surface24dp;
        break;
    }
    return color;
  }
}
