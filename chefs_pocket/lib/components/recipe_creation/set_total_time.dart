import 'package:chefs_pocket/models/recipe.dart';
import 'package:flutter/material.dart';

class SetTotalTime extends StatelessWidget {
  final Function onChangedHour;
  final Function onChangedMinutes;

  const SetTotalTime({
    required this.onChangedHour,
    required this.onChangedMinutes,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text('Tempo totale',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: Color(0xFF557F9F), 
                )),
        SizedBox(width: 10),
        Expanded(
          child: TextFormField(
            decoration: InputDecoration(
              labelText: 'Ore',
              border: OutlineInputBorder(),
            ),
            keyboardType: TextInputType.number,
            onChanged: (value) 
            {
              onChangedHour(value);
            }
          ),
        ),
        SizedBox(width: 10),
        Expanded(
          child: TextFormField(
            decoration: InputDecoration(
              labelText: 'Minuti',
              border: OutlineInputBorder(),
            ),
            keyboardType: TextInputType.number,
            onChanged: (value) {
              onChangedMinutes(value);
            },
          ),
        ),
      ],
    );
  }
}
