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
        note: 'Ricordarsi i buoni spesa')
  ];
  int currentListIndex = 0;
  String newIngredient = '';
  final ingredientController = TextEditingController();

  @override
  void initState() {
    super.initState();
    ingredientController.addListener(() {
      newIngredient = ingredientController.text;
    });
  }

  @override
  void dispose() {
    ingredientController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
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
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.info_outline),
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text('Eliminare un elemento'),
                    content: Text(
                        'Per eliminare un elemento dalla lista, fai swipe da destra verso sinistra su di esso.'),
                    actions: <Widget>[
                      TextButton(
                        child: Text('Chiudi'),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ],
      ),
      drawer: buildDrawer(),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: <Widget>[
          buildList(),
          SizedBox(height: MediaQuery.of(context).size.height * 0.02),
          buildIngredientField(),
          SizedBox(height: MediaQuery.of(context).size.height * 0.02),
          buildReminder(),
        ],
      ),
    );
  }

  Widget buildIngredientField() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.72,
          child: TextField(
            controller: ingredientController, // Usa il controller qui

            onChanged: (value) {
              newIngredient = value;
            },
            style: TextStyle(
              color: Color(0xFF557F9F),
            ),
            decoration: InputDecoration(
              hintText: 'Mele',
              hintStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontSize: 18, color: Color(0xFF557F9F).withOpacity(0.5)),
            ),
          ),
        ),
        IconButton(
          icon: Icon(Icons.add),
          onPressed: () {
            if (newIngredient.isNotEmpty) {
              setState(() {
                groceryLists[currentListIndex].elements.add(newIngredient);
                ingredientController.clear();
              });
            }
          },
        ),
      ],
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
        SizedBox(height: MediaQuery.of(context).size.height * 0.02),
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
                content: Text("$ingredient eliminato"),
                action: SnackBarAction(
                  label: "ANNULLA",
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

  Widget buildDrawer() {
    return Drawer(
      child: Container(
        decoration: BoxDecoration(
          color: Color(0xFFFFFDF4),
          image: DecorationImage(
            image:
                AssetImage("assets/background/grocery_drawer_background.png"),
            fit: BoxFit.contain,
          ),
        ),
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
                trailing: IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('Eliminare lista'),
                          content: Text(
                              'Sei sicuro di voler eliminare questa lista?'),
                          actions: <Widget>[
                            TextButton(
                              child: Text('Annulla'),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                            TextButton(
                              child: Text('Elimina'),
                              onPressed: () {
                                setState(() {
                                  groceryLists.removeAt(index);
                                  if (currentListIndex >= groceryLists.length) {
                                    currentListIndex = groceryLists.length - 1;
                                  }
                                  Navigator.of(context).pop();
                                });
                              },
                            ),
                          ],
                        );
                      },
                    );
                  },
                ),
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
      height: MediaQuery.of(context).size.height * 0.2,
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
              height: MediaQuery.of(context).size.height *
                  0.01), // Aggiungi un po' di spazio tra il titolo e la nota
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
