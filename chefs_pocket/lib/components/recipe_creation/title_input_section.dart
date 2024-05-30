import 'package:flutter/material.dart';

class TitleInputSection extends StatelessWidget {

  Function(String) onChangedTitle;

  TitleInputSection(this.onChangedTitle);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Titolo',
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: Color(0xFF557F9F), // Specify the desired color
              ),
        ),
        SizedBox(height: 5),
        TextFormField(
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
              borderRadius: BorderRadius.circular(10.0),
            ),
            hintStyle: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(color: Colors.grey),
            hintText: 'Inserisci il titolo',
          ),
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontSize: 14, 
              ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Inserisci un titolo';
            }
            return null;
          },
          onChanged: onChangedTitle,
        ),
      ],
    );
  }
}
