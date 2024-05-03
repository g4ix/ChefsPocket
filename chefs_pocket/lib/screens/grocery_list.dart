import 'package:flutter/material.dart';

class GroceryListScreen extends StatefulWidget {
  const GroceryListScreen({super.key});

  @override
  _GroceryListScreenState createState() => _GroceryListScreenState();
}

class _GroceryListScreenState extends State<GroceryListScreen> {
  List<String> ingredients = [];
  String note = "Non c'è nulla da ricordare per oggi!";
  bool _isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Lista 1",
          style: Theme.of(context).textTheme.titleMedium,
        ),
        leading: Builder(
          builder: (context) => IconButton(
            icon: Icon(Icons.menu, color: Color(0xFF557F9F), size: 30),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.add, color: Color(0xFF557F9F), size: 30),
            onPressed: () {
              setState(() {
                _addIngredient();
              });
            },
          ),
        ],
      ),
      drawer: buildDrawer(),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: <Widget>[
          buildList(),
          SizedBox(height: 20),
          buildReminder(),
        ],
      ),
    );
  }

  Widget buildList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Ingredienti',
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: Color(0xFF557F9F),
                fontWeight: FontWeight.bold,
              ),
        ),
        ...ingredients
            .map((ingredient) => ListTile(
                  title: Text(ingredient),
                  trailing: Checkbox(
                    shape: CircleBorder(),
                    value: _isChecked,
                    onChanged: (bool? value) {
                      setState(() {
                        _isChecked = value!;
                      });
                    },
                    activeColor: Color(0xFF557F9F),
                    checkColor: Colors.white,
                  ),
                ))
            .toList(),
      ],
    );
  }

  void _addIngredient() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        String newIngredient = '';

        return AlertDialog(
          title: Text('Aggiungi ingrediente'),
          content: TextField(
            onChanged: (value) {
              newIngredient = value;
            },
          ),
          actions: [
            TextButton(
              child: Text('Annulla'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Aggiungi'),
              onPressed: () {
                setState(() {
                  ingredients.add(newIngredient);
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Widget buildDrawer() {
    return Drawer(
      child: Container(
        color: Color(0xFFFFFDF4), // Set the background color of the drawer
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Color(0xFF557F9F),
              ),
              child: Text(
                'Le tue liste',
                style: TextStyle(
                  color: Color(0xFFFFFDF4),
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.list),
              title: Text('Lista 1'),
              onTap: () {
                // Aggiungi la logica per passare alla Lista 1
              },
            ),
            ListTile(
              leading: Icon(Icons.list),
              title: Text('Lista 2'),
              onTap: () {
                // Aggiungi la logica per passare alla Lista 2
              },
            ),
            // Aggiungi più ListTile per ogni lista che hai
          ],
        ),
      ),
    );
  }

/** LISTA CON SEZIONI 
  Widget buildListSection(String title, List<String> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: Color(0xFF557F9F),
                fontWeight: FontWeight.bold,
              ),
        ),
        ...items.map((item) => Text(item)).toList(),
        ListTile(
          title: TextField(
            onSubmitted: (value) {
              setState(() {
                items.add(value);
              });
            },
            decoration: InputDecoration(
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Color(0xFF557F9F),
                ),
              ),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Color(0xFF557F9F),
                ),
              ),
            ),
          ),
          trailing: Checkbox(
            shape: CircleBorder(),
            value: false,
            onChanged: (newValue) {
              setState(() {
                // implementare la logica per gestire il cambio di stato del checkbox
              });
            },
            fillColor: MaterialStateColor.resolveWith((states) {
              if (states.contains(MaterialState.selected)) {
                return Color(0xFF557F9F);
              }
              return Colors.white;
            }),
            checkColor: Colors.white,
          ),
        ),
      ],
    );
  }
  */

  Widget buildReminder() {
    return Container(
      padding: const EdgeInsets.all(16.0),
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      height: 200,
      decoration: BoxDecoration(
        color: Color(0xFFFFFED9),
        borderRadius: BorderRadius.circular(20.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 5,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Da ricordare oggi",
                style: Theme.of(context).textTheme.titleMedium,
              ),
              GestureDetector(
                onTap: () {
                  _editNote();
                },
                child: Icon(
                  Icons.edit,
                  color: Color(0xFF557F9F),
                ),
              ),
            ],
          ),
          SizedBox(
              height: 10), // Aggiungi un po' di spazio tra il titolo e la nota
          Text(
            note,
            style: Theme.of(context).textTheme.bodyMedium,
          )
        ],
      ),
    );
  }

  void _editNote() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        String newNote = note;
        TextEditingController textEditingController =
            TextEditingController(text: note);

        return AlertDialog(
          title: Text('Modifica note'),
          content: TextField(
            onChanged: (value) {
              newNote = value;
            },
            controller: textEditingController,
          ),
          actions: [
            TextButton(
              child: Text('Annulla'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Salva'),
              onPressed: () {
                setState(() {
                  note = newNote;
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
