

import 'package:chefs_pocket/components/recipe_page/build_page.dart';
import 'package:chefs_pocket/components/recipe_page/image_sliders.dart';
import 'package:chefs_pocket/models/recipe_step.dart';
import 'package:flutter/material.dart';


class StepScreen extends StatelessWidget {
  final List<RecipeStep> steps;
  StepScreen({required this.steps});
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
        controller: _pageController,
        itemCount: steps.length,
        itemBuilder: (context, index) {
          return BuildPage(step: steps[index]);
        },
      ),
      floatingActionButton: FloatingActionButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
        ),
        onPressed: () {
          // Vai alla pagina successiva
          if (_pageController.page == steps.length - 1) {
            Navigator.pop(context);
          } else {
            _pageController.nextPage(
              duration: Duration(milliseconds: 500),
              curve: Curves.ease,
            );
          }
        },
        child: Icon(
          Icons.arrow_forward,
          color: Colors.white,
        ),
      ),
    );
  }
}

// Widget buildPage(RecipeStep step) {
//   return Column(
//     children: [
//       ImageSliders(imageUrls: step.imageUrls!),
//       Text(
//         step.title,
//         style: Theme.of(context).textTheme.titleMedium,
//       ),
//       Text(
//         step.description,
//         style: Theme.of(context).textTheme.bodyLarge,
//         ),
      
//     ],
//   );
// }
