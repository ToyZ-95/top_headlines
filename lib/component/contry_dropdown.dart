import 'package:flutter/material.dart';
import 'package:news_app/models/countries.dart';

class CountryDropDown extends StatefulWidget {
  @override
  _CountryDropDownState createState() => _CountryDropDownState();
}

class _CountryDropDownState extends State<CountryDropDown> {
  List<String> countries = [];
  String selectedCountry = 'india';
  @override
  void initState() {
    countries = Countries.getCountries();
    super.initState();
  }

  List<DropdownMenuItem> createDropdownItems() {
    List<DropdownMenuItem> dropDownMenuItems = [];

    for (int i = 0; i < countries.length; i++) {
      dropDownMenuItems.add(
        DropdownMenuItem(
          child: Text(
            i.toString(),
            style: TextStyle(color: Colors.white),
          ),
          value: i.toString(),
        ),
      );
    }
    return dropDownMenuItems;
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButton(
      value: selectedCountry,
      items: createDropdownItems(),
      onChanged: (value) {
        setState(() {
          selectedCountry = value;
        });
      },
    );
  }
}
