import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      home: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _Painter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    //All our work will be done

    final radius = 100.0;
    final Offset offset = Offset(0.0, 75.0);
    final Paint paint = Paint()
      ..isAntiAlias = true
      ..strokeWidth = 10.0
      ..color = Colors.blue[500]
      ..style = PaintingStyle.stroke;

    final Offset bodyStart = Offset(0.0, 50.0);
    final Offset bodyEnd = Offset(0.0, 0.0);

    canvas.drawCircle(offset, radius, paint);
    canvas.drawLine(bodyStart, bodyEnd, paint);

    final Rect rect = Rect.fromCircle(center: offset, radius: radius);
    final Paint rectPaint = Paint()
      ..isAntiAlias = true
      ..strokeWidth = 10.0
      ..color = Colors.orange
      ..style = PaintingStyle.stroke;

    canvas.drawRect(rect, rectPaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

class _State extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Custom Painter'),
      ),
      body: Container(
        padding: EdgeInsets.all(32.0),
        child: Center(
          child: Column(
            children: <Widget>[
              CustomPaint(
                painter: _Painter(),
              ),
              Text(
                'Hello',
                style: TextStyle(
                  fontSize: 30.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
