import 'package:flutter/material.dart';

class CustomDropdown extends StatelessWidget {
  final String? selectedValue;
  final List<String> items;
  final ValueChanged<String?> onChanged;

  CustomDropdown({
    required this.selectedValue,
    required this.items,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String?>(
      value: selectedValue,
      hint: Text('Pilih'),
      onChanged: onChanged,
      items: items.map((item) {
        return DropdownMenuItem<String?>(
          value: item,
          child: Text(item),
        );
      }).toList(),
    );
  }
}
