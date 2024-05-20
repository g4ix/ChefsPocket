import 'package:chefs_pocket/models/grocery_list.dart';
import 'package:flutter/material.dart';

class GroceryListScreen extends StatefulWidget {
  const GroceryListScreen({super.key});

  @override
  _GroceryListScreenState createState() => _GroceryListScreenState();
}

class _GroceryListScreenState extends State<GroceryListScreen> {
  String note = "Non c'è nulla da ricordare per oggi!";
  Map<String, bool> ingredientCheckStatus = {};
  String newListName = '';
  List<GroceryList> groceryLists = [
    GroceryList(
        title: 'Lista della spesa',
        elements: ['Pomodori', 'Cipolle', 'Pane', 'Latte'],
        note: 'Comprare il latte')
  ];
  int currentListIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          groceryLists[currentListIndex].title, // Modifica questa linea
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
        ...groceryLists[currentListIndex].elements.map((ingredient) {
          return Dismissible(
            key: ObjectKey(ingredient),
            child: ListTile(
              title: Text(ingredient),
              trailing: Transform.scale(
                scale: 1.3,
                child: Checkbox(
                  shape: CircleBorder(),
                  value: ingredientCheckStatus[ingredient] ?? false,
                  onChanged: (bool? value) {
                    setState(() {
                      ingredientCheckStatus[ingredient] = value!;
                    });
                  },
                  activeColor: Color(0xFF557F9F),
                  checkColor: Colors.white,
                ),
              ),
            ),
            background: Container(
              color: Colors.red,
              child: Icon(Icons.delete, color: Colors.white),
              alignment: Alignment.centerRight,
              padding: EdgeInsets.only(right: 20),
            ),
            onDismissed: (direction) {
              setState(() {
                groceryLists[currentListIndex].elements.remove(ingredient);
              });
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text("$ingredient deleted"),
                action: SnackBarAction(
                  label: "UNDO",
                  textColor: Colors.white,
                  onPressed: () {
                    setState(() {
                      groceryLists[currentListIndex].elements.add(ingredient);
                    });
                  },
                ),
              ));
            },
          );
        }).toList(),
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
            ElevatedButton(
                child: Text('Aggiungi'),
                onPressed: () {
                  setState(() {
                    groceryLists[currentListIndex]
                        .elements
                        .add(newIngredient); // Modifica questa linea
                    ingredientCheckStatus[newIngredient] =
                        false; // Imposta lo stato iniziale del checkbox su false
                  });
                  Navigator.of(context).pop();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF557F9F),
                  foregroundColor: Color(0xFFFFFDF4),
                )),
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
            ...groceryLists.asMap().entries.map((entry) {
              int index = entry.key;
              GroceryList list = entry.value;
              return ListTile(
                leading: Icon(Icons.list),
                title: Text(list.title),
                onTap: () {
                  Navigator.of(context).pop();
                  setState(() {
                    currentListIndex = index;
                  });
                },
              );
            }).toList(),
            ListTile(
              leading: Icon(Icons.add),
              title: Text('Nuova lista'),
              onTap: () {
                _createNewList();
              },
            ),
            // Aggiungi più ListTile per ogni lista che hai
          ],
        ),
      ),
    );
  }

  void _createNewList() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Crea nuova lista'),
          content: TextField(
            onChanged: (value) {
              newListName = value;
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
              child: Text('Crea'),
              onPressed: () {
                setState(() {
                  Navigator.of(context).pop();
                  groceryLists.add(
                      GroceryList(title: newListName, elements: [], note: ''));
                });
              },
            ),
          ],
        );
      },
    );
  }

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
            groceryLists[currentListIndex].note, // Modifica questa linea
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
        String newNote =
            groceryLists[currentListIndex].note; // Modifica questa linea
        TextEditingController textEditingController = TextEditingController(
            text: groceryLists[currentListIndex].note); // Modifica questa linea

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
                  groceryLists[currentListIndex].note =
                      newNote; // Modifica questa linea
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
