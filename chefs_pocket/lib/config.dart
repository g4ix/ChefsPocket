import 'package:chefs_pocket/models/day.dart';
import 'package:chefs_pocket/models/ingredient.dart';
import 'package:chefs_pocket/models/recipe.dart';
import 'package:chefs_pocket/models/recipe_step.dart';
import 'package:chefs_pocket/models/directory.dart';

List<String> euMeasures = ["g", "ml", "l", "kg", ""];

List<String> usMeasures = [
  "oz",
  "fl oz",
  "gal",
  "lb",
  "tbsp",
  "tsp",
  "cup",
  ""
];

enum Tag {
  Dolce,
  Primo,
  Secondo,
  Vegano,
  Bevanda,
  NoGlutine,
  Contorno,
  Vegetariano,
  Carne,
  Pesce,
  NoLattosio,
}

List<Recipe> mockRecipes = [
  Recipe(
    title: "Pasta al Pomodoro",
    portions: 3,
    imageUrl: "assets/recipes/pasta_pomodoro.jpg",
    tags: [Tag.Primo, Tag.Vegetariano],
    rating: 3,
    ingredients: [
      Ingredient(
        name: "Pasta",
        quantity: 100,
        unit: "g",
      ),
      Ingredient(
        name: "Pomodoro",
        quantity: 200,
        unit: "g",
      ),
      Ingredient(
        name: "Basilico",
        quantity: 5,
        unit: "g",
      ),
    ],
    steps: [
      RecipeStep(
        imageUrls: [
          'assets/recipes/pentola.jpg',
          'assets/recipes/pasta.jpg'
        ],
        title: "Preparazione",
        description: "Per preparare gli spaghetti al pomodoro cominciate dalla preparazione della salsa. In una padella versate l'olio extravergine d'oliva insieme allo spicchio d'aglio sbucciato e diviso a metà 1, così potrete eliminare l'anima per rendere il profumo più delicato. Dopo 2 minuti di cottura a fiamma viva, unite i pomodori pelati 2 e aggiustate di sale 3.",
        timer: const Duration(minutes: 10),
      ),
      RecipeStep(
        imageUrls: ['assets/recipes/pasta.jpg', 'assets/recipes/sugo.jpg'],
        title: "Preparazione", description: "Aggiungi la pasta"),
      RecipeStep(
        title: "Preparazione",
        description: "Scola la pasta",
      ),
      RecipeStep(
        title: "Preparazione",
        description: "Aggiungi il pomodoro e il basilico",
      ),
    ],
  ),
  Recipe(
    title: "Pasta al Pesto",
    portions: 2,
    imageUrl: "assets/recipes/pasta_pesto.jpg",
    rating: 2,
    tags: [Tag.Primo],
    ingredients: [
      Ingredient(
        name: "Pasta",
        quantity: 100,
        unit: "g",
      ),
      Ingredient(
        name: "Pesto",
        quantity: 50,
        unit: "g",
      ),
    ],
    steps: [
      RecipeStep(
         imageUrls: [
          'assets/recipes/pentola.jpg',
          'assets/recipes/pasta.jpg'
        ],
        title: "Preparazione",
        description: "Metti a bollire l'acqua",
        timer: const Duration(minutes: 10),
      ),
      RecipeStep(title: "Preparazione", description: "Aggiungi la pasta"),
      RecipeStep(
        title: "Preparazione",
        description: "Scola la pasta",
      ),
      RecipeStep(
        title: "Preparazione",
        description: "Aggiungi il pesto",
      ),
    ],
  ),
  Recipe(
    title: "Pasta alla Carbonara",
    portions: 2,
    imageUrl: "assets/recipes/pasta_carbonara.jpg",
    rating: 4,
    totalTime: Duration(minutes: 30),
    tags: [Tag.Primo, Tag.Carne],
    ingredients: [
      Ingredient(
        name: "Pasta",
        quantity: 100,
        unit: "g",
      ),
      Ingredient(
        name: "Uova",
        quantity: 2,
        unit: "pz",
      ),
      Ingredient(
        name: "Pancetta",
        quantity: 50,
        unit: "g",
      ),
      Ingredient(
        name: "Formaggio",
        quantity: 20,
        unit: "g",
      ),
      Ingredient(
        name: "Pepe",
        quantity: 5,
        unit: "g",
      ),
      Ingredient(
        name: "Sale",
        quantity: 5,
        unit: "g",
      ),
      Ingredient(
        name: "Olio",
        quantity: 20,
        unit: "ml",
      ),
      Ingredient(
        name: "Acqua",
        quantity: 200,
        unit: "ml",
      )
    ],
    steps: [
      RecipeStep(
        title: "Preparazione",
        imageUrls: [
          'assets/recipes/pasta_carbonara.jpg',
          'assets/recipes/pasta.jpg'
        ],
        description: "Metti a bollire l'acqua",
        timer: const Duration(minutes: 10),
      ),
      RecipeStep(title: "Preparazione", description: "Aggiungi la pasta"),
      RecipeStep(
         imageUrls: [
          'assets/recipes/pentola.jpg',
          'assets/recipes/pasta.jpg'
        ],
        title: "Preparazione",
        description: "Scola la pasta, ",
      ),
      RecipeStep(
        title: "Preparazione",
        description: "Aggiungi le uova e la pancetta",
      ),
    ],
  ),
];

