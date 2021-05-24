import 'package:flutter/material.dart';
import 'package:news_app/models/countries.dart';

class CustomDropDown extends StatefulWidget {
  final List<String> dropDownItems;
  CustomDropDown(this.dropDownItems);

  @override
  _CustomDropDownState createState() =>
      _CustomDropDownState(this.dropDownItems);
}

class _CustomDropDownState extends State<CustomDropDown> {
  final List<String> items;

  _CustomDropDownState(this.items);

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
      value: Countries.selectedCountry == ''
          ? items[0]
          : Countries.selectedCountry,
      items: createDropdownItems(items),
      onChanged: (value) {
        setState(() {
          Countries.selectedCountry = value;
        });
      },
    );
  }
}
