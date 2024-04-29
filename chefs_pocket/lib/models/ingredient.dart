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
      quantity *= 15;
    } else if (unit == "tsp") {
      unit = "ml";
      quantity *= 5;
    } else if (unit == "cup") {
      unit = "ml";
      quantity *= 240;
    } else if (unit == "fl oz") {
      unit = "ml";
      quantity *= 30;
    } else if (unit == "gal") {
      unit = "ml";
      quantity *= 3840;
    } else if (unit == "lb") {
      unit = "g";
      quantity *= 453.592;
    } else if (unit == "oz") {
      unit = "g";
      quantity *= 28.3495;
    }
  }

  void convertToUsunits() {
    if (unit == "ml") {
      unit = "tbsp";
      quantity /= 15;
    } else if (unit == "g") {
      unit = "oz";
      quantity /= 28.3495;
    } else if (unit == "kg") {
      unit = "lb";
      quantity /= 0.453592;
    } else if (unit == "l") {
      unit = "gal";
      quantity /= 3840;
    }
  }
}
