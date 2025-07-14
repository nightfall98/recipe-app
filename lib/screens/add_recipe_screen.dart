import 'package:flutter/material.dart';
import '../services/mock_data_service.dart';
import '../models/recipe_model.dart';

class AddRecipeScreen extends StatefulWidget {
  const AddRecipeScreen({Key? key}) : super(key: key);

  @override
  State<AddRecipeScreen> createState() => _AddRecipeScreenState();
}

class _AddRecipeScreenState extends State<AddRecipeScreen> {
  final _formKey = GlobalKey<FormState>();
  String title = '';
  String description = '';
  String cookingTime = '';
  String ingredients = '';
  String imageUrl = '';

  void _addRecipe() {
    if (_formKey.currentState!.validate()) {
      final currentUser = MockDataService.getCurrentUser();
      final recipe = RecipeModel(
        id: DateTime
            .now()
            .millisecondsSinceEpoch
            .toString(),
        title: title,
        description: description,
        ingredients: ingredients.split(',').map((e) => e.trim()).where((e) =>
        e.isNotEmpty).toList(),
        cookingTime: cookingTime,
        imageUrl: imageUrl,
        authorId: currentUser.id,
        authorName: currentUser.name,
        likes: 0,
        likedBy: [],
        createdAt: DateTime.now(),
      );
      MockDataService.addRecipe(recipe);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Recipe')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Title'),
                  onChanged: (val) => title = val,
                  validator: (val) =>
                  val != null && val.isNotEmpty
                      ? null
                      : 'Enter title',
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Description'),
                  onChanged: (val) => description = val,
                  validator: (val) =>
                  val != null && val.isNotEmpty
                      ? null
                      : 'Enter description',
                  minLines: 2,
                  maxLines: 4,
                ),
                TextFormField(
                  decoration: const InputDecoration(
                      labelText: 'Cooking Time (e.g. 30 min)'),
                  onChanged: (val) => cookingTime = val,
                  validator: (val) =>
                  val != null && val.isNotEmpty
                      ? null
                      : 'Enter cooking time',
                ),
                TextFormField(
                  decoration: const InputDecoration(
                      labelText: 'Ingredients (comma-separated)'),
                  onChanged: (val) => ingredients = val,
                  validator: (val) =>
                  val != null && val.isNotEmpty
                      ? null
                      : 'Enter ingredients',
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Image URL'),
                  onChanged: (val) => imageUrl = val,
                  validator: (val) =>
                  val != null && val.isNotEmpty
                      ? null
                      : 'Enter image URL',
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: _addRecipe,
                  child: const Text('Add Recipe'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
