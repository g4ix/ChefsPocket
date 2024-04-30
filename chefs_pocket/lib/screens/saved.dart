import 'package:flutter/material.dart';

class SavedScreen extends StatefulWidget {
  const SavedScreen({super.key});

  @override
  _SavedScreenState createState() => _SavedScreenState();
}

class _SavedScreenState extends State<SavedScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Salvati",
          style: Theme.of(context).textTheme.titleMedium,
        ),
        leading: IconButton(
          icon: Icon(Icons.menu, color: Color(0xFF557F9F), size: 30),
          onPressed: () {
            // implementare la logica per aprire il drawer
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.mode, color: Color(0xFF557F9F), size: 30),
            onPressed: () {
              // implementare la logica per aprire le impostazioni
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: <Widget>[
            buildSavedRecipe("Pasta al pesto", "assets/images/pasta_pesto.jpg"),
            buildSavedRecipe("Tiramisù", "assets/images/tiramisu.jpg"),
            buildSavedRecipe("Pizza margherita", "assets/images/pizza_margherita.jpg"),
          ],
        ),
      ),
    );
  }

  Widget buildSavedRecipe(String title, String image) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.asset(
              image,
              width: 100,
              height: 100,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                SizedBox(height: 10),
                Text(
                  "30 minuti",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}