import '../models/user_model.dart';
import '../models/recipe_model.dart';

class MockDataService {
  static UserModel currentUser = UserModel(
    id: '1',
    name: 'Demo User',
    email: 'demo@example.com',
  );

  static final List<RecipeModel> _recipes = [
    RecipeModel(
      id: 'r1',
      title: 'Spaghetti Bolognese',
      description: 'A classic Italian pasta dish.',
      ingredients: ['Spaghetti', 'Tomato', 'Ground Beef', 'Onion', 'Garlic'],
      cookingTime: '30 min',
      imageUrl: 'https://images.unsplash.com/photo-1504674900247-0877df9cc836',
      authorId: '1',
      authorName: 'Demo User',
      likes: 1,
      likedBy: ['1'],
      createdAt: DateTime.now().subtract(const Duration(days: 1)),
    ),
    RecipeModel(
      id: 'r2',
      title: 'Chicken Curry',
      description: 'Hearty and flavorful chicken curry.',
      ingredients: [
        'Chicken',
        'Curry Powder',
        'Potato',
        'Carrot',
        'Coconut Milk'
      ],
      cookingTime: '45 min',
      imageUrl: 'https://images.unsplash.com/photo-1512058564366-c9e3e046ad58',
      authorId: '2',
      authorName: 'Chef Anna',
      likes: 0,
      likedBy: [],
      createdAt: DateTime.now().subtract(const Duration(hours: 3)),
    ),
  ];

  static List<RecipeModel> getAllRecipes() {
    // Return a copy for safety
    return List<RecipeModel>.from(_recipes);
  }

  static UserModel getCurrentUser() {
    return currentUser;
  }

  static void addRecipe(RecipeModel recipe) {
    _recipes.add(recipe);
  }

  static void likeRecipe(String recipeId, String userId) {
    final recipe = _recipes.firstWhere((r) => r.id == recipeId);
    if (!recipe.likedBy.contains(userId)) {
      recipe.likedBy.add(userId);
      recipe.likes++;
    }
  }

  static void unlikeRecipe(String recipeId, String userId) {
    final recipe = _recipes.firstWhere((r) => r.id == recipeId);
    if (recipe.likedBy.contains(userId)) {
      recipe.likedBy.remove(userId);
      recipe.likes--;
    }
  }

  static List<RecipeModel> getRecipesByUser(String userId) {
    return _recipes.where((r) => r.authorId == userId).toList();
  }

  static List<RecipeModel> getLikedRecipes(String userId) {
    return _recipes.where((r) => r.likedBy.contains(userId)).toList();
  }
}
