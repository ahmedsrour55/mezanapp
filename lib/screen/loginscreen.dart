import 'package:flutter/material.dart';
import 'package:mezaan/DB/sqflite.dart';
import 'package:mezaan/models/models.dart';
import 'package:mezaan/screen/home.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController incomeController = TextEditingController();
  final TextEditingController balanceController = TextEditingController();

  String selectedCountry = 'مصر';
  Mydb mydb = Mydb();
  List user = [];

  Future<List<Map>> readData() async {
    List<Map> response = await mydb.readData('SELECT * FROM users');
    user.addAll(response);
    setState(() {});
    return response;
  }

  @override
  Widget build(BuildContext context) {
    ScreenSize.init(context);
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              const SizedBox(height: 10),
              const Text(
                'ميزان',
                style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              Image.asset(
                'assets/images/login.gif',
                height: ScreenSize.height / 4,
              ),
              const SizedBox(height: 20),
              imputdata("الاسم بالكامل", Icon(Icons.person), nameController),
              imputdata("الايميل", Icon(Icons.email), emailController),
              imputdata("الراتب الشهري", Icon(Icons.money), incomeController),
              imputdata(
                "الحساب البنكي",
                Icon(Icons.food_bank),
                balanceController,
              ),
              SizedBox(height: 20),
              buildCountryDropdown(),
              const SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF708871),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 50,
                    vertical: 15,
                  ),
                ),
                onPressed: () async {
                  String name = nameController.text;
                  String email = emailController.text;
                  int badget = int.tryParse(incomeController.text) ?? 0;
                  int balance = int.tryParse(balanceController.text) ?? 0;

                  int id = await mydb.insertdata('''
    INSERT INTO users (name, email, badget, balancebank)
    VALUES ('$name', '$email', $badget, $balance)
  ''');
                  print(id);
                  await readData();
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => Home()),
                  );
                },
                child: const Text(
                  'تسجيل الدخول',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontFamily: 'ReemKufi',
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Padding imputdata(String name, Icon x, TextEditingController conteroler) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        controller: conteroler,
        decoration: InputDecoration(
          hintText: name,

          prefixIcon: x,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        ),
      ),
    );
  }

  Widget buildCountryDropdown() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        const Text(
          'اختر دولتك',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 5),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: kPrimaryColor,
            border: Border.all(color: Colors.black54),
            borderRadius: BorderRadius.circular(12),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              isExpanded: true,
              value: selectedCountry,
              icon: const Icon(Icons.arrow_drop_down),
              onChanged: (value) {
                setState(() {
                  selectedCountry = value!;
                });
              },
              items:
                  items1.map((country) {
                    return DropdownMenuItem<String>(
                      value: country,
                      child: Text(country),
                    );
                  }).toList(),
            ),
          ),
        ),
      ],
    );
  }
}
