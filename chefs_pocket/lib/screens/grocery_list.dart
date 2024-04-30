import 'package:flutter/material.dart';

class GroceryListScreen extends StatefulWidget {
  const GroceryListScreen({super.key});

  @override
  _GroceryListScreenState createState() => _GroceryListScreenState();
}

class _GroceryListScreenState extends State<GroceryListScreen> {
  Map<String, List<String>> sections = {
    'Carne e affettati': [],
    'Frutta e verdura': [],
    'Latticini': [],
    'Bevande': [],
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Lista 1",
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
            icon: Icon(Icons.add, color: Color(0xFF557F9F), size: 30),
            onPressed: () {
              // implementare la logica aggiungere l'item alla lista

            },
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: <Widget>[
          ...sections.entries
              .map((entry) => buildListSection(entry.key, entry.value))
              .toList(),
          SizedBox(height: 20),
          buildReminder(),
        ],
      ),
    );
  }

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

  Widget buildReminder() {
    bool isEditing = false;
    String note = "Non c'è nulla da ricordare per oggi!";

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
          ]),
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
              IconButton(
                icon: Icon(Icons.edit),
                onPressed: () {
                  setState(() {
                    isEditing = !isEditing;
                  });
                },
              ),
            ],
          ),
          isEditing
              ? TextField(
                  onChanged: (value) {
                    setState(() {
                      note = value;
                    });
                  },
                  decoration: InputDecoration(
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0xFF557F9F),
                      ),
                    ),
                  ),
                )
              : Text(
                  note,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
        ],
      ),
    );
  }
}
