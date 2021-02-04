# country_state_city_picker

A flutter package for showing a country, states, and cities. In addition it gives the possibility to select a list of countries, States and Cities depends on Selected.

<div style="text-align:center">
<img src="https://raw.githubusercontent.com/prof22/country_state_city_picker/main/screenshot/Screenshot2.jpg" width="240"/>
</div>
<img src="https://raw.githubusercontent.com/prof22/country_state_city_picker/main/screenshot/Screenshot3.jpg" width="240"/>
<img src="https://raw.githubusercontent.com/prof22/country_state_city_picker/main/screenshot/Screenshot4.jpg" width="240"/>
<img src="https://raw.githubusercontent.com/prof22/country_state_city_picker/main/screenshot/Screenshot5.jpg" width="240"/>
<img src="https://raw.githubusercontent.com/prof22/country_state_city_picker/main/screenshot/Screenshot6.jpg" width="240"/>
<img src="https://raw.githubusercontent.com/prof22/country_state_city_picker/main/screenshot/Screenshot7.jpg" width="240"/>
<img src="https://raw.githubusercontent.com/prof22/country_state_city_picker/main/screenshot/Screenshot1.jpg" width="240"/>

## Usage

To use this Package, add `country_state_city_picker` as a [dependency in your pubspec.yaml](https://flutter.io/platform-plugins/).

```dart
     SelectState(
              onCountryChanged: (value) {
              setState(() {
                countryValue = value;
              });
            },
            onStateChanged:(value) {
              setState(() {
                stateValue = value;
              });
            },
             onCityChanged:(value) {
              setState(() {
                cityValue = value;
              });
            },
            
            ),
```

To call feedback or getting data from this widget, you can make function in onChanged

### Example

```dart
import 'package:flutter/material.dart';
import 'package:country_state_city_picker/country_state_city_picker.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Country State and City Picker',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  String countryValue;
  String stateValue;
  String cityValue;
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title: Text('Country State and City Picker'),
      ),
      body:  Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        height: 600,
        child: 
         Column(
          children: [
            SelectState(
              onCountryChanged: (value) {
              setState(() {
                countryValue = value;
              });
            },
            onStateChanged:(value) {
              setState(() {
                stateValue = value;
              });
            },
             onCityChanged:(value) {
              setState(() {
                cityValue = value;
              });
            },
            
            ),
            // InkWell(
            //   onTap:(){
            //     print('country selected is $countryValue');
            //     print('country selected is $stateValue');
            //     print('country selected is $cityValue');
            //   },
            //   child: Text(' Check')
            // )
          ],
        )
      ),
    );
  }
}

```

### Special Thanks

- Darshan Gada, countries-states-cities-database [countries-states-cities-database](https://github.com/dr5hn/countries-states-cities-database)
- Orakpo Jefferson(CEO, Dafesoftware Ltd)
- Mthokozis Mtolo