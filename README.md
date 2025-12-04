# Chef's Pocket 👨‍🍳

**Chef's Pocket** is a mobile application developed with Flutter for the "Mobile App Design" (Progettazione di Applicazioni Mobili) course. It serves as a comprehensive digital assistant for cooking enthusiasts, allowing users to manage recipes, plan meals, and organize grocery lists efficiently.

## Project Overview

*   **Course:** Mobile App Design
*   **University:** University of Udine
*   **Tech Stack:** Flutter (Dart)

## Key Features

The application is organized into five main sections, accessible via a custom bottom navigation bar:

1.  **Home:** The central hub for discovering and browsing recipes.
2.  **Saved Recipes:** A bookmarking system to keep track of favorite dishes.
3.  **Recipe Creation:** A form-based interface allowing users to input and save their own custom recipes.
4.  **Meal Planner:** A calendar integration that allows users to schedule meals for specific days.
5.  **Grocery List:** An automated shopping list manager to track ingredients needed for planned meals.

## Technical Architecture

The project follows a clean architecture pattern, separating the User Interface from the Business Logic.

### State Management
The application uses the **Provider** package for state management to efficiently propagate changes across the app. The main providers initialized in `main.dart` are:

*   `PlannerManager`: Handles the logic for the meal calendar and scheduling.
*   `GroceryManager`: Manages the state of the shopping list (adding/removing items).
*   `RecipeManager`: Handles the CRUD operations for recipes.
*   `DirectoryManager`: Manages local file storage paths and directories.

### Project Structure

The source code in `lib/` is organized as follows:

*   **`components/`**: Contains reusable UI widgets (e.g., `BottomBar`, `Calendar`, `RecipeCard`).
*   **`manager/`**: Contains the logic classes (ChangeNotifiers) for state management.
*   **`models/`**: Defines the data structures (e.g., `GroceryList`, `Recipe`).
*   **`screens/`**: Contains the main views of the application (`HomeScreen`, `MealPlannerScreen`, etc.).
*   **`app_theme.dart`**: Defines the global visual style and theme of the application.

## Getting Started

To run this project locally:

1.  **Prerequisites:** Ensure you have the Flutter SDK installed and an emulator or physical device connected.
2.  **Install Dependencies:**
    ```bash
    flutter pub get
    ```
3.  **Run the App:**
    ```bash
    flutter run
    ```

## Dependencies

Key packages used in this project include:
*   `provider`: For state management.
*   `intl`: For date formatting and localization (Italian locale support).
*   `material_design_icons_flutter`: For extended icon support.

## Authors

*   *Gaia Simeoni*
*   *Maria Elena Zuliani*
