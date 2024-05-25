class Ingredient {
  String name = "";
  double quantity = 0.0;
  String unit = "";

  Ingredient({
    this.quantity = 0.0,
    this.unit = '',
    this.name = '',
  });

  void convertToEuunits() {
    if (unit == "tbsp") {
      unit = "ml";
      quantity = double.parse((quantity * 15).toStringAsFixed(2));
    } else if (unit == "tsp") {
      unit = "ml";
      quantity = double.parse((quantity * 5).toStringAsFixed(2));
    } else if (unit == "cup") {
      unit = "ml";
      quantity = double.parse((quantity * 240).toStringAsFixed(2));
    } else if (unit == "fl oz") {
      unit = "ml";
      quantity = double.parse((quantity * 29).toStringAsFixed(2));
    } else if (unit == "gal") {
      unit = "ml";
      quantity = double.parse((quantity * 3840).toStringAsFixed(2));
    } else if (unit == "lb") {
      unit = "g";
      quantity = double.parse((quantity * 453).toStringAsFixed(2));
    } else if (unit == "oz") {
      unit = "g";
      quantity = double.parse((quantity * 28).toStringAsFixed(2));
    }
  }

  void convertToUsunits() {
    if (unit == "ml") {
      unit = "tbsp";
      quantity = double.parse((quantity / 15).toStringAsFixed(2));
    } else if (unit == "g") {
      unit = "oz";
      quantity = double.parse((quantity / 28.3495).toStringAsFixed(2));
    } else if (unit == "kg") {
      unit = "lb";
      quantity = double.parse((quantity / 453).toStringAsFixed(2));
    } else if (unit == "l") {
      unit = "gal";

      quantity = double.parse((quantity / 3840).toStringAsFixed(2));
    }
  }

  void convertPortions(int newPortions, int oldPortions) {
    double ratio = newPortions / oldPortions;

    quantity = double.parse((quantity * ratio).toStringAsFixed(2));
  }
}
