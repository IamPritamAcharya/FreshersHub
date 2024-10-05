
import 'package:flutter/material.dart';
import 'package:freshers/books/favoritesProvider.dart';
import 'package:freshers/pages/login.dart';
import 'package:freshers/pages/welcome.dart';
import 'package:freshers/theme/theme_provider.dart';
import 'package:freshers/util/hidden_drawer.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:sizer/sizer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ThemeProvider()),
        ChangeNotifierProvider(create: (context) => FavoritesProvider()), // Add FavoritesProvider
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Widget _currentPage = WelcomePage();

  @override
  void initState() {
    super.initState();
    _initializeNavigation();
  }

  Future<void> _initializeNavigation() async {
    final signedIn = await _checkIfSignedIn();
    final seenWelcome = await _checkIfSeenWelcome();

    setState(() {
      if (signedIn) {
        _currentPage = HiddenDrawer(); // Replace with your main app widget
      } else {
        _currentPage = seenWelcome ? LoginPage() : WelcomePage();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return Consumer<ThemeProvider>(
          builder: (context, themeProvider, child) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: themeProvider.themeData,
              home: _currentPage,
            );
          },
        );
      },
    );
  }

  Future<bool> _checkIfSignedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('signedIn') ?? false;
  }

  Future<bool> _checkIfSeenWelcome() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('seenWelcome') ?? false;
  }
}