List<Day> mockDays = [
  Day(
    date: DateTime.now(),
    lunch: mockRecipes,
    dinner: mockRecipes,
    snacks: mockRecipes,
    breakfast: mockRecipes,
  ),
  Day(
    date: DateTime.now().add(const Duration(days: 1)),
    lunch: mockRecipes,
    dinner: mockRecipes,
    snacks: mockRecipes,
    breakfast: mockRecipes,
  ),
  Day(
    date: DateTime.now().add(const Duration(days: 2)),
    lunch: mockRecipes,
    dinner: mockRecipes,
    snacks: mockRecipes,
    breakfast: mockRecipes,
  ),
  Day(
    date: DateTime.now().add(const Duration(days: 3)),
    lunch: mockRecipes,
    dinner: mockRecipes,
    snacks: mockRecipes,
    breakfast: mockRecipes,
  ),
  Day(
    date: DateTime.now().add(const Duration(days: 4)),
    lunch: mockRecipes,
    dinner: mockRecipes,
    snacks: mockRecipes,
    breakfast: mockRecipes,
  ),
  Day(
    date: DateTime.now().add(const Duration(days: 5)),
    lunch: mockRecipes,
    dinner: mockRecipes,
    snacks: mockRecipes,
    breakfast: mockRecipes,
  ),
  Day(
    date: DateTime.now().add(const Duration(days: 6)),
    lunch: mockRecipes,
    dinner: mockRecipes,
    snacks: mockRecipes,
    breakfast: mockRecipes,
  ),
];

// ---------------------------------  SAVED SCREEN MOCKS ---------------------------------

