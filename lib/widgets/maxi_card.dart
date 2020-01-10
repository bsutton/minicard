import 'package:flutter/material.dart';
import 'package:minicard/theme/nj_text_themes.dart';
import 'package:minicard/theme/nj_theme.dart';
import 'package:provider/provider.dart';
import 'package:flutter/widgets.dart' hide Shadow;

import 'hero_text.dart';
import 'mini_card.dart';

class MaxiCard extends StatefulWidget {
  final MiniCard miniCard;

  final ActiveMiniCard activeMiniCard;

  MaxiCard(this.activeMiniCard, this.miniCard);

  @override
  _MaxiCardState createState() => _MaxiCardState();
}

class _MaxiCardState extends State<MaxiCard> {
  bool selected = false;

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width * 1;
    var height = MediaQuery.of(context).size.height * 1;

    return SizedBox(width: width, height: height, child: buildBody(context));
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
    return Expanded(
        flex: 1,
        child: Column(
            // mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [buildTitle(), buildContent()]));
  }

  Widget buildRightBar() {
    return Hero(
        tag: 'mini-card-${widget.miniCard.title}-rightBar',
        child: Container(
          width: 20,
          // height: 100,
          decoration: BoxDecoration(color: widget.miniCard.barColor),
        ));
  }

  Widget buildContent() {
    return Expanded(
        flex: 1,
        child: HeroText(
            tag: 'mini-card-${widget.miniCard.title}-content',
            child: Container(
              padding: EdgeInsets.all(NJTheme.padding),
              child: widget.miniCard.body,
              decoration: BoxDecoration(
                color: Colors.grey,
              ),
            )));
  }

  Widget buildTitle() {
    return HeroText(
        tag: 'mini-card-${widget.miniCard.title}',
        child: GestureDetector(
            onTap: closeMaxi,
            child: Container(
                padding: EdgeInsets.all(NJTheme.padding),
                decoration: BoxDecoration(
                  color: Colors.green,
                ),
                child: TextNJSubheading(widget.miniCard.title))));
  }

  Widget buildActivation(BuildContext context) {
    selected = widget.miniCard == widget.activeMiniCard.active;

    return Hero(
        tag: 'mini-card-${widget.miniCard.title}-activation',
        child: Material(
            child: Container(
                decoration: BoxDecoration(
                  color: selected ? Colors.yellow[500] : Colors.yellow[200],
                ),
                alignment: Alignment.centerLeft,
                child: Switch(
                  value: selected,
                  onChanged: (value) {
                    setState(() => selected = value);
                    this.widget.activeMiniCard.setActive(this.widget.miniCard);
                  },
                ))));
  }

  void closeMaxi() {
    Navigator.pop(context);
  }
}
