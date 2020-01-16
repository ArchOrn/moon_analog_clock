import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_clock_helper/customizer.dart';
import 'package:flutter_clock_helper/model.dart';
import 'constants.dart';
import 'moon_analog_clock.dart';

/// This is the entry point of the clock, injecting the [ClockModel] to take benefit of it.
/// The app consists in loading the [MoonAnalogClock] which takes care of launching a [Timer]
/// to get the current time. While doing that, it updates the UI by rendering the [MoonAnalogClockWidget].
void main() {
  runApp(ClockCustomizer((ClockModel model) => MoonAnalogClock(model: model)));
}

class MoonAnalogClock extends StatefulWidget {
  final ClockModel model;

  MoonAnalogClock({Key key, this.model}) : super(key: key);

  @override
  _MoonAnalogClockState createState() => _MoonAnalogClockState();
}

class _MoonAnalogClockState extends State<MoonAnalogClock> {
  var _now = DateTime.now();
  Timer _timer;
  String _temperature;

  @override
  void initState() {
    super.initState();
    widget.model.addListener(_updateModel);
    _updateTime();
    _updateModel();
  }

  @override
  void didUpdateWidget(MoonAnalogClock oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.model != oldWidget.model) {
      oldWidget.model.removeListener(_updateModel);
      widget.model.addListener(_updateModel);
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    widget.model.removeListener(_updateModel);
    super.dispose();
  }

  /// The clock has two themes : dark and light, that animate when changing
  @override
  Widget build(BuildContext context) {
    return AnimatedTheme(
      duration: Duration(seconds: 1),
      data: Theme.of(context).brightness == Brightness.dark ? Constants.darkTheme : Constants.lightTheme,
      child: MoonAnalogClockWidget(
        currentTime: _now,
        temperature: _temperature,
      ),
    );
  }

  void _updateModel() {
    setState(() {
      _temperature = '${widget.model.temperature.toStringAsFixed(0)}°';
    });
  }

  /// The hour is updated every half a second, so we make sure it is always on time.
  void _updateTime() {
    setState(() {
      _now = DateTime.now();
      _timer = Timer(
        Duration(milliseconds: 500),
        _updateTime,
      );
    });
  }
}
