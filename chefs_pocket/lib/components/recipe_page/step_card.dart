import 'package:chefs_pocket/models/recipe.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class StepCard extends StatelessWidget {
  final Recipe recipe;
  final int pos;

  StepCard({required this.pos, required this.recipe});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        
        elevation: 2,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(recipe.steps[pos].title,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: Color(0xFF557F9F), // Specify the desired color
                      )),
              recipe.steps[pos].imageUrls!.length == 0
                  ? SizedBox()
                  :
              Container(
                height: 100,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: recipe.steps[pos].imageUrls!.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: Image.network(
                          recipe.steps[pos].imageUrls![index],
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height: 16), // Add spacing between the images and text
              Text(
                'Per preparare la pasta per la pizza abbiamo scelto di impastare il tutto a mano, ma se preferite utilizzare l\'impastatrice potrete seguire lo stesso procedimento, utilizzando il gancio a velocità medio bassa. Come prima cosa versate le due farine in una ciotola, sbriciolate il lievito all\'interno e versate un po\' della dose di acqua. La temperatura ideale dell\'acqua è di 25°.',
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
