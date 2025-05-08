import 'package:flutter/material.dart';
import 'package:mezaan/DB/sqflite.dart';
import 'package:mezaan/screen/home.dart';
import 'package:mezaan/screen/loginscreen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Mydb mydb = Mydb();
  List user = [];

  Future<List<Map>> readData() async {
    List<Map> response = await mydb.readData('SELECT * FROM users');
    user.addAll(response);
    setState(() {});
    return response;
  }

  @override
  @override
  void initState() {
    super.initState();
    readData();

    Future.delayed(const Duration(seconds: 5), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => user.isNotEmpty ? Home() : LoginScreen(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/images/mizan.png",

              fit: BoxFit.fill,
              width: 150,
              height: 150,
            ),
            const SizedBox(height: 20),
            const Text(
              "ميزان",
              style: TextStyle(
                fontSize: 70,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
