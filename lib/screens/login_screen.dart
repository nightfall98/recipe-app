import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../services/mock_data_service.dart';
import '../models/user_model.dart';

class LoginScreen extends StatefulWidget {
  final VoidCallback? onLoginSuccess;
  final VoidCallback? onNavigateToRegister;

  const LoginScreen({Key? key, this.onLoginSuccess, this.onNavigateToRegister})
      : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  String email = '';
  String password = '';
  String? errorMessage;

  Future<void> _login() async {
    if (_formKey.currentState!.validate()) {
      try {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
        if (widget.onLoginSuccess != null) widget.onLoginSuccess!();
      } catch (e) {
        setState(() => errorMessage = e.toString());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
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
                    onPressed: _login,
                    child: const Text('Login'),
                  ),
                  TextButton(
                    onPressed: () {
                      if (widget.onNavigateToRegister != null) {
                        widget.onNavigateToRegister!();
                      } else {
                        Navigator.pushNamed(context, '/register');
                      }
                    },
                    child: const Text('No account? Register'),
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
