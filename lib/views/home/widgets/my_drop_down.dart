import 'package:flutter/material.dart';

class MyDropDown extends StatelessWidget {
  const MyDropDown({
    super.key,
    required this.listMenu,
    required this.title,
    required this.value,
    required this.onChange,
  });

  final List<dynamic> listMenu;
  final Function(dynamic) onChange;
  final String title;
  final String? value;

  @override
  Widget build(BuildContext context) {
    return DropdownMenu(
      width: 200,
      initialSelection: value,
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
