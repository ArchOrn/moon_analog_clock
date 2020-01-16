import 'package:flutter/material.dart';
import 'package:flutter_clock_helper/model.dart';
import 'constants.dart';
import 'moon_hour.dart';

/// Renders the clock with respect to the [currentTime] passed in parameters.
/// This clock consists of 12 'moons' that get filled (i.e. the become darker) along with the passing hours
///
/// In dark mode, the moons rather get filled by becoming 'full moons'.
///
/// The hour can be read by counting the filled moons (the number of hours) and by guessing the minutes
/// watching the moon crescent of the filling moon.
///
/// The clock also displays the temperature at the bottom, converted if necessary in Farenheit.
class MoonAnalogClockWidget extends StatelessWidget {
  final DateTime currentTime;
  final String temperature;

  const MoonAnalogClockWidget({Key key, this.currentTime, this.temperature}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: Center(
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: _buildMoons(),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    temperature,
                    style: Theme.of(context).textTheme.display1,
                  ),
                  SizedBox(
                    height: 15,
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  /// Builds the 12 moons.
  ///
  /// By getting the current time, this method fills the first moons with respect to the given hour.
  /// It then fills the next moon with respect with the minutes.
  /// The other moons are left unfilled.
  List<Widget> _buildMoons() {
    final currentHourDoubled = currentTime.hour.toDouble() % 12 + currentTime.minute.toDouble() / 60.0 + currentTime.second.toDouble() / 3600.0;
    List<Widget> moons = [];
    for (var i = 0; i < 12; i++) {
      moons.add(
        MoonHour(
          progress: i == currentHourDoubled.floor() ? currentHourDoubled - currentHourDoubled.floor() : i < currentHourDoubled ? 1 : 0,
          size: Constants.MOON_SIZE,
        ),
      );
      if (i != 11) {
        moons.add(
          SizedBox(
            width: 7,
          ),
        );
      }
    }
    return moons;
  }
}
