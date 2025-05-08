import 'package:flutter/material.dart';
import 'package:mezaan/screen/editdata.dart';
import 'package:mezaan/screen/installments.dart';
import 'package:mezaan/screen/loginscreen.dart';
import 'package:mezaan/screen/organization_expenses.dart';
import 'package:mezaan/screen/splashscreen.dart';
import 'package:mezaan/screen/transfer_bound.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      home: SplashScreen(),
      routes: {
        "home": (context) => SplashScreen(),
        "login": (context) => LoginScreen(),
        "transfer": (context) => TransferBound(),
        "installments": (context) => Installments(),
        "organized": (context) => OrganizationExpenses(),
        "editdata": (context) => Editdata(),
      },
    );
  }
}
