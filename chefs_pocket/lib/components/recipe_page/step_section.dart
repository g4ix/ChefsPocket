import 'package:flutter/material.dart';
import 'package:chefs_pocket/models/recipe.dart';

class StepSection extends StatefulWidget {

  final Recipe recipe;

  const StepSection({required this.recipe});

  @override
  _StepSectionState createState() => _StepSectionState();
}

class _StepSectionState extends State<StepSection> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Steps',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: Color(0xFF557F9F),
                      fontWeight: FontWeight.bold,
                    ),
              ),
              IconButton(
                icon: Icon(Icons.add),
                onPressed: () {},
              ),
            ],
          ),
          Container(
            margin: EdgeInsets.only(top: 10),
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: 5,
              itemBuilder: (context, index) {
                return Container(
                  margin: EdgeInsets.only(bottom: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Step $index',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {},
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}