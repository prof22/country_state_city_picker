library country_state_city_picker_nona;

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

import 'model/select_status_model.dart' as StatusModel;

class SelectState extends StatefulWidget {
  final ValueChanged<String> onCountryChanged;
  final ValueChanged<String> onStateChanged;
  final ValueChanged<String> onCityChanged;
  final VoidCallback? onCountryTap;
  final VoidCallback? onStateTap;
  final VoidCallback? onCityTap;
  final TextStyle? style;
  final Color? dropdownColor;
  final InputDecoration decoration;
  final double spacing;

  const SelectState(
      {Key? key,
      required this.onCountryChanged,
      required this.onStateChanged,
      required this.onCityChanged,
      this.decoration =
          const InputDecoration(contentPadding: EdgeInsets.all(0.0)),
      this.spacing = 0.0,
      this.style,
      this.dropdownColor,
      this.onCountryTap,
      this.onStateTap,
      this.onCityTap})
      : super(key: key);

  @override
  _SelectStateState createState() => _SelectStateState();
}

class _SelectStateState extends State<SelectState> {
  List<String> _cities = ["Choose City"];
  List<String> _country = ["Choose Country"];
  String _selectedCity = "Choose City";
  String _selectedCountry = "Choose Country";
  String _selectedState = "Choose State";
  List<String> _states = ["Choose State"];
  var responses;

  @override
  void initState() {
    getCounty();
    super.initState();
  }

  Future getResponse() async {
    var res = await rootBundle.loadString(
        'packages/country_state_city_picker/lib/assets/country.json');
    return jsonDecode(res);
  }

  Future getCounty() async {
    var countryres = await getResponse() as List;
    countryres.forEach((data) {
      var model = StatusModel.StatusModel();
      model.name = data['name'];
      model.emoji = data['emoji'];
      if (!mounted) return;
      setState(() {
        _country.add(model.emoji! + "    " + model.name!);
      });
    });

    return _country;
  }

  Future getState() async {
    var response = await getResponse();
    var takestate = response
        .map((map) => StatusModel.StatusModel.fromJson(map))
        .where((item) => item.emoji + "    " + item.name == _selectedCountry)
        .map((item) => item.state)
        .toList();
    var states = takestate as List;
    states.forEach((f) {
      if (!mounted) return;
      setState(() {
        var name = f.map((item) => item.name).toList();
        for (var statename in name) {
          print(statename.toString());

          _states.add(statename.toString());
        }
      });
    });

    return _states;
  }

  Future getCity() async {
    var response = await getResponse();
    var takestate = response
        .map((map) => StatusModel.StatusModel.fromJson(map))
        .where((item) => item.emoji + "    " + item.name == _selectedCountry)
        .map((item) => item.state)
        .toList();
    var states = takestate as List;
    states.forEach((f) {
      var name = f.where((item) => item.name == _selectedState);
      var cityname = name.map((item) => item.city).toList();
      cityname.forEach((ci) {
        if (!mounted) return;
        setState(() {
          var citiesname = ci.map((item) => item.name).toList();
          for (var citynames in citiesname) {
            print(citynames.toString());

            _cities.add(citynames.toString());
          }
        });
      });
    });
    return _cities;
  }

  void _onSelectedCountry(String value) {
    if (!mounted) return;
    setState(() {
      _selectedState = "Choose State";
      _states = ["Choose State"];
      _selectedCountry = value;
      this.widget.onCountryChanged(value);
      getState();
    });
  }

  void _onSelectedState(String value) {
    if (!mounted) return;
    setState(() {
      _selectedCity = "Choose City";
      _cities = ["Choose City"];
      _selectedState = value;
      this.widget.onStateChanged(value);
      getCity();
    });
  }

  void _onSelectedCity(String value) {
    if (!mounted) return;
    setState(() {
      _selectedCity = value;
      this.widget.onCityChanged(value);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        InputDecorator(
          decoration: widget.decoration,
          child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
            dropdownColor: widget.dropdownColor,
            isExpanded: true,
            items: _country.map((String dropDownStringItem) {
              return DropdownMenuItem<String>(
                value: dropDownStringItem,
                child: Row(
                  children: [
                    Text(
                      dropDownStringItem,
                      style: widget.style,
                    )
                  ],
                ),
              );
            }).toList(),
            // onTap: ,
            onChanged: (value) => _onSelectedCountry(value!),
            onTap: widget.onCountryTap,
            value: _selectedCountry,
          )),
        ),
        SizedBox(
          height: widget.spacing,
        ),
        InputDecorator(
          decoration: widget.decoration,
          child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
            dropdownColor: widget.dropdownColor,
            isExpanded: true,
            items: _states.map((String dropDownStringItem) {
              return DropdownMenuItem<String>(
                value: dropDownStringItem,
                child: Row(
                  children: [
                    Text(
                      dropDownStringItem,
                      style: widget.style,
                    )
                  ],
                ),
              );
            }).toList(),
            onChanged: (value) => _onSelectedState(value!),
            onTap: widget.onStateTap,
            value: _selectedState,
          )),
        ),
        SizedBox(
          height: widget.spacing,
        ),
        InputDecorator(
          decoration: widget.decoration,
          child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
            dropdownColor: widget.dropdownColor,
            isExpanded: true,
            items: _cities.map((String dropDownStringItem) {
              return DropdownMenuItem<String>(
                value: dropDownStringItem,
                child: Row(
                  children: [
                    Text(
                      dropDownStringItem,
                      style: widget.style,
                    )
                  ],
                ),
              );
            }).toList(),
            onChanged: (value) => _onSelectedCity(value!),
            onTap: widget.onCityTap,
            value: _selectedCity,
          )),
        ),
      ],
    );
  }
}
