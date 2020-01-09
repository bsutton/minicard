import 'package:flutter/material.dart';

import 'nj_theme.dart';

class TextNJHeadline extends StatelessWidget {
  final String text;
  final Color color;

  TextNJHeadline(this.text, {this.color = NJColors.textPrimary}) {
    assert(text != null);
  }

  @override
  Widget build(BuildContext context) {
    return Text(text,
        style:
            TextStyle(color: color, fontSize: 30, fontWeight: FontWeight.w500));
  }
}

///
/// Use this style on any page that has a full width heading at the top of the page.
///
class TextNJPageHeading extends StatelessWidget {
  final String text;
  final Color color;

  TextNJPageHeading(String text, {this.color = NJColors.textPrimary})
      : this.text = text?.toUpperCase() {
    assert(text != null);
  }

  @override
  Widget build(BuildContext context) {
    return Text(text,
        style:
            TextStyle(color: color, fontSize: 30, fontWeight: FontWeight.w500));
  }
}

class TextNJSubheading extends StatelessWidget {
  final String text;
  final Color color;

  final TextStyle style;

  TextNJSubheading(this.text, {this.color = NJColors.textPrimary})
      : this.style = TextStyle(fontSize: 20, color: color) {
    assert(text != null);
  }

  @override
  Widget build(BuildContext context) {
    return Text(text, style: style);
  }
}

///
/// Used for text and  paragraphs of text that should use the
///  standard font/styling for the body of a document.
class TextNJBody extends StatelessWidget {
  static const TextStyle style = TextStyle();

  final TextStyle _style;
  final String text;
  final Color color;

  TextNJBody(this.text, {this.color = NJColors.textPrimary})
      : this._style = style.copyWith(color: color) {
    assert(text != null);
  }

  @override
  Widget build(BuildContext context) {
    return Text(text, style: _style);
  }
}

///
/// Used in the body of a document where you need to
/// highlight the text. This is essentially a bolded TextNJBody
///
class TextNJNotice extends StatelessWidget {
  final String text;
  static const TextStyle noticeStyle = TextStyle(fontWeight: FontWeight.bold);

  TextNJNotice(this.text) {
    assert(text != null);
  }

  @override
  Widget build(BuildContext context) {
    return Text(text, style: noticeStyle);
  }
}

///
/// Used when you need to display text indicating an error.
///
class TextNJError extends StatelessWidget {
  final String text;
  static const TextStyle noticeStyle = TextStyle(
      fontWeight: FontWeight.bold,
      color: NJColors.errorText,
      backgroundColor: NJColors.errorBackground);

  TextNJError(this.text) {
    assert(text != null);
  }

  @override
  Widget build(BuildContext context) {
    return Text(text, style: noticeStyle);
  }
}

///
/// Text style used by buttons such as ButtonPrimary/ButtonSecondary
///
class TextNJButton extends StatelessWidget {
  final String text;
  final Color color;
  final TextStyle style;

  TextNJButton(this.text, {this.color = NJColors.textPrimary})
      : this.style = TextStyle(color: color, fontSize: 16) {
    assert(text != null);
  }

  @override
  Widget build(BuildContext context) {
    return Text(text.toUpperCase(), style: style);
  }
}

/// Use for Form Field labels.
class TextNJLabel extends StatelessWidget {
  final String text;
  final Color color;
  final TextStyle style;

  TextNJLabel(this.text, {this.color = NJColors.textPrimary})
      : this.style = TextStyle(color: color, fontSize: 16) {
    assert(text != null);
  }

  @override
  Widget build(BuildContext context) {
    return Text(text, style: style);
  }
}

///
/// Use this for text that is displayed in the likes of a ListView
///
class TextNJListItem extends StatelessWidget {
  final String text;
  final Color color;
  static const TextStyle style = TextStyle(fontSize: 16);

  TextNJListItem(this.text, {this.color = NJColors.listCardText}) {
    assert(text != null);
  }

  @override
  Widget build(BuildContext context) {
    return Text(text, style: style.copyWith(color: color));
  }
}

///
/// Use this style when you are looking to display
/// some ancillary information that isn't that important.
/// Ancillary text will be displayed in a lighter font color
class TextNJAncillary extends StatelessWidget {
  final String text;
  final Color color;
  final TextStyle style;

  TextNJAncillary(this.text, {this.color = Colors.grey})
      : this.style = TextStyle(color: color, fontSize: 16) {
    assert(text != null);
  }

  @override
  Widget build(BuildContext context) {
    return Text(text, style: style);
  }
}

///
/// Used for the text within chips.
class TextNJChip extends StatelessWidget {
  static const TextStyle style = TextStyle(fontSize: 15);

  final TextStyle _style;
  final String text;
  final Color color;

  TextNJChip(this.text, {this.color = NJColors.chipTextColor})
      : this._style = style.copyWith(color: color) {
    assert(text != null);
  }

  @override
  Widget build(BuildContext context) {
    return Text(text, style: _style);
  }
}

enum Position { START, END }

class TextNJIcon extends StatelessWidget {
  final String text;
  final IconData icon;
  final Position position;
  final Color color;
  final Color iconColor;

  TextNJIcon(this.text, this.icon,
      {this.position = Position.START, this.iconColor, this.color});

  @override
  Widget build(BuildContext context) {
    if (position == Position.START) {
      return Row(children: [
        Icon(icon, color: iconColor),
        Padding(
            child: TextNJListItem(text, color: color),
            padding: EdgeInsets.only(left: 5))
      ]);
    } else {
      return Row(children: [
        Padding(
            child: TextNJListItem(text, color: color),
            padding: EdgeInsets.only(right: 5)),
        Icon(icon, color: iconColor)
      ]);
    }
  }
}
