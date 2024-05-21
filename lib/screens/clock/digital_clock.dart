import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:async';

class DigitalClock extends StatefulWidget {
  final String timeZone;

  DigitalClock({required this.timeZone});

  @override
  _DigitalClockState createState() => _DigitalClockState();
}

class _DigitalClockState extends State<DigitalClock> {
  late String _timeString;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _updateTime();
    _timer = Timer.periodic(Duration(seconds: 1), (Timer t) => _updateTime());
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void _updateTime() {
    final DateTime now = DateTime.now().toUtc().add(_getDuration(widget.timeZone));
    final String formattedDateTime = _formatDateTime(now);
    setState(() {
      _timeString = formattedDateTime;
    });
  }

  Duration _getDuration(String timeZone) {
    switch (timeZone) {
      case 'UTC+7:00 Jogja':
        return Duration(hours: 7);
      case 'UTC+9:00 Jayapura':
        return Duration(hours: 9);
      case 'UTC+0:00 London':
        return Duration(hours: 0);
      case 'UTC+8:00 Bali':
        return Duration(hours: 8);
      case 'UTC-5:00 New York':
        return Duration(hours: -5);
      default:
        return Duration(hours: 0); // Default to UTC
    }
  }

  String _formatDateTime(DateTime dateTime) {
    return DateFormat('HH:mm:ss').format(dateTime);
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      _timeString,
      style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
    );
  }
}
