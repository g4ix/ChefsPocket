class Step {
  String description = "";
  List<String> imageUrls = [];
  String title = "";
  Duration timer = const Duration(hours: 0, minutes: 0, seconds: 0);

  Step(
      {this.description = "",
      this.imageUrls = const [],
      this.title = "",
      this.timer = const Duration(hours: 0, minutes: 0, seconds: 0)});
      
}
