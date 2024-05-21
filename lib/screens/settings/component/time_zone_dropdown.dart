import 'package:flutter/material.dart';

class TimeZoneDropdown extends StatefulWidget {
  final String? selectedTimeZone;
  final ValueChanged<String?> onChanged;

  TimeZoneDropdown({required this.selectedTimeZone, required this.onChanged});

  @override
  _TimeZoneDropdownState createState() => _TimeZoneDropdownState();
}

class _TimeZoneDropdownState extends State<TimeZoneDropdown> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Time Zone',
          style: TextStyle(
            fontSize: 18,
            color: Colors.white,
          ),
        ),
        SizedBox(height: 8),
        SizedBox(
          width: double.infinity,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                isExpanded: true,
                value: widget.selectedTimeZone,
                items: <String>[
                  'UTC+9:00 Jayapura',
                  'UTC-5:00 New York',
                  'UTC+0:00 London',
                  'UTC+7:00 Jogja',
                  'UTC+8:00 Bali'
                ].map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: widget.onChanged,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
