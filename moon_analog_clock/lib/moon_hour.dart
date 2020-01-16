import 'package:flutter/material.dart';
import 'dart:math';
import 'package:flutter/rendering.dart';
import 'constants.dart';

/// This widget renders a moon crescent, based on the given [progress]. At 0, the moon is 'full'
/// and at 1, it a 'new moon'. Depending on the [progress], one will get all the phases of the moon.
/// The [size] is used to dimension this moon, always circular.
class MoonHour extends StatelessWidget {
  final double progress;
  final double size;

  const MoonHour({Key key, this.progress, this.size}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: MoonHourPainter(progress: progress, context: context),
      willChange: true,
      size: Size(size, size),
    );
  }
}

class MoonHourPainter extends CustomPainter {
  final double progress;
  final BuildContext context;

  MoonHourPainter({this.progress, this.context}) : assert(progress != null && progress >= 0.0 && progress <= 1.0);

  @override
  void paint(Canvas canvas, Size size) {
    final length = size.width;
    final center = Offset(length / 2, length / 2);
    final insidePaint = Paint()
      ..color = Theme.of(context).backgroundColor
      ..style = PaintingStyle.fill
      ..isAntiAlias = true;
    final outsidePaint = Paint()
      ..color = Theme.of(context).primaryColor
      ..style = PaintingStyle.fill
      ..isAntiAlias = true;
    canvas
      // Draw the first half of the moon in black or white depending the theme
      ..drawArc(
        Rect.fromCircle(center: center, radius: length / 2),
        3 / 2 * pi,
        pi,
        false,
        insidePaint,
      )
      // Draw the second half of the moon in white or black depending the theme
      ..drawArc(
        Rect.fromCircle(center: center, radius: length / 2),
        1 / 2 * pi,
        pi,
        false,
        outsidePaint,
      )
      // Draw an oval at the middle of the moon, whose height is the moon's height and width
      // computed with respect to the [progress]. The color depends whether the progress is
      // higher or lower than 0.5
      ..drawOval(
        Rect.fromCenter(
          center: center,
          width: progress < 0.5 ? length * (1 - progress * 2) : length * (progress - 0.5) * 2,
          height: length,
        ),
        progress < 0.5 ? insidePaint : outsidePaint,
      )
      // Draw the stroke of the moon
      ..drawArc(
        Rect.fromCircle(
          center: center,
          radius: size.width / 2,
        ),
        0,
        2 * pi,
        false,
        Paint()
          ..color = Theme.of(context).primaryColor
          ..style = PaintingStyle.stroke
          ..strokeWidth = size.width * Constants.STROKE_RATIO
          ..isAntiAlias = true,
      );
  }

  /// The widget should repaint only if the progress has changed
  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    if (oldDelegate is MoonHourPainter) {
      return oldDelegate.progress != this.progress;
    } else {
      return false;
    }
  }
}