// Ricette italiane: pizza, arancini, focaccia
List<Recipe> italianRecipes = [
  Recipe(
    title: "Pizza Margherita",
    imageUrl: "assets/recipes/pizza_margherita.jpg",
    ingredients: [
      Ingredient(
        name: "Farina",
        quantity: 300,
        unit: "g",
      ),
      Ingredient(
        name: "Acqua",
        quantity: 200,
        unit: "ml",
      ),
      Ingredient(
        name: "Lievito di birra",
        quantity: 5,
        unit: "g",
      ),
      Ingredient(
        name: "Pomodoro",
        quantity: 200,
        unit: "g",
      ),
      Ingredient(
        name: "Mozzarella",
        quantity: 150,
        unit: "g",
      ),
      Ingredient(
        name: "Basilico",
        quantity: 5,
        unit: "g",
      ),
      Ingredient(
        name: "Olio extravergine d'oliva",
        quantity: 20,
        unit: "ml",
      ),
      Ingredient(
        name: "Sale",
        quantity: 5,
        unit: "g",
      ),
    ],
    steps: [
      RecipeStep(
        title: "Preparazione",
        description:
            "Prepara l'impasto mescolando la farina con il lievito di birra, l'acqua e il sale. Lascia lievitare per almeno un'ora.",
      ),
      RecipeStep(
        title: "Preparazione",
        description:
            "Stendi l'impasto sulla teglia, aggiungi il pomodoro, la mozzarella e il basilico.",
      ),
      RecipeStep(
        title: "Preparazione",
        description:
            "Cuoci in forno preriscaldato a 220°C per circa 15-20 minuti o fino a doratura.",
      ),
      RecipeStep(
        title: "Preparazione",
        description: "Servi calda e gustosa!",
      ),
    ],
    rating: 4,
    totalTime: Duration(hours: 1, minutes: 20),
  ),
  Recipe(
    title: "Arancini di Riso",
    imageUrl: "assets/recipes/arancini_di_riso.jpg",
    ingredients: [
      Ingredient(
        name: "Riso Arborio",
        quantity: 300,
        unit: "g",
      ),
      Ingredient(
        name: "Mozzarella",
        quantity: 150,
        unit: "g",
      ),
      Ingredient(
        name: "Ragù",
        quantity: 200,
        unit: "g",
      ),
      Ingredient(
        name: "Uova",
        quantity: 2,
        unit: "pz",
      ),
      Ingredient(
        name: "Pan grattato",
        quantity: 100,
        unit: "g",
      ),
      Ingredient(
        name: "Olio per friggere",
        quantity: 500,
        unit: "ml",
      ),
      Ingredient(
        name: "Sale",
        quantity: 5,
        unit: "g",
      ),
    ],
    steps: [
      RecipeStep(
        title: "Preparazione",
        description: "Prepara il risotto e lascialo raffreddare.",
      ),
      RecipeStep(
        title: "Preparazione",
        description:
            "Forma delle palline di riso, farcite con un cubetto di mozzarella e un po' di ragù al centro.",
      ),
      RecipeStep(
        title: "Preparazione",
        description:
            "Passa gli arancini nell'uovo sbattuto e poi nel pangrattato.",
      ),
      RecipeStep(
        title: "Preparazione",
        description: "Friggi gli arancini in olio caldo finché saranno dorati.",
      ),
      RecipeStep(
        title: "Preparazione",
        description:
            "Scolali e lasciali sgocciolare su carta assorbente prima di servire.",
      ),
    ],
    rating: 4,
    totalTime: Duration(hours: 1, minutes: 45),
  ),
  Recipe(
    title: "Focaccia Genovese",
    imageUrl: "assets/recipes/focaccia_genovese.jpg",
    ingredients: [
      Ingredient(
        name: "Farina",
        quantity: 400,
        unit: "g",
      ),
      Ingredient(
        name: "Acqua",
        quantity: 250,
        unit: "ml",
      ),
      Ingredient(
        name: "Olio extravergine d'oliva",
        quantity: 50,
        unit: "ml",
      ),
      Ingredient(
        name: "Sale",
        quantity: 10,
        unit: "g",
      ),
      Ingredient(
        name: "Zucchero",
        quantity: 5,
        unit: "g",
      ),
      Ingredient(
        name: "Lievo di birra",
        quantity: 5,
        unit: "g",
      ),
      Ingredient(
        name: "Rosmarino",
        quantity: 10,
        unit: "g",
      ),
    ],
    steps: [
      RecipeStep(
        title: "Preparazione",
        description:
            "Sciogli il lievito di birra in acqua tiepida con lo zucchero.",
      ),
      RecipeStep(
        title: "Preparazione",
        description:
            "Mescola la farina con il sale, aggiungi l'acqua con il lievito e impasta fino ad ottenere un composto omogeneo.",
      ),
      RecipeStep(
        title: "Preparazione",
        description:
            "Stendi l'impasto su una teglia da forno, lascia lievitare per almeno un'ora.",
      ),
      RecipeStep(
        title: "Preparazione",
        description:
            "Condisci con olio extravergine d'oliva, sale, rosmarino e fai cuocere in forno preriscaldato a 220°C per circa 20-25 minuti.",
      ),
      RecipeStep(
        title: "Preparazione",
        description: "Servi calda e profumata!",
      ),
    ],
    rating: 5,
    totalTime: Duration(hours: 3, minutes: 45),
  ),
];

