import 'package:flutter/material.dart';

class CustomDropDown extends StatefulWidget {
  final List<String> dropDownItems;
  String selectedItem;
  CustomDropDown(this.dropDownItems, this.selectedItem);

  @override
  _CustomDropDownState createState() =>
      _CustomDropDownState(this.dropDownItems, this.selectedItem);
}

class _CustomDropDownState extends State<CustomDropDown> {
  final List<String> items;
  String selectedItem;

  _CustomDropDownState(this.items, this.selectedItem);

  @override
  void initState() {
    super.initState();
  }

  List<DropdownMenuItem> createDropdownItems(List<String> items) {
    List<DropdownMenuItem> dropDownMenuItems = [];

    for (int i = 0; i < items.length; i++) {
      dropDownMenuItems.add(createCountryDropdownItem(items[i]));
    }
    return dropDownMenuItems;
  }

  DropdownMenuItem createCountryDropdownItem(String item) {
    return DropdownMenuItem(
      value: item,
      child: Text(
        item,
        style: TextStyle(color: Colors.white),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButton(
      dropdownColor: Colors.blue,
      value: selectedItem == null ? null : selectedItem,
      items: createDropdownItems(items),
      onChanged: (value) {
        setState(() {
          selectedItem = value;
        });
      },
    );
  }
}
