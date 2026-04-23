library country_state_city_picker_nona;

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:dropdown_search/dropdown_search.dart';
import 'model/select_status_model.dart' as status_model;

enum PickerType { material, cupertino, adaptive }

class SelectState extends StatefulWidget {
  final ValueChanged<String>? onCountryChanged;
  final ValueChanged<String>? onStateChanged;
  final ValueChanged<String>? onCityChanged;

  /// Callback that returns the selected country model
  final ValueChanged<status_model.StatusModel>? onCountrySelected;

  /// Callback that returns the selected state model
  final ValueChanged<status_model.State>? onStateSelected;

  /// Callback that returns the selected city model
  final ValueChanged<status_model.City>? onCitySelected;

  final TextStyle? style;
  final TextStyle? hintStyle;
  final Color? dropdownColor;
  final InputDecoration? decoration;
  final double spacing;

  /// Initial selected values
  final String? defaultValue;
  final String? defaultState;
  final String? defaultCity;

  /// Custom hints
  final String countryHint;
  final String stateHint;
  final String cityHint;

  /// Visibility controls
  final bool hideCountry;
  final bool hideState;
  final bool hideCity;
  final bool showFlag;

  /// Search configuration
  final bool showSearch;

  /// Picker style: material, cupertino, or adaptive
  final PickerType pickerType;

  const SelectState({
    Key? key,
    this.onCountryChanged,
    this.onStateChanged,
    this.onCityChanged,
    this.onCountrySelected,
    this.onStateSelected,
    this.onCitySelected,
    this.decoration,
    this.spacing = 10.0,
    this.style,
    this.hintStyle,
    this.dropdownColor,
    this.defaultValue,
    this.defaultState,
    this.defaultCity,
    this.countryHint = "Choose Country",
    this.stateHint = "Choose State/Province",
    this.cityHint = "Choose City",
    this.hideCountry = false,
    this.hideState = false,
    this.hideCity = false,
    this.showFlag = true,
    this.showSearch = true,
    this.pickerType = PickerType.material,
  }) : super(key: key);

  @override
  _SelectStateState createState() => _SelectStateState();
}

class _SelectStateState extends State<SelectState> {
  List<status_model.StatusModel> _allCountries = [];
  List<status_model.State> _states = [];
  List<status_model.City> _cities = [];

  status_model.StatusModel? _selectedCountry;
  status_model.State? _selectedState;
  status_model.City? _selectedCity;

  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    try {
      var res = await rootBundle.loadString(
          'packages/country_state_city_picker/lib/assets/country.json');
      List<dynamic> data = jsonDecode(res);
      _allCountries =
          data.map((item) => status_model.StatusModel.fromJson(item)).toList();

      if (widget.defaultValue != null) {
        try {
          _selectedCountry = _allCountries.firstWhere(
            (c) =>
                c.name == widget.defaultValue ||
                (widget.showFlag &&
                    "${c.emoji}    ${c.name}" == widget.defaultValue),
          );
          _states = _selectedCountry?.state ?? [];

          if (widget.defaultState != null) {
            _selectedState = _states.firstWhere(
              (s) => s.name == widget.defaultState,
            );
            _cities = _selectedState?.city ?? [];

            if (widget.defaultCity != null) {
              _selectedCity = _cities.firstWhere(
                (c) => c.name == widget.defaultCity,
              );
            }
          }
        } catch (_) {
          // If default value not found, just leave as null
        }
      }

      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    } catch (e) {
      debugPrint("Error loading country data: $e");
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  void _onCountryChanged(status_model.StatusModel? value) {
    if (value == null) return;
    setState(() {
      _selectedCountry = value;
      _states = value.state ?? [];
      _selectedState = null;
      _cities = [];
      _selectedCity = null;
    });

    final displayString =
        widget.showFlag ? "${value.emoji}    ${value.name}" : value.name ?? "";
    widget.onCountryChanged?.call(displayString);
    widget.onCountrySelected?.call(value);

    // Reset state and city in parent
    widget.onStateChanged?.call("");
    widget.onCityChanged?.call("");
  }

  void _onStateChanged(status_model.State? value) {
    if (value == null) return;
    setState(() {
      _selectedState = value;
      _cities = value.city ?? [];
      _selectedCity = null;
    });
    widget.onStateChanged?.call(value.name ?? "");
    widget.onStateSelected?.call(value);

    // Reset city in parent
    widget.onCityChanged?.call("");
  }

  void _onCityChanged(status_model.City? value) {
    if (value == null) return;
    setState(() {
      _selectedCity = value;
    });
    widget.onCityChanged?.call(value.name ?? "");
    widget.onCitySelected?.call(value);
  }

  DropDownDecoratorProps _getDecoratorProps(String hint) {
    return DropDownDecoratorProps(
      decoration: (widget.decoration ?? const InputDecoration()).copyWith(
        labelText: hint,
        hintText: hint,
        labelStyle: widget.hintStyle ??
            const TextStyle(color: Colors.grey, fontSize: 14),
        hintStyle: widget.hintStyle ??
            const TextStyle(color: Colors.grey, fontSize: 14),
        contentPadding: const EdgeInsets.fromLTRB(12, 12, 0, 12),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }

  Widget _buildDropdown<T>({
    required BuildContext context,
    required List<T> items,
    required String Function(T) itemAsString,
    required T? selectedItem,
    required void Function(T?) onSelected,
    required String hint,
    required String searchHint,
    bool enabled = true,
  }) {
    final materialTextFieldProps = TextFieldProps(
      decoration: InputDecoration(
        hintText: searchHint,
        prefixIcon: const Icon(Icons.search),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );

    final cupertinoTextFieldProps = CupertinoTextFieldProps(
      placeholder: searchHint,
      prefix: const Padding(
        padding: EdgeInsets.only(left: 8.0),
        child: Icon(CupertinoIcons.search, size: 20),
      ),
    );

    final decoratorProps = _getDecoratorProps(hint);

    switch (widget.pickerType) {
      case PickerType.cupertino:
        return CupertinoDropdownSearch<T>(
          items: (filter, loadProps) => items,
          itemAsString: itemAsString,
          selectedItem: selectedItem,
          onSelected: onSelected,
          enabled: enabled,
          popupProps: CupertinoPopupProps<T>.menu(
            showSearchBox: widget.showSearch,
            searchFieldProps: cupertinoTextFieldProps,
          ),
          decoratorProps: decoratorProps,
        );
      case PickerType.adaptive:
        return AdaptiveDropdownSearch<T>(
          context: context,
          items: (filter, loadProps) => items,
          itemAsString: itemAsString,
          selectedItem: selectedItem,
          onSelected: onSelected,
          enabled: enabled,
          popupProps: AdaptivePopupProps<T>(
            materialProps: PopupProps<T>.menu(
              showSearchBox: widget.showSearch,
              searchFieldProps: materialTextFieldProps,
            ),
            cupertinoProps: CupertinoPopupProps<T>.menu(
              showSearchBox: widget.showSearch,
              searchFieldProps: cupertinoTextFieldProps,
            ),
          ),
          decoratorProps: decoratorProps,
        );
      case PickerType.material:
        return DropdownSearch<T>(
          items: (filter, loadProps) => items,
          itemAsString: itemAsString,
          selectedItem: selectedItem,
          onSelected: onSelected,
          enabled: enabled,
          popupProps: PopupProps<T>.menu(
            showSearchBox: widget.showSearch,
            searchFieldProps: materialTextFieldProps,
          ),
          decoratorProps: decoratorProps,
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator.adaptive());
    }

    return Column(
      children: [
        if (!widget.hideCountry) ...[
          _buildDropdown<status_model.StatusModel>(
            context: context,
            items: _allCountries,
            itemAsString: (item) => widget.showFlag
                ? "${item.emoji}    ${item.name}"
                : item.name ?? "",
            selectedItem: _selectedCountry,
            onSelected: _onCountryChanged,
            hint: widget.countryHint,
            searchHint: "Search country...",
          ),
          SizedBox(height: widget.spacing),
        ],
        if (!widget.hideState) ...[
          _buildDropdown<status_model.State>(
            context: context,
            items: _states,
            itemAsString: (item) => item.name ?? "",
            selectedItem: _selectedState,
            onSelected: _onStateChanged,
            hint: widget.stateHint,
            searchHint: "Search state...",
            enabled: _selectedCountry != null,
          ),
          SizedBox(height: widget.spacing),
        ],
        if (!widget.hideCity) ...[
          _buildDropdown<status_model.City>(
            context: context,
            items: _cities,
            itemAsString: (item) => item.name ?? "",
            selectedItem: _selectedCity,
            onSelected: _onCityChanged,
            hint: widget.cityHint,
            searchHint: "Search city...",
            enabled: _selectedState != null,
          ),
        ],
      ],
    );
  }
}
