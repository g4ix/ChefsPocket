class Ingredient {
  String name = "";
  double quantity = 0.0;
  String unit = "";

  Ingredient({
    this.quantity = 0.0,
    this.unit = '',
    this.name = '',
  });

  Ingredient convertToEuunits() {
    String newUnit = unit;
    double newQuantity = quantity;
    if (unit == "tbsp") {
      newUnit = "ml";
      newQuantity = double.parse((newQuantity * 15).toStringAsFixed(2));   
    } else if (unit == "tsp") {
      newUnit = "ml";
      newQuantity = double.parse((newQuantity * 5).toStringAsFixed(2) );
    } else if (unit == "cup") {
      newUnit = "ml";
      newQuantity = double.parse((newQuantity * 240).toStringAsFixed(2));  
    } else if (unit == "fl oz") {
      newUnit = "ml";
      newQuantity =   double.parse((newQuantity * 29).toStringAsFixed(2));
    } else if (unit == "gal") {
      newUnit = "ml";
      newQuantity = double.parse((newQuantity * 3840).toStringAsFixed(2));
    } else if (unit == "lb") {
      newUnit = "g";
      newQuantity = double.parse((newQuantity * 453).toStringAsFixed(2));
    } else if (unit == "oz") {
      newUnit = "g";
      newQuantity = double.parse((newQuantity * 28).toStringAsFixed(2));
    }
    
    return Ingredient(quantity: newQuantity, unit: newUnit, name: name);

  }

  Ingredient convertToUsunits() {
    String newUnit = unit;
    double newQuantity = quantity;

    if (unit == "ml") {
      newUnit = "tbsp";
      newQuantity = double.parse((newQuantity / 15).toStringAsFixed(2));
    } else if (unit == "g") {
      newUnit = "oz";
      newQuantity = double.parse((newQuantity / 28.3495).toStringAsFixed(2));
    } else if (unit == "kg") {
      newUnit = "lb";
      newQuantity = double.parse((newQuantity / 453).toStringAsFixed(2));
    } else if (unit == "l") {
      newUnit = "gal";

      newQuantity = double.parse((newQuantity / 3840).toStringAsFixed(2));
    }

    return Ingredient(quantity: newQuantity, unit: newUnit, name: name);
  }
}
