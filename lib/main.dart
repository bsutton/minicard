import 'package:flutter/material.dart';

import 'theme/nj_theme.dart';
import 'widgets/local_context.dart';
import 'widgets/mini_card.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final double heightFactor = 0.4;
  final double widthFactor = 0.3;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
            heightFactor,
            widthFactor),
      );
    } else
      return MiniCardRow([
        MiniCard(
            'Message',
            Text('body'), //  buildActivation(context, 'message'),
            heightFactor,
            widthFactor),
        MiniCard(
            'Colleague',
            Text('body'), //buildActivation(context, 'message'),
            heightFactor,
            widthFactor),
        MiniCard(
            'Team',
            Text('body'), //buildActivation(context, 'message')
            heightFactor,
            widthFactor),
        MiniCard('IVR', Text('body'), heightFactor, widthFactor),
        MiniCard(
            'External',
            Text('body'), //buildActivation(context, 'message'),
            heightFactor,
            widthFactor),
      ]);
  }
}
