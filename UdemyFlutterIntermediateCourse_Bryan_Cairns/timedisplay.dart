import 'package:flutter/material.dart';

class TimeDisplay extends StatelessWidget {
  static const dur = Duration();
  TimeDisplay({Key key, this.color = Colors.green, this.duration = dur, this.onClear})
      : super(key: key);

  final Duration duration;
  final Color color;
  final ValueChanged<Duration> onClear;

  void _onClicked() {
    onClear(duration);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.all(5.0),
          child: Text(
            duration.toString(),
            style: TextStyle(
              fontSize: 32.0,
              color: color,
            ),
          ),
        ),
        IconButton(
          icon: Icon(Icons.clear),
          onPressed: _onClicked,
        ),
      ],
    );
  }
}
