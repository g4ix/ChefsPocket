// import 'package:chefs_pocket/models/recipe.dart';
// import 'package:flutter/material.dart';

// class Build_title_input extends StatefulWidget {
//   @override
//   _Build_title_inputState createState() => _Build_title_inputState();
// }

// class _Build_title_inputState extends State<Build_title_input> {
//   Recipe recipe = Recipe();

//   @override
//   Widget build(BuildContext context) {
//     return  Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           'Titolo',
//           style: Theme.of(context).textTheme.bodyLarge?.copyWith(
//                 color: Color(0xFF557F9F), // Specify the desired color
//               ),
//         ),
//         SizedBox(height: 8),
//         TextFormField(
//           decoration:  InputDecoration(
//             hintStyle: Theme.of(context).textTheme.bodyMedium,
//             hintText: 'Inserisci il titolo',
//             focusedBorder: OutlineInputBorder(
//               borderSide: BorderSide(color: Color(0xFF557F9F), width: 2.0),
//             ),
//             enabledBorder: OutlineInputBorder(
//               borderSide: BorderSide(color: Color(0xFF557F9F), width: 2.0),
//             ),
//           ),
//           validator: (value) {
//             if (value == null || value.isEmpty) {
//               return 'Inserisci un titolo';
//             }
//             return null;
//           },
//           onChanged: (value) =>
//               widget.recipe.setTitle(value), // Update recipe title
//         ),
//       ],
//     );
//   }
//   }
