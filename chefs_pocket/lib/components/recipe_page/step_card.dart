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
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
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
                        child: Image.asset(  // Replace with Image.network for network images
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
                recipe.steps[pos].description,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
