import 'package:chefs_pocket/components/recipe_page/step_card.dart';
import 'package:chefs_pocket/config.dart';
import 'package:chefs_pocket/models/recipe.dart';
import 'package:chefs_pocket/screens/step_screen.dart';
import 'package:flutter/material.dart';
import 'package:chefs_pocket/models/recipe.dart';

class StepSection extends StatefulWidget {
  final Recipe recipe;

  const StepSection({required this.recipe});

  @override
  _StepSectionState createState() => _StepSectionState();
}

class _StepSectionState extends State<StepSection> {
  Recipe recipe = mockRecipes[2];
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          margin: EdgeInsets.only(top: 10),
          child: Column(
            children: [
              Text(
                  "Tempo totale ${recipe.totalTime.inHours}:${(recipe.totalTime.inMinutes % 60).toString().padLeft(2, '0')} h",
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: Color(0xFF557F9F), // Specify the desired color
                      )),

              //for each step in the recipe, create a step_Card
              Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: recipe.steps.length,
                  itemBuilder: (context, index) {
                    return StepCard(
                      recipe: recipe,
                      pos: index,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => StepScreen(steps: widget.recipe.steps)),
                );
              },
              child: Text(
                'Inizia a cucinare!',
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(color: Colors.white),
              ),
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Color(0xFF557F9F),
                disabledForegroundColor: Color(0xFFF557F9F),
                disabledBackgroundColor: Colors.white,
                padding: EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
