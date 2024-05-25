import 'package:chefs_pocket/models/recipe.dart';
import 'package:flutter/Material.dart';
import 'package:intl/intl.dart';

class SetPortion extends StatefulWidget {
  final Function onChangedPortion;
  final Recipe recipe;

  const SetPortion({required this.onChangedPortion, required this.recipe});

  @override
  _SetPortionState createState() => _SetPortionState();
}

class _SetPortionState extends State<SetPortion> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          'Porzioni',
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: Color(0xFF557F9F), // Specify the desired color
              ),
        ),
        SizedBox(
          width: 5,
        ),
        SizedBox(
          width: 50,
          height: 35,
          child: TextFormField(
            style: Theme.of(context).textTheme.bodyMedium,
            keyboardType: TextInputType.number,
            initialValue: widget.recipe.portions
                .toString(), // Set the default value to '2'
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
                  borderSide: BorderSide(color: Color(0xFF557F9F), width: 2.0),
                  borderRadius: BorderRadius.circular(10.0)),
              contentPadding: EdgeInsets.symmetric(
                  vertical: 8,
                  horizontal: 10), // Adjust the vertical and horizontal padding
              alignLabelWithHint: true, // Align the label with the input field
            ),
            onChanged: (value) {
              int portion = int.parse(value);
              widget.onChangedPortion(portion);
              widget.recipe.portions = int.parse(value);
            },
          ),
        ),
      ],
    );
  }
}
