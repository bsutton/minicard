import 'package:flutter/material.dart';

// this import causes the compile to web issues.
import 'package:page_transition/page_transition.dart';


import 'package:provider/provider.dart';
import 'package:flutter/widgets.dart' hide Shadow;
import 'package:minicard/theme/nj_text_themes.dart';
import 'package:minicard/theme/nj_theme.dart';

import '../main.dart';
import 'hero_text.dart';
import 'local_context.dart';

class MiniCard extends StatefulWidget {
  final String title;
  final Widget body;

  final double widthFactor;
  final double heightFactor;

  static const double borderRadius = 10.0;

  final Color barColor;

  MiniCard(this.title, this.body, this.barColor, this.widthFactor,
      this.heightFactor);

  @override
  _MiniCardState createState() => _MiniCardState();

  bool operator ==(Object other) {
    return other is MiniCard && this.title == other.title;
  }

  int get hashCode {
    int result = 17;
    result = 37 * result + title.hashCode;
    return result;
  }
}

class _MiniCardState extends State<MiniCard> {
  bool selected = false;

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width * widget.widthFactor;
    var height = MediaQuery.of(context).size.height * widget.heightFactor;

    return SizedBox(width: width, height: height, child: buildBody(context));
  }

  /// Builds the body of the card which is a top panel covering most
  /// of the UI and the bottom activation bar.
  Widget buildBody(BuildContext context) {
    return GestureDetector(
        onTap: showMessage,
        child: Container(
          margin:
              EdgeInsets.only(left: NJTheme.padding, right: NJTheme.padding),
          decoration: BoxDecoration(
              color: Colors.green,
              borderRadius: BorderRadius.all(
                Radius.circular(MiniCard.borderRadius),
              )),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                  flex: 1,
                  child: Row(children: [buildPanel(), buildRightBar()])),
              buildActivation(context)
            ],
          ),
        ));
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
    return Hero(
        tag: 'mini-card-${widget.title}-rightBar',
        child: Container(
          width: 20,
          // height: 100,
          decoration: BoxDecoration(
              color: widget.barColor,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(MiniCard.borderRadius),
              )),
        ));
  }

  Widget buildContent() {
    return Expanded(
      flex: 1,
      // child: HeroText(
      //   tag: 'mini-card-${widget.title}-content',
      child: Container(
        padding: EdgeInsets.all(NJTheme.padding),
        child: widget.body,
        decoration: BoxDecoration(
          color: Colors.grey,
        ),
      ),
      // ),
    );
  }

  Widget buildTitle() {
    return HeroText(
      tag: 'mini-card-${widget.title}',
      child: Container(
          padding: EdgeInsets.all(NJTheme.padding),
          decoration: BoxDecoration(
              color: Colors.green,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(MiniCard.borderRadius))),
          child: TextNJSubheading(widget.title)),
    );
  }

  Widget buildActivation(BuildContext context) {
    //var height = MediaQuery.of(context).size.height.round();

    return
        // height: height * heightFactor * .9
        // Expanded(flex: 1, child: Text(summary)),
        Consumer<ActiveMiniCard>(
      builder: (context, active, _) {
        selected = active.active == this.widget;
        return Hero(
            tag: 'mini-card-${widget.title}-activation',
            child: Material(
                borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(MiniCard.borderRadius),
                    bottomLeft: Radius.circular(MiniCard.borderRadius)),
                child: Container(
                    decoration: BoxDecoration(
                        color:
                            selected ? Colors.yellow[500] : Colors.yellow[200],
                        borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(MiniCard.borderRadius),
                            bottomLeft:
                                Radius.circular(MiniCard.borderRadius))),
                    alignment: Alignment.centerLeft,
                    child: Switch(
                      value: selected,
                      onChanged: (value) {
                        setState(() => selected = value);
                        ActiveMiniCard activeMiniCard =
                            Provider.of<ActiveMiniCard>(context, listen: false);
                        activeMiniCard.setActive(this.widget);
                      },
                    ))));
      },
    );
  }

  void showMessage() {
    ActiveMiniCard activeMiniCard =
        Provider.of<ActiveMiniCard>(context, listen: false);
    Navigator.push(
        context,
        PageTransition(
            type: PageTransitionType.fade,
            child: MessagePage.withActive(activeMiniCard, this.widget),
            duration: Duration(milliseconds: 600)));
    // PageRouteBuilder(
    //     transitionDuration: Duration(milliseconds: 600),
    //     pageBuilder: (_, __, ___) =>
    //         MessagePage.withActive(activeMiniCard)));
  }
}

class ActiveMiniCard extends ChangeNotifier {
  /// the minicard instance, from the set
  /// of minicard's passed to [MiniCardRow]
  /// that is currently the active instanc.e
  MiniCard active;

  void setActive(MiniCard miniCard) {
    active = miniCard;
    notifyListeners();
  }
}

class MiniCardRow extends StatelessWidget {
  final List<MiniCard> miniCards;
  final ActiveMiniCard active = ActiveMiniCard();

  MiniCardRow(this.miniCards);
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ActiveMiniCard>(
        create: (context) => active,
        child: LocalContext(
            builder: (context) => SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child:
                    Row(mainAxisSize: MainAxisSize.min, children: miniCards))));
  }
}
