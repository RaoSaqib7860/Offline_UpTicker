import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:upticker/ColorsThems/ThemesColors.dart';
import 'dart:math' as math;

class LocalWidgets {
  static snackbar(GlobalKey<ScaffoldState> key, String text, Color color) {
    key.currentState.showSnackBar(SnackBar(
      content: Text(
        text,
        style: TextStyle(color: Colors.white),
      ),
      duration: Duration(seconds: 1),
      backgroundColor: color,
      behavior: SnackBarBehavior.floating,
    ));
  }

  static Widget withColorBox(BuildContext context, String text) {
    return WithColorBox(text: text);
  }

  static Widget withOutColorBox(BuildContext context, String text) {
    return WithOutColorBox(
      text: text,
    );
  }
}

class WithColorBox extends StatefulWidget {
  WithColorBox({Key key, this.text}) : super(key: key);
  final String text;
  @override
  _WithColorBoxState createState() => _WithColorBoxState();
}

class _WithColorBoxState extends State<WithColorBox> {
  bool anim = false;
  @override
  void initState() {
    Future.delayed(Duration(seconds: 0), () {
      setState(() {
        anim = true;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return AnimatedContainer(
      height: height / 6.2,
      width: width / 3.1,
      padding: EdgeInsets.all(anim == false ? width / 15 : 0),
      duration: Duration(milliseconds: 900),
      curve: Curves.bounceOut,
      child: Stack(
        children: [
          Image.asset(
            'assets/hexagon1.png',
            fit: BoxFit.fill,
            color: ColorsThemes.mailColors,
            height: double.infinity,
            width: double.infinity,
          ),
          Center(
            child: Padding(
              padding: EdgeInsets.only(left: width / 20, right: width / 25),
              child: SizedBox(
                width: double.infinity,
                height: double.infinity,
                child: Center(
                  child: AutoSizeText(
                    '${widget.text}'.capitalize(),
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 14.0, color: Colors.white),
                    maxLines: 3,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class WithOutColorBox extends StatefulWidget {
  WithOutColorBox({Key key, this.text}) : super(key: key);
  final String text;
  @override
  _WithOutColorBoxState createState() => _WithOutColorBoxState();
}

class _WithOutColorBoxState extends State<WithOutColorBox> {
  bool anim = false;
  @override
  void initState() {
    Future.delayed(Duration(seconds: 0), () {
      setState(() {
        anim = true;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return AnimatedOpacity(
      duration: Duration(milliseconds: 500),
      opacity: anim == false ? 0 : 1,
      child: AnimatedContainer(
        height: anim == false ? 0 : height / 6.2,
        width: width / 3.1,
        decoration: BoxDecoration(shape: BoxShape.rectangle),
        duration: Duration(milliseconds: 900),
        curve: Curves.bounceOut,
        child: Stack(
          children: [
            Image.asset(
              'assets/hexagon1.png',
              fit: BoxFit.fill,
              height: double.infinity,
              width: double.infinity,
            ),
            Center(
              child: Padding(
                padding: EdgeInsets.only(left: width / 20, right: width / 25),
                child: SizedBox(
                  width: double.infinity,
                  height: double.infinity,
                  child: Center(
                    child: AutoSizeText(
                      '${widget.text}'.capitalize(),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14.0,
                      ),
                      maxLines: 3,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class HexagonPainter extends CustomPainter {
  static const int SIDES_OF_HEXAGON = 6;
  final double radius;
  final Offset center;
  HexagonPainter(this.center, this.radius);

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()..color = Colors.blue;
    Path path = createHexagonPath();
    canvas.drawPath(path, paint);
  }

  Path createHexagonPath() {
    final path = Path();
    var angle = (math.pi * 2) / SIDES_OF_HEXAGON;
    Offset firstPoint = Offset(radius * math.cos(0.0), radius * math.sin(0.0));
    path.moveTo(firstPoint.dx + center.dx, firstPoint.dy + center.dy);
    for (int i = 1; i <= SIDES_OF_HEXAGON; i++) {
      double x = radius * math.cos(angle * i) + center.dx;
      double y = radius * math.sin(angle * i) + center.dy;
      path.lineTo(x, y);
    }
    path.close();
    return path;
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${this.substring(1)}";
  }
}
