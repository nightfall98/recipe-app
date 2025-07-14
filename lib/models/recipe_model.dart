class RecipeModel {
  final String id;
  final String title;
  final String description;
  final List<String> ingredients;
  final String cookingTime;
  final String imageUrl;
  final String authorId;
  final String authorName;
  int likes;
  List<String> likedBy;
  final DateTime createdAt;

  RecipeModel({
    required this.id,
    required this.title,
    required this.description,
    required this.ingredients,
    required this.cookingTime,
    required this.imageUrl,
    required this.authorId,
    required this.authorName,
    required this.likes,
    required this.likedBy,
    required this.createdAt,
  });

  factory RecipeModel.fromMap(Map<String, dynamic> map) {
    return RecipeModel(
      id: map['id'],
      title: map['title'],
      description: map['description'],
      ingredients: List<String>.from(map['ingredients'] ?? []),
      cookingTime: map['cookingTime'],
      imageUrl: map['imageUrl'],
      authorId: map['authorId'],
      authorName: map['authorName'],
      likes: map['likes'] ?? 0,
      likedBy: List<String>.from(map['likedBy'] ?? []),
      createdAt: DateTime.parse(map['createdAt']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'ingredients': ingredients,
      'cookingTime': cookingTime,
      'imageUrl': imageUrl,
      'authorId': authorId,
      'authorName': authorName,
      'likes': likes,
      'likedBy': likedBy,
      'createdAt': createdAt.toIso8601String(),
    };
  }
}
