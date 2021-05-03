import 'package:flutter/material.dart';

import 'package:clipboard/clipboard.dart';

class AnimatedIconButtonShare extends StatefulWidget {
  final IconData iconData;
  final String link;
  AnimatedIconButtonShare({@required this.iconData, @required this.link});
  @override
  _AnimatedIconButtonShareState createState() =>
      _AnimatedIconButtonShareState(iconData: iconData, link: link);
}

class _AnimatedIconButtonShareState extends State<AnimatedIconButtonShare>
    with TickerProviderStateMixin {
  final IconData iconData;
  final String link;

  _AnimatedIconButtonShareState({@required this.iconData, @required this.link});

  AnimationController _iconAnimationController;
  AnimationController _colorAnimationController;

  bool _active = false;

  @override
  void initState() {
    _iconAnimationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 125),
      value: 1.0,
      lowerBound: 1.0,
      upperBound: 1.75,
    );

    _colorAnimationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 125),
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _onTap,
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(8)),
            border: Border.all(color: Colors.black),
            color: Colors.black),
        child: ScaleTransition(
          scale: _iconAnimationController,
          child: Icon(
            iconData,
            size: 30,
            color: Colors.red,
          ),
        ),
      ),
    );
  }

  void _onTap() {
    _iconAnimationController.forward().then((value) {
      _active
          ? _colorAnimationController.forward()
          : _colorAnimationController.reverse();
      _iconAnimationController.reverse();
    });

    FlutterClipboard.copy(link).then((value) => print('copied'));
    ScaffoldMessenger.of(context)
        .showSnackBar(new SnackBar(content: new Text(link)));
  }
}
