import 'package:flutter/material.dart';

class FormattedTimer extends StatelessWidget {
  final int seconds;

  FormattedTimer(this.seconds);

  @override
  Widget build(BuildContext context) {
    // String hoursFormatted =
    // ((seconds / (60 * 60)) % 60).floor().toString().padLeft(2, '0');
    String minutesFormatted =
        ((seconds / 60) % 60).floor().toString().padLeft(2, '0');
    String secondsFormatted = (seconds % 60).floor().toString().padLeft(2, '0');

    return Text(minutesFormatted + ':' + secondsFormatted);
  }
}
