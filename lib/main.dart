import 'package:flutter/material.dart';

import 'theme/nj_text_themes.dart';
import 'theme/nj_theme.dart';
import 'widgets/local_context.dart';
import 'widgets/maxi_card.dart';
import 'widgets/mini_card.dart';

void main() => runApp(MyApp());
final double heightFactor = 0.4;
final double widthFactor = 0.3;

MiniCard message = MiniCard(
    'Message',
    TextNJBody(
        'Play a message to the caller.'), //  buildActivation(context, 'message'),
    Colors.purple,
    heightFactor,
    widthFactor);

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: <String, WidgetBuilder>{
        MessagePage.routeName: (context) => MessagePage()
      },
      title: 'Welcome to Flutter',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Welcome to Flutter'),
        ),
        body: SizedBox.expand(
            child: Surface(
                child: LocalContext(
          builder: (context) => buildMiniCardRow(),
        ))),
      ),
    );
  }

  Widget buildMiniCardRow() {
    bool row = true;

    if (row == false) {
      return Container(
        child: MiniCard(
            'Message',
            Text('body'), //  buildActivation(context, 'message'),
            Colors.red,
            heightFactor,
            widthFactor),
      );
    } else
      return MiniCardRow([
        message,
        MiniCard(
            'Colleague',
            Text('body'), //buildActivation(context, 'message'),
            Colors.blue,
            heightFactor,
            widthFactor),
        MiniCard(
            'Team',
            Text('body'), //buildActivation(context, 'message')
            Colors.orange,
            heightFactor,
            widthFactor),
        MiniCard('User Chooses', Text('body'), Colors.pink, heightFactor,
            widthFactor),
        MiniCard(
            'External No.',
            Text('body'), //buildActivation(context, 'message'),
            Colors.brown,
            heightFactor,
            widthFactor),
      ]);
  }
}

class MessagePage extends StatelessWidget {
  static const routeName = '/message';
  final ActiveMiniCard activeMiniCard;

  final MiniCard selected;

  const MessagePage({Key key, this.activeMiniCard, this.selected})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    ActiveMiniCard localActive;
    if (activeMiniCard == null)
      localActive = ModalRoute.of(context).settings.arguments;
    else {
      localActive = activeMiniCard;
    }

    return Material(child: MaxiCard(localActive, selected));
  }

  MessagePage.withActive(this.activeMiniCard, this.selected);
}
