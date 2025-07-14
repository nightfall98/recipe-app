import 'package:flutter/material.dart';
import '../models/recipe_model.dart';
import '../services/mock_data_service.dart';

class RecipeDetailScreen extends StatefulWidget {
  final RecipeModel recipe;
  const RecipeDetailScreen({Key? key, required this.recipe}) : super(key: key);

  @override
  State<RecipeDetailScreen> createState() => _RecipeDetailScreenState();
}

class _RecipeDetailScreenState extends State<RecipeDetailScreen> {
  late RecipeModel recipe;

  @override
  void initState() {
    super.initState();
    recipe = widget.recipe;
  }

  void _toggleLike() {
    final userId = MockDataService
        .getCurrentUser()
        .id;
    setState(() {
      if (recipe.likedBy.contains(userId)) {
        MockDataService.unlikeRecipe(recipe.id, userId);
      } else {
        MockDataService.likeRecipe(recipe.id, userId);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final userId = MockDataService
        .getCurrentUser()
        .id;
    final isLiked = recipe.likedBy.contains(userId);
    return Scaffold(
      appBar: AppBar(title: Text(recipe.title)),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(recipe.imageUrl, height: 200,
                    width: double.infinity,
                    fit: BoxFit.cover),
              ),
              const SizedBox(height: 20),
              Text('By: ${recipe.authorName}'),
              const SizedBox(height: 8),
              Text('Likes: ${recipe.likes}'),
              const SizedBox(height: 16),
              Text(recipe.description),
              const SizedBox(height: 16),
              Text('Ingredients:',
                  style: const TextStyle(fontWeight: FontWeight.bold)),
              for (var ingredient in recipe.ingredients) Text('- $ingredient'),
              const SizedBox(height: 16),
              Text('Cooking Time: ${recipe.cookingTime}'),
              const SizedBox(height: 24),
              Center(
                child: ElevatedButton(
                  onPressed: _toggleLike,
                  child: Text(isLiked ? 'Unlike' : 'Like'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
