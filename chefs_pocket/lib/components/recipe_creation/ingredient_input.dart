import 'package:chefs_pocket/models/ingredient.dart';
import 'package:flutter/material.dart';

class IngredientInput extends StatefulWidget {
  Ingredient ingredient;
  Function remove;
  final TextEditingController controller;
  final List<String> units;

  IngredientInput(
      {required this.ingredient,
      required this.controller,
      required this.units,
      required this.remove});

  @override
  State<IngredientInput> createState() => _IngredientInputState();
}

class _IngredientInputState extends State<IngredientInput> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: 60,
            child: TextFormField(
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium,
              decoration: InputDecoration(
                focusedErrorBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFF557F9F), width: 1.0),
                  borderRadius: BorderRadius.circular(
                      10.0), // make this the same or smaller than the borderRadius for enabledBorder and focusedBorder
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFF557F9F), width: 1.0),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFF557F9F), width: 1.0),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                hintStyle: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(color: Colors.grey, fontSize: 14),
                hintText: '500',

                contentPadding: EdgeInsets.symmetric(
                    vertical: 2), // Decrease the vertical padding
              ),
              controller: widget.controller,
            ),
          ),
          SizedBox(width: 8),
          SizedBox(
            width: 70,
            child: DropdownButtonFormField(
              borderRadius: BorderRadius.circular(10),
              value: widget.ingredient.unit,
              items: widget.units.map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value,
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.copyWith(color: Colors.grey)),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  widget.ingredient.unit = value!;
                });
              },
              decoration: InputDecoration(
                hintStyle: Theme.of(context).textTheme.bodyMedium,
                contentPadding: EdgeInsets.fromLTRB(12, 12, 0, 0),
                focusedErrorBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFF557F9F), width: 1.0),
                  borderRadius: BorderRadius.circular(
                      10.0), // make this the same or smaller than the borderRadius for enabledBorder and focusedBorder
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFF557F9F), width: 1.0),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFF557F9F), width: 1.0),
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              isExpanded: false, // Set isExpanded to false
            ),
          ),
          SizedBox(width: 8),
          Expanded(
            child: TextFormField(
              onChanged: (value) {
                setState(() {
                  widget.ingredient.name = value;
                });
              },
              decoration: InputDecoration(
                hintStyle: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(color: Colors.grey),
                hintText: 'Farina',
                focusedErrorBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFF557F9F), width: 1.0),
                  borderRadius: BorderRadius.circular(
                      10.0), // make this the same or smaller than the borderRadius for enabledBorder and focusedBorder
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFF557F9F), width: 1.0),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFF557F9F), width: 1.0),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                contentPadding: EdgeInsets.symmetric(
                    horizontal: 10), // Decrease the vertical padding
              ),
            ),
          ),
          IconButton(
            onPressed: () {
              setState(() {
                widget.remove(widget.ingredient);
              });
            },
            icon: Icon(Icons.delete),
            iconSize: 25,
            color: Color(0xFF557F9F),
          ),
        ],
      ),
    );
  }
}
