import 'package:chefs_pocket/models/recipe.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class RatingAndToggle extends StatefulWidget {
  final Function onRatingUpdate;
  final Function onChangedUnits;
  final bool useEuUnits;

  RatingAndToggle(
      {required this.onChangedUnits,
      required this.useEuUnits,
      required this.onRatingUpdate});

  @override
  _RatingAndToggleState createState() => _RatingAndToggleState();
}

class _RatingAndToggleState extends State<RatingAndToggle> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  SizedBox(height: 10),
                  Text(
                    'Voto',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: Color(0xFF557F9F), // Specify the desired color
                        ),
                  ),
                  SizedBox(width: 8),
                  RatingBar.builder(
                      initialRating: 3,
                      minRating: 1,
                      direction: Axis.horizontal,
                      allowHalfRating: true,
                      itemCount: 5,
                      itemSize: MediaQuery.of(context).size.width /
                          15, // Set the size of the stars
                      itemPadding: EdgeInsets.symmetric(
                          horizontal:
                              0), // Decrease the itemPadding value to make the stars closer
                      itemBuilder: (context, _) => Icon(Icons.star,
                          color: Color(0xFF557F9F),
                          size: 10), // Set the size of the stars
                      onRatingUpdate: (value) {
                        widget.onRatingUpdate(value);
                      }),
                ],
              ),
            ],
          ),
        ),
        SizedBox(width: 30),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('US', style: Theme.of(context).textTheme.bodyMedium),
            Switch(
              value: widget.useEuUnits,
              onChanged: (value) {
                widget.onChangedUnits(value);
              },
              activeTrackColor: Color(0xFF557F9F),
              activeColor: Colors.white,
              inactiveTrackColor: Color(0xFF557F9F),
              inactiveThumbColor: Colors.white,
              thumbIcon: MaterialStateProperty.resolveWith<Icon?>(
                (states) {
                  return null; // Torna al tuo codice qui
                },
              ),
            ),
            Text('EU', style: Theme.of(context).textTheme.bodyMedium),
          ],
        )
      ],
    );
  }
}
