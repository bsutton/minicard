import 'package:flutter/material.dart';
import 'package:minicard/theme/nj_text_themes.dart';

import 'svg.dart';

class ButtonPrimary extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;

  final String svg;

  final Color svgColor;

  final LOCATION svgLocation;

  ButtonPrimary({@required this.label, @required this.onPressed})
      : svg = null,
        svgColor = null,
        svgLocation = null;

  @override
  Widget build(BuildContext context) {
    if (svg != null) {
      return RaisedButton.icon(
        color: Colors.deepPurple,
        disabledColor: Colors.grey,
        onPressed: this.onPressed,
        label: TextNJButton(label),
        icon: Svg(
          svg,
          height: 24,
          width: 24,
          location: svgLocation,
          color: svgColor,
        ),
      );
    } else {
      return RaisedButton(
        color: Colors.deepPurple,
        disabledColor: Colors.grey,
        onPressed: this.onPressed,
        child: TextNJButton(this.label),
      );
    }
  }

  ButtonPrimary.withIcon(
      {Key key,
      @required this.label,
      @required this.onPressed,
      @required this.svg,
      this.svgColor,
      this.svgLocation = LOCATION.VAADIN});
}

class ButtonSecondary extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;

  ButtonSecondary({@required this.label, @required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      child: TextNJButton(this.label),
      onPressed: this.onPressed,
      color: Colors.purple,
    );
  }
}
