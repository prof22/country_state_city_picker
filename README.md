# country_state_city_picker

A highly customizable Flutter package for selecting countries, states, and cities. Updated for Dart 3 and with full support for Material, Cupertino, and Adaptive UI.

<div style="text-align:center">
<img src="https://raw.githubusercontent.com/prof22/country_state_city_picker/main/screenshot/Screenshot2.jpg" width="240"/>
</div>

## Features

- **Material, Cupertino, and Adaptive UI**: Supports native looks for both Android and iOS.
- **Default Values**: Set initial country, state, or city.
- **Highly Customizable**: Custom hints, text styles, and decorations.
- **Model Callbacks**: Get more than just names; get full country/state/city models.
- **Visibility Control**: Hide country, state, or city pickers as needed.
- **Searchable**: Built-in search functionality for long lists.
- **Flag Support**: Option to show or hide country flags.

## Usage

Add `country_state_city_picker` to your `pubspec.yaml`:

```yaml
dependencies:
  country_state_city_picker: ^2.0.0
```

### Basic Usage

```dart
SelectState(
  onCountryChanged: (value) => setState(() => countryValue = value),
  onStateChanged: (value) => setState(() => stateValue = value),
  onCityChanged: (value) => setState(() => cityValue = value),
),
```

### Advanced Usage with New Features

```dart
SelectState(
  // Choose picker style
  pickerType: PickerType.adaptive, // material, cupertino, or adaptive
  
  // Initial values
  defaultValue: 'United States',
  defaultState: 'California',
  defaultCity: 'Los Angeles',
  
  // Custom hints
  countryHint: 'Select Country',
  stateHint: 'Select State',
  cityHint: 'Select City',
  
  // Custom styles
  hintStyle: TextStyle(color: Colors.grey, fontSize: 16),
  
  // Visibility and flags
  showFlag: true,
  hideCountry: false,
  showSearch: true,
  
  // Callbacks with models
  onCountrySelected: (country) => print('Selected: ${country.name}'),
  onStateSelected: (state) => print('Selected: ${state.name}'),
  onCitySelected: (city) => print('Selected: ${city.name}'),
  
  // Standard callbacks (returns strings)
  onCountryChanged: (value) => setState(() => countryValue = value),
  onStateChanged: (value) => setState(() => stateValue = value),
  onCityChanged: (value) => setState(() => cityValue = value),
)
```

### Example App

```dart
import 'package:flutter/material.dart';
import 'package:country_state_city_picker/country_state_city_picker.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.blue, useMaterial3: true),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});
  
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String countryValue = "";
  String stateValue = "";
  String cityValue = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Country State City Picker')),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            SelectState(
              onCountryChanged: (value) => setState(() => countryValue = value),
              onStateChanged: (value) => setState(() => stateValue = value),
              onCityChanged: (value) => setState(() => cityValue = value),
            ),
            const SizedBox(height: 20),
            Text('Selected: $countryValue, $stateValue, $cityValue'),
          ],
        ),
      ),
    );
  }
}
```

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

### Special Thanks

- [countries-states-cities-database](https://github.com/dr5hn/countries-states-cities-database)
- Orakpo Jefferson (CEO, Dafesoftware Ltd)
- Mthokozis Mtolo
- Essangjesse