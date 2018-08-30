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

class _State extends State<MyApp> {
  List<Step> _steps;
  int _current;

  @override
  void initState() {
    super.initState();
    _current = 0;
    _steps = <Step>[
      Step(
        title: Text('Step 1'),
        content: Text('Do Something On Step 1'),
        isActive: true,
      ),
      Step(
        title: Text('Step 2'),
        content: Text('Do Something On Step 2'),
        isActive: false,
      ),
      Step(
        title: Text('Step 3'),
        content: Text('Do Something On Step 3'),
        isActive: false,
      ),
    ];
  }

  void _stepContinue() {
    setState(() {
      _current++;
      if (_current >= _steps.length) _current = _steps.length - 1;
    });
  }

  void _stepCancel() {
    setState(() {
      _current--;
      if (_current < 0) _current = 0;
    });
  }

  void _stepTap(int index) {
    setState(() {
      _current = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Layout Stepper'),
      ),
      body: Container(
        padding: EdgeInsets.all(32.0),
        child: Center(
          child: Stepper(
            steps: _steps,
            type: StepperType.vertical,
            currentStep: _current,
            onStepCancel: _stepCancel,
            onStepContinue: _stepContinue,
            onStepTapped: _stepTap,
          ),
        ),
      ),
    );
  }
}
