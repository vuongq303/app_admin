import 'package:app_admin/provider/home_provider.dart';
import 'package:flutter/material.dart';

class MyDropDown extends StatelessWidget {
  const MyDropDown({
    super.key,
    required this.listMenu,
    required this.title,
    required this.homeProvider,
    required this.value,
  });

  final HomeProvider homeProvider;
  final List<String> listMenu;
  final String title;
  final String? value;

  @override
  Widget build(BuildContext context) {
    return DropdownMenu(
      width: 200,
      initialSelection: value,
      menuHeight: 200,
      onSelected: (String? value) => homeProvider.updateState(),
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