// Ricette messicane
List<Recipe> mexicanRecipes = [
  Recipe(
    title: "Tacos al Pastor",
    imageUrl: "assets/recipes/tacos_al_pastor.jpg",
    ingredients: [
      Ingredient(
        name: "Carne di maiale",
        quantity: 300,
        unit: "g",
      ),
      Ingredient(
        name: "Ananas",
        quantity: 200,
        unit: "g",
      ),
      Ingredient(
        name: "Tortillas di mais",
        quantity: 6,
        unit: "pz",
      ),
      Ingredient(
        name: "Cipolla",
        quantity: 1,
        unit: "pz",
      ),
      Ingredient(
        name: "Coriandolo fresco",
        quantity: 10,
        unit: "g",
      ),
      Ingredient(
        name: "Salsa di chipotle",
        quantity: 50,
        unit: "ml",
      ),
    ],
    steps: [
      RecipeStep(
        title: "Preparazione",
        description:
            "Marina la carne di maiale con la salsa di chipotle per almeno 1 ora.",
      ),
      RecipeStep(
        title: "Preparazione",
        description: "Cuoci la carne di maiale in padella fino a doratura.",
      ),
      RecipeStep(
        title: "Preparazione",
        description: "Scalda le tortillas di mais su una piastra calda.",
      ),
      RecipeStep(
        title: "Preparazione",
        description:
            "Riempire le tortillas con la carne di maiale, l'ananas, la cipolla e il coriandolo fresco.",
      ),
    ],
    rating: 4,
    totalTime: Duration(hours: 1, minutes: 45),
  ),
  Recipe(
    title: "Guacamole",
    imageUrl: "assets/recipes/guacamole.jpg",
    ingredients: [
      Ingredient(
        name: "Avocado",
        quantity: 2,
        unit: "pz",
      ),
      Ingredient(
        name: "Pomodoro",
        quantity: 1,
        unit: "pz",
      ),
      Ingredient(
        name: "Cipolla",
        quantity: 1,
        unit: "pz",
      ),
      Ingredient(
        name: "Peperoncino",
        quantity: 1,
        unit: "pz",
      ),
      Ingredient(
        name: "Coriandolo fresco",
        quantity: 10,
        unit: "g",
      ),
      Ingredient(
        name: "Succo di lime",
        quantity: 1,
        unit: "pz",
      ),
      Ingredient(
        name: "Sale",
        quantity: 5,
        unit: "g",
      ),
    ],
    steps: [
      RecipeStep(
        title: "Preparazione",
        description: "Schiaccia gli avocado in una ciotola.",
      ),
      RecipeStep(
        title: "Preparazione",
        description:
            "Aggiungi il pomodoro, la cipolla, il peperoncino e il coriandolo fresco tritati finemente.",
      ),
      RecipeStep(
        title: "Preparazione",
        description:
            "Aggiungi il succo di lime e il sale, mescola bene il tutto.",
      ),
      RecipeStep(
        title: "Preparazione",
        description: "Servi con totopos o come accompagnamento.",
      ),
    ],
    rating: 3,
    totalTime: Duration(minutes: 20),
  ),
  Recipe(
    title: "Enchiladas",
    imageUrl: "assets/recipes/enchiladas.jpg",
    ingredients: [
      Ingredient(
        name: "Tortillas di mais",
        quantity: 8,
        unit: "pz",
      ),
      Ingredient(
        name: "Pollo",
        quantity: 300,
        unit: "g",
      ),
      Ingredient(
        name: "Salsa rossa",
        quantity: 300,
        unit: "ml",
      ),
      Ingredient(
        name: "Formaggio cheddar",
        quantity: 100,
        unit: "g",
      ),
      Ingredient(
        name: "Cipolla",
        quantity: 1,
        unit: "pz",
      ),
      Ingredient(
        name: "Panna acida",
        quantity: 100,
        unit: "g",
      ),
      Ingredient(
        name: "Guarnizioni a piacere: avocado, coriandolo, cipolla rossa, etc.",
      ),
    ],
    steps: [
      RecipeStep(
        title: "Preparazione",
        description:
            "Prepara il ripieno di pollo cuocendo il pollo e sfilacciandolo.",
      ),
      RecipeStep(
        title: "Preparazione",
        description: "Scalda le tortillas in padella o nel microonde.",
      ),
      RecipeStep(
        title: "Preparazione",
        description:
            "Farcisci ogni tortilla con il pollo, arrotolale e adagiala in una teglia da forno.",
      ),
      RecipeStep(
        title: "Preparazione",
        description:
            "Versa la salsa rossa sopra le enchiladas, copri con il formaggio e la cipolla tritata.",
      ),
      RecipeStep(
        title: "Preparazione",
        description:
            "Cuoci in forno preriscaldato a 180°C per circa 20 minuti o finché il formaggio non è fuso e dorato.",
      ),
      RecipeStep(
        title: "Preparazione",
        description:
            "Servi le enchiladas calde con la panna acida e le guarnizioni a piacere.",
      ),
    ],
    rating: 4,
    totalTime: Duration(minutes: 40),
  ),
];

List<Recipe> allSavedRecipes = [
  ...italianRecipes,
  ...mexicanRecipes,
  ...mockRecipes
  // Altre ricette possono essere aggiunte qui
];

Directory savedRecipesDirectory = Directory(
  name: 'Ricette Salvate',
  imageUrl: 'assets/directories/saved_recipes.jpg',
  recipes: allSavedRecipes,
);

// Organizzazione delle ricette nelle directory
List<Directory> mockDirectories = [
  Directory(
    name: 'Italiano',
    imageUrl: 'assets/directories/italian_cuisine.jpg',
    recipes: italianRecipes,
  ),
  Directory(
    name: 'Messicano',
    imageUrl: 'assets/directories/mexican_cuisine.jpg',
    recipes: mexicanRecipes,
  ),
  // Altre directory possono essere aggiunte qui
];
