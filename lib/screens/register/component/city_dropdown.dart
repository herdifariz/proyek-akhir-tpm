import 'package:flutter/material.dart';

class CityDropdown extends StatefulWidget {
  final String selectedCity;
  final ValueChanged<String?> onChanged;

  CityDropdown({required this.selectedCity, required this.onChanged});

  @override
  _CityDropdownState createState() => _CityDropdownState();
}

class _CityDropdownState extends State<CityDropdown> {
  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: widget.selectedCity,
      decoration: InputDecoration(
        labelText: 'City',
        labelStyle: TextStyle(color: Color(0xFF6200EE)),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xFF6200EE)),
          borderRadius: BorderRadius.circular(8),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xFF6200EE)),
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      onChanged: widget.onChanged,
      items: <String>['Jogja', 'Jayapura', 'Bali', 'London']
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}
