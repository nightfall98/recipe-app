import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart'; // Add this import
import '../services/mock_data_service.dart';
import '../models/user_model.dart';

class RegisterScreen extends StatefulWidget {
  final VoidCallback? onRegisterSuccess;
  final VoidCallback? onNavigateToLogin;

  const RegisterScreen(
      {Key? key, this.onRegisterSuccess, this.onNavigateToLogin})
      : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  String email = '';
  String name = '';
  String password = '';
  String? errorMessage;

  Future<void> _register() async {
    if (_formKey.currentState!.validate()) {
      try {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
        if (widget.onRegisterSuccess != null) widget.onRegisterSuccess!();
      } catch (e) {
        setState(() => errorMessage = e.toString());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Register')),
      body: Center(
        child: Card(
          margin: const EdgeInsets.all(20),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (errorMessage != null) ...[
                    Text(errorMessage!,
                        style: const TextStyle(color: Colors.red)),
                    const SizedBox(height: 12),
                  ],
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Name'),
                    onChanged: (val) => name = val,
                    validator: (val) =>
                    val != null && val.isNotEmpty
                        ? null
                        : 'Enter your name',
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Email'),
                    onChanged: (val) => email = val,
                    validator: (val) =>
                    val != null && val.contains('@')
                        ? null
                        : 'Enter a valid email',
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Password'),
                    obscureText: true,
                    onChanged: (val) => password = val,
                    validator: (val) =>
                    val != null && val.length >= 6
                        ? null
                        : 'Minimum 6 chars required',
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: _register,
                    child: const Text('Register'),
                  ),
                  TextButton(
                    onPressed: () {
                      if (widget.onNavigateToLogin != null) {
                        widget.onNavigateToLogin!();
                      } else {
                        Navigator.pushNamed(context, '/login');
                      }
                    },
                    child: const Text('Already have an account? Login'),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
