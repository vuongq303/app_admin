import 'package:flutter/material.dart';

class MyDropDown extends StatelessWidget {
  const MyDropDown({
    super.key,
    required this.listMenu,
    required this.title,
    required this.valueNotifier,
  });

  final ValueNotifier<String?> valueNotifier;
  final List<String> listMenu;
  final String title;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: valueNotifier,
      builder: (context, value, child) => DropdownMenu(
        width: 200,
        initialSelection: value,
        menuHeight: 200,
        onSelected: (String? value) {
          valueNotifier.value = value;
        },
        hintText: title,
        dropdownMenuEntries: listMenu.map((item) {
          return DropdownMenuEntry(
            value: item,
            label: item,
          );
        }).toList(),
      ),
    );
  }
}
