import 'package:flutter/material.dart';
import 'package:review/screens/login_screen.dart';
import 'package:review/screens/registration_screen.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:review/const.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation animation;

  @override
  void initState() {
    controller = AnimationController(
      duration: Duration(
        seconds: 1,
      ),
      vsync: this,
    );
    animation =
        ColorTween(begin: Colors.black, end: Colors.white).animate(controller);

    controller.forward();
    controller.addListener(() {
      setState(() {});
      print(controller.value);
    });
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: animation.value,
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Flexible(
                child: Row(
                  children: <Widget>[
                    Hero(
                      tag: 'icon',
                      child: Container(
                        child: Image.asset('images/mylogogif.gif'),
                        height: 80.0,
                      ),
                    ),
                    AnimatedTextKit(animatedTexts: [
                      ColorizeAnimatedText(
                        ' Watch Guide',
                        textStyle: colorizeTextStyle,
                        colors: colorizeColors,
                      ),
                    ]),
                  ],
                ),
              ),
              SizedBox(
                height: 48.0,
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 16.0),
                child: Material(
                  elevation: 5.0,
                  color: Colors.lightBlueAccent,
                  borderRadius: BorderRadius.circular(30.0),
                  child: MaterialButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LoginScreen()),
                      );
                    },
                    minWidth: 200.0,
                    height: 42.0,
                    child: Text(
                      'Log In',
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 16.0),
                child: Material(
                  color: Colors.blueAccent,
                  borderRadius: BorderRadius.circular(30.0),
                  elevation: 5.0,
                  child: MaterialButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => RegistrationScreen()),
                      );
                    },
                    minWidth: 200.0,
                    height: 42.0,
                    child: Text(
                      'Register',
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
