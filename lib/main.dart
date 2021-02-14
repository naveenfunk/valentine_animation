import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Valentine Animation',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        canvasColor: Colors.white,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatelessWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          Text(
            "Valentine's Day".toUpperCase(),
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20, color: Colors.red),
          ),
          Expanded(
            child: CustomPaint(
              child: Container(),
              painter: ValentineHeart(),
            ),
          ),
        ],
      )),
    );
  }
}

class ValentineHeart extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.red
      ..strokeWidth = 5
      ..style = PaintingStyle.fill
      ..strokeCap = StrokeCap.round;

    double topPointX = size.width / 2;
    double topPointY = size.height / 3;
    double bottomPointX = size.width / 2;
    double bottomPointY = size.height - (size.height / 3);

    Path path = Path();
    path.moveTo(topPointX, topPointY);
    path.cubicTo(
        size.width * 0.5, size.height * 0.315, size.width * 0.25, size.height * 0.205, size.width * 0.125, topPointY);
    path.cubicTo(size.width * 0.0, size.height * 0.50, topPointX, size.height * 0.60, bottomPointX, bottomPointY);
    path.cubicTo(topPointX, size.height * 0.60, size.width, size.height * 0.50, size.width * 0.875, topPointY);
    path.cubicTo(size.width * 0.75, size.height * 0.205, size.width * 0.5, size.height * 0.315, topPointX, topPointY);
    path.close();
    canvas.drawColor(Colors.white, BlendMode.color);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
