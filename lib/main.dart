import 'package:flutter/material.dart';
import 'Activities/Home.dart';
void main() {
  runApp(MaterialApp(
    themeMode: ThemeMode.system, // Automatically switch between light and dark themes based on device settings
    theme: ThemeData(
      brightness: Brightness.light,
      primaryColor: Colors.blue, // Example primary color for light theme
      // Add more theme properties here as needed
    ),
    darkTheme: ThemeData(
      brightness: Brightness.dark,
      primaryColor: Colors.deepPurple, // Example primary color for dark theme
      // Add more theme properties here as needed
    ),
      debugShowCheckedModeBanner: false,
    home: Home(),
  ));
}
