import 'package:flutter/material.dart';

class MyDropDown extends StatelessWidget {
  const MyDropDown({
    super.key,
    required this.selectedValue,
    required this.listMenu,
    required this.title,
    required this.onChange,
  });

  final String? selectedValue;
  final List<String> listMenu;
  final Function(String? value) onChange;
  final String title;

  @override
  Widget build(BuildContext context) {
    return DropdownMenu(
      width: 200,
      initialSelection: selectedValue,
      menuHeight: 200,
      onSelected: onChange,
      hintText: title,
      dropdownMenuEntries: listMenu.map((item) {
        return DropdownMenuEntry(
          value: item,
          label: item,
        );
      }).toList(),
    );
  }
}
