class GroceryList {
  String title = "";
  List<String> elements = []; 
  //non so se mettere list di sezioni potrebbe essere complesso quando si aggiungono nuovi ingredienti
  
  String note = "";

  GroceryList({
    this.title = "",
    this.elements = const [],
    this.note = "",
    });
}