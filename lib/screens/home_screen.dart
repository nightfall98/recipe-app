import 'package:flutter/material.dart';
import '../services/mock_data_service.dart';
import '../models/recipe_model.dart';
import 'recipe_detail_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final recipes = MockDataService.getAllRecipes();

    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFFE3E1F7), Color(0xFFF5EAFA)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: const Text(
              'Recipes', style: TextStyle(fontWeight: FontWeight.bold)),
          backgroundColor: Colors.deepPurple.withOpacity(0.9),
          elevation: 6,
          centerTitle: true,
        ),
        body: ListView.builder(
          itemCount: recipes.length,
          itemBuilder: (context, index) {
            final recipe = recipes[index];
            return Card(
              elevation: 8,
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18),
              ),
              child: ListTile(
                contentPadding: const EdgeInsets.all(16),
                leading: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: SizedBox(
                    width: 70,
                    height: 70,
                    child: Image.network(
                      recipe.imageUrl,
                      width: 70,
                      height: 70,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) =>
                          Container(
                            width: 70,
                            height: 70,
                            color: Colors.grey[200],
                            child: Icon(
                                Icons.restaurant, color: Colors.deepPurple,
                                size: 36),
                          ),
                    ),
                  ),
                ),
                title: Text(
                  recipe.title,
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                ),
                subtitle: Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'By: ${recipe.authorName}',
                        style: TextStyle(color: Colors.grey[700], fontSize: 14),
                      ),
                      const SizedBox(height: 2),
                      Row(
                        children: [
                          const Icon(
                              Icons.favorite, color: Colors.red, size: 18),
                          const SizedBox(width: 4),
                          Text('Likes: ${recipe.likes}'),
                        ],
                      ),
                      const SizedBox(height: 2),
                      Text(recipe.cookingTime, style: TextStyle(color: Colors
                          .deepPurple, fontWeight: FontWeight.w500)),
                    ],
                  ),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => RecipeDetailScreen(recipe: recipe),
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
