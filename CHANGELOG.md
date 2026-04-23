## [2.0.0] - 2026/04/23
* Updated for Dart 3 and Flutter 3 compatibility.
* Migrated to `dropdown_search` v7.
* Added Support for **Cupertino and Adaptive UI** (`pickerType`).
* Added **Default Value** support for Country, State, and City.
* Added **Custom Hints** and **Hint Styles**.
* Added **Model-based callbacks** (`onCountrySelected`, etc.) to return full data objects.
* Added visibility controls to hide specific pickers (`hideCountry`, `hideState`, `hideCity`).
* Added option to show/hide country flags (`showFlag`).
* Added option to enable/disable search functionality (`showSearch`).
* Refactored data loading to load assets only once, improving performance.
* Updated example app and documentation.

## [1.0.1] - 2022/01/04
* State changed to State/Province, textOverflow solved

## [1.0.0] - 2021/12/24
* Added support for customizing dropdown button style and spacing between buttons. Null Safety included

## [1.2.7] - 2021/02/05
* Updated the dropdown list text and background to be customizable through the additional "style" and "dropdownColor" properties.

## [1.2.6] - 2021/01/29
* Included Mounted check prior to calling setState() to prevent exception thrown if setState() is called when the Widget has been disposed.

## [1.2.5] - 2021/01/17
* Inclusion of Cities in Rivers State of Nigeria 

## [1.2.4] - 2020/12/07.
* Inclusion of Rivers State in Nigeria and Display Images, Flags Added to Country

## [1.1.0] - 2020/12/05.
* Initial release.