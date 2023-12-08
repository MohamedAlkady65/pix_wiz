class FilterOptionsValues {
  FilterOptionsValues() : choice = FilterOptionsChoices.none;
  FilterOptionsChoices choice;
  double? brightnessValue;
}

enum FilterOptionsChoices {
  none,
  brightness,
}
