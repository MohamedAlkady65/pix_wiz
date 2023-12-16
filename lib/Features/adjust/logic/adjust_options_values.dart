import 'package:colorfilter_generator/addons.dart';
import 'package:colorfilter_generator/colorfilter_generator.dart';

class AdjustOptionsValues {
  AdjustOptionsValues() : choice = AdjustOptionsChoices.none;
  AdjustOptionsChoices choice;
  double? brightnessValue;
  double? saturationValue;
  double? contrastValue;
  double? hueValue;

  List<double> get matrix {
    List<List<double>> filters = [];

    addBrightnessFilter(filters);
    addSaturationFilter(filters);
    addContrastFilter(filters);
    addHueFilter(filters);

    ColorFilterGenerator filtersGenerator =
        ColorFilterGenerator(name: 'filters', filters: filters);

    filtersGenerator.buildMatrix();
    return filtersGenerator.matrix;
  }

  void addBrightnessFilter(List<List<double>> filters) {
    if (brightnessValue == null) return;
    late double value;
    // Balancing bright and dark
    if (brightnessValue! <= 0) {
      value = brightnessValue! / 255 * 100;
    } else {
      value = brightnessValue!;
    }

    // Change Range form [-2.5 , 2.5] to [-100 , 100]
    value = value * 2 / 100;

    filters.add(ColorFilterAddons.brightness(value));
  }

  void addSaturationFilter(List<List<double>> filters) {
    if (saturationValue == null) return;
    late double value;

    value = saturationValue!;

    // Change Range form [0 , 3] to [-0 , 100]
    value = value * 3 / 100;

    filters.add(ColorFilterAddons.saturation(value));
  }

  void addContrastFilter(List<List<double>> filters) {
    if (contrastValue == null) return;
    late double value;

    value = contrastValue!;

    // Change Range form [-1 , 1] to [-100 , 100]
    value = value * 0.5 / 100;

    filters.add(ColorFilterAddons.contrast(value));
  }

  void addHueFilter(List<List<double>> filters) {
    if (hueValue == null) return;
    late double value;

    value = hueValue!;

    // Change Range form [0, 2] to [-0 , 100]
    value = value * 2 / 100;

    filters.add(ColorFilterAddons.hue(value));
  }

  void reset() {
    choice = AdjustOptionsChoices.none;
    brightnessValue = saturationValue = contrastValue = hueValue = null;
  }
}

enum AdjustOptionsChoices { none, brightness, saturation, contrast, hue }
