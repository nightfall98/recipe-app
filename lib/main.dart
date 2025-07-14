import 'package:flutter/foundation.dart'; import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'screens/add_recipe_screen.dart';
import 'screens/profile_screen.dart';
import 'screens/login_screen.dart';
import 'screens/register_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart'; // Add this import for auth state

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (kIsWeb) {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: "AIzaSyD5te7zdeQoicUuub91-DHNxW1NXgG4_xk",
        authDomain: "recipe-app-a7cc1.firebaseapp.com",
        projectId: "recipe-app-a7cc1",
        storageBucket: "recipe-app-a7cc1.appspot.com",
        messagingSenderId: "180302025287",
        appId: "1:180302025287:web:d89fc6f52a7897bfb51762",
        measurementId: "G-PJFRSFVBG3",
      ),
    );
  } else {
    await Firebase.initializeApp();
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        final user = snapshot.data;
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Recipe Sharing App',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          ),
          home: user == null ? LoginScreenWrapper() : const MainScreen(),
          routes: {
            '/login': (context) => LoginScreenWrapper(),
            '/register': (context) => RegisterScreenWrapper(),
          },
        );
      },
    );
  }
}

// Wrapper to inject login/register navigation and logic
class LoginScreenWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LoginScreen(
      onLoginSuccess: () {
        // Navigation is handled automatically by StreamBuilder
      },
      onNavigateToRegister: () {
        Navigator.pushReplacementNamed(context, '/register');
      },
    );
  }
}

class RegisterScreenWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RegisterScreen(
      onRegisterSuccess: () {
        // Navigation is handled automatically by StreamBuilder
      },
      onNavigateToLogin: () {
        Navigator.pushReplacementNamed(context, '/login');
      },
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;
  static const List<Widget> _widgetOptions = <Widget>[
    HomeScreen(),
    AddRecipeScreen(),
    ProfileScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _widgetOptions[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: 'Add Recipe',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Theme
            .of(context)
            .colorScheme
            .primary,
        onTap: _onItemTapped,
      ),
    );
  }
}
