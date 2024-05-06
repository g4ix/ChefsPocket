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
      newQuantity = (newQuantity * 15).truncateToDouble();
    } else if (unit == "tsp") {
      newUnit = "ml";
      newQuantity = (newQuantity * 5).truncateToDouble();
    } else if (unit == "cup") {
      newUnit = "ml";
      newQuantity = (newQuantity * 240).truncateToDouble();
    } else if (unit == "fl oz") {
      newUnit = "ml";
      newQuantity =   (newQuantity * 29.5735).truncateToDouble();
    } else if (unit == "gal") {
      newUnit = "ml";
      newQuantity = (newQuantity * 3840).truncateToDouble();
    } else if (unit == "lb") {
      newUnit = "g";
      newQuantity = (newQuantity * 453.592).truncateToDouble();
    } else if (unit == "oz") {
      newUnit = "g";
      newQuantity = (newQuantity * 28.3495).truncateToDouble();
    }
    
    return Ingredient(quantity: newQuantity, unit: newUnit, name: name);

  }

  Ingredient convertToUsunits() {
    String newUnit = unit;
    double newQuantity = quantity;

    if (unit == "ml") {
      newUnit = "tbsp";
      newQuantity = (newQuantity / 15).truncateToDouble();
    } else if (unit == "g") {
      newUnit = "oz";
      newQuantity = (newQuantity / 28.3495).truncateToDouble();
    } else if (unit == "kg") {
      newUnit = "lb";
      newQuantity = (newQuantity / 453.592).truncateToDouble();
    } else if (unit == "l") {
      newUnit = "gal";
      newQuantity = (newQuantity / 3840).truncateToDouble();
    }

    return Ingredient(quantity: newQuantity, unit: newUnit, name: name);
  }
}
