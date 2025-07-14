import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final User? user = FirebaseAuth.instance.currentUser;
    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: user == null
          ? const Center(child: Text('No user found.'))
          : SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Card(
                margin: const EdgeInsets.only(bottom: 20),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Name: ${user.displayName ?? 'Not set'}',
                        style: Theme
                            .of(context)
                            .textTheme
                            .titleLarge,
                      ),
                      const SizedBox(height: 4),
                      Text('Email: ${user.email ?? 'none'}'),
                      const SizedBox(height: 4),
                      Text('User ID: ${user.uid}'),
                    ],
                  ),
                      ),
                    ),
                    Text('My Recipes', style: Theme
                        .of(context)
                        .textTheme
                        .titleMedium),
                    const SizedBox(height: 8),
                    const Text('Personal recipes feature coming soon!'),
                    const SizedBox(height: 32),
                    Center(
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.deepPurple,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 28, vertical: 14),
                        ),
                        onPressed: () async {
                          await FirebaseAuth.instance.signOut();
                        },
                        icon: const Icon(Icons.logout),
                        label: const Text('Sign Out'),
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
