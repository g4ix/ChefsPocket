class Ingredient {
  String name = "";
  double quantity = 0.0;
  String measure = "";

  Ingredient({
    this.quantity = 0.0,
    this.measure = '',
    this.name = '',
  });

  void convertToEuMeasures() {
    if (measure == "tbsp") {
      measure = "ml";
      quantity *= 15;
    } else if (measure == "tsp") {
      measure = "ml";
      quantity *= 5;
    } else if (measure == "cup") {
      measure = "ml";
      quantity *= 240;
    } else if (measure == "fl oz") {
      measure = "ml";
      quantity *= 30;
    } else if (measure == "gal") {
      measure = "ml";
      quantity *= 3840;
    } else if (measure == "lb") {
      measure = "g";
      quantity *= 453.592;
    } else if (measure == "oz") {
      measure = "g";
      quantity *= 28.3495;
    }
  }

  void convertToUsMeasures() {
    if (measure == "ml") {
      measure = "tbsp";
      quantity /= 15;
    } else if (measure == "g") {
      measure = "oz";
      quantity /= 28.3495;
    } else if (measure == "kg") {
      measure = "lb";
      quantity /= 0.453592;
    } else if (measure == "l") {
      measure = "gal";
      quantity /= 3840;
    }
  }
}
