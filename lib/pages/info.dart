// my api key = AIzaSyCICLZJh-QOLEQ9vX79TK9Rp3BzK2Y-JFQ

import 'dart:math';

import 'package:shared_preferences/shared_preferences.dart';

String api_key_input = '';
String user_name_input = '';

final String baseUrl = "https://generativelanguage.googleapis.com/v1beta/models/gemini-1.5-flash-latest:generateContent?key=";

String oururl = baseUrl;

String getFirstName(String fullName) {
  String firstName = fullName.split(' ')[0];
  if (firstName.length > 12) {
    firstName = firstName.substring(0, 10);
  }
  return firstName;
}

void updateUrl() {
  oururl = '$baseUrl$api_key_input';
}

Future<void> updateUserName(String userName) async {
  user_name_input = userName;
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString('username', userName);
}

Future<String> getUserName() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString('username') ?? '';
}



String getTimeBasedGreeting() {
  final now = DateTime.now();
  final hour = now.hour;

  final morningGreetings = [
    'Good Morning!',
    'Hello There!',
    'Hey There!',
    'Hi There!',
    'Greetings!',
    'Morning Sunshine!',
    'Hiya!',
    'Hello!',
    'Welcome!',
    'Salutations!',
  ];

  final afternoonGreetings = [
    'Good Afternoon!',
    'Hey!',
    'What’s Up!',
    'Hope You’re Well!',
    'Afternoon Delight!',
    'Sunny Afternoon!',
    'Enjoy Your Day!',
    'Good Times!',
    'Good Vibes!',
    'Hello!',
  ];

  final eveningGreetings = [
    'Good Evening!',
    'Hello Again!',
    'Evening Sunshine!',
    'Relax & Unwind!',
    'Evening Bliss!',
    'Hope Your Day Was Great!',
    'Evening Cheers!',
    'Time to Relax!',
    'Good Evening!',
    'Wind Down!',
  ];

  final nightGreetings = [
    'Good Night!',
    'Sleep Well!',
    'Sweet Dreams!',
    'Rest Up!',
    'Night Night!',
    'Sleep Tight!',
    'Catch Z’s!',
    'Rest Easy!',
    'Dream On!',
    'Goodnight!',
    'Rest Well!',
    'Sleepy Time!',
    'Nighty Night!',
    'Lights Out!',
    'Sweet Slumber!',
    'End of Day!',
    'Sleep Mode!',
    'Dream Big!',
    'Restful Night!',
    'Nighttime Bliss!',
  ];

  final random = Random();

  if (hour >= 0 && hour < 3) {
    return 'It’s Late!';
  } else if (hour >= 3 && hour < 6) {
    return 'Exams Loom!';
  } else if (hour >= 6 && hour < 12) {
    return morningGreetings[random.nextInt(morningGreetings.length)];
  } else if (hour >= 12 && hour < 17) {
    return afternoonGreetings[random.nextInt(afternoonGreetings.length)];
  } else if (hour >= 17 && hour < 21) {
    return eveningGreetings[random.nextInt(eveningGreetings.length)];
  } else {
    return nightGreetings[random.nextInt(nightGreetings.length)];
  }
}



