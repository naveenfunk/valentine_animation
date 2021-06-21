import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Valentine Animation Second',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        canvasColor: Colors.white,
      ),
      home: LandingPage(),
    );
  }
}

class LandingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: ElevatedButton(
            child: Text("Start Heart"),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => MyHomePage()));
            },
          ),
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

const String START_HEARTBEAT = "Start Heartbeat";
const String STOP_HEARTBEAT = "Stop Heartbeat";

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  Animation<double> _animation;
  AnimationController _controller;
  String _buttonText = START_HEARTBEAT;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: Duration(milliseconds: 1250));

    _animation = TweenSequence<double>([
      TweenSequenceItem(tween: Tween<double>(begin: 2, end: 3), weight: 0.1), // weight is the part of time given to this tween from total time i.e. 1250 * 0.1 = 125
      TweenSequenceItem(tween: Tween<double>(begin: 3, end: 2.5), weight: 0.1),
      TweenSequenceItem(tween: Tween<double>(begin: 2.5, end: 3.5), weight: 0.05),
      TweenSequenceItem(tween: Tween<double>(begin: 3.5, end: 2), weight: 0.75),
    ]).animate(_controller)
      ..addListener(() {
        setState(() {});
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          Expanded(
            child: Center(
              child: CustomPaint(
                child: Container(
                  height: (150 * _animation.value).toDouble(),
                  width: (100 * _animation.value).toDouble(),
                ),
                painter: ValentineHeart(),
              ),
            ),
          ),
          FlatButton(
            padding: const EdgeInsets.all(10),
            onPressed: () {
              if (_controller.isAnimating) {
                _buttonText = START_HEARTBEAT;
                _controller.stop();
              } else {
                _buttonText = STOP_HEARTBEAT;
                _controller.repeat();
              }
              setState(() {});
            },
            child: Text(
              _buttonText.toUpperCase(),
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20, color: Colors.red),
            ),
          ),
          SizedBox(height: 20)
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
