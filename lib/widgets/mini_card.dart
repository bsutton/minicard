import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/widgets.dart';
import 'package:minicard/theme/nj_text_themes.dart';
import 'package:minicard/theme/nj_theme.dart';

class MiniCard extends StatefulWidget {
  final String title;
  final Widget body;

  final double widthFactor;
  final double heightFactor;

  static const double borderRadius = 10.0;

  MiniCard(this.title, this.body, this.widthFactor, this.heightFactor);
  @override
  _MiniCardState createState() => _MiniCardState();
}

class _MiniCardState extends State<MiniCard> {
  bool selected = false;

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width * widget.widthFactor;
    var height = MediaQuery.of(context).size.height * widget.heightFactor;

    return SizedBox(
      width: width,
      height: height,
      child: Container(
          margin: EdgeInsets.only(right: NJTheme.padding),
          decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius:
                  BorderRadius.all(Radius.circular(MiniCard.borderRadius))),
          child: buildBody(context)),
    );
  }

  /// Builds the body of the card which is a top panel covering most
  /// of the UI and the bottom activation bar.
  Column buildBody(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
            flex: 1, child: Row(children: [buildPanel(), buildRightBar()])),
        buildActivation(context)
      ],
    );
  }

  Widget buildPanel() {
    // elevation: selected ? 0 : 12,
    // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    return Expanded(
        flex: 1,
        child: Column(
            // mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [buildTitle(), buildContent()]));
  }

  Widget buildRightBar() {
    return Container(
      width: 20,
      // height: 100,
      decoration: BoxDecoration(
          color: Colors.orange,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(MiniCard.borderRadius),
          )),
    );
  }

  Widget buildContent() {
    return Container(
      child: widget.body,
      decoration: BoxDecoration(
        color: Colors.grey,
        borderRadius: BorderRadius.all(Radius.circular(MiniCard.borderRadius)),
      ),
    );
  }

  Widget buildTitle() {
    return Container(
        padding: EdgeInsets.only(left: NJTheme.padding),
        decoration: BoxDecoration(
            color: Colors.green,
            borderRadius:
                BorderRadius.all(Radius.circular(MiniCard.borderRadius))),
        child: TextNJHeadline(widget.title));
  }

  Widget buildActivation(BuildContext context) {
    //var height = MediaQuery.of(context).size.height.round();

    // return Column(children: [
    //   Expanded(flex: height * 90, child: Text(summary)),
    //   Expanded(
    //       flex: height * 10,
    //       child: Switch(
    //         value: true,
    //         onChanged: (selected) {},
    //       ))
    // ]);

    return Column(children: [
      // height: height * heightFactor * .9
      // Expanded(flex: 1, child: Text(summary)),
      Container(
          decoration: BoxDecoration(
              color: selected ? Colors.green[400] : Colors.green[200],
              borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(MiniCard.borderRadius),
                  bottomLeft: Radius.circular(MiniCard.borderRadius))),
          alignment: Alignment.centerLeft,
          child: Switch(
            value: selected,
            onChanged: (value) {
              print('value: $value');
              setState(() => selected = value);
              print('selected: $selected');
            },
          ))
    ]);
  }
}

class MiniCardRow extends StatelessWidget {
  final List<MiniCard> miniCards;

  MiniCardRow(this.miniCards);
  @override
  Widget build(BuildContext context) {
    return Provider.value(
        value: this,
        child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(mainAxisSize: MainAxisSize.min, children: miniCards)));
  }
}
