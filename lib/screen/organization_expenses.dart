import 'package:flutter/material.dart';
import 'package:mezaan/DB/sqflite.dart';
import 'package:mezaan/models/models.dart';
import 'package:mezaan/screen/hello&massege.dart';

class OrganizationExpenses extends StatefulWidget {
  const OrganizationExpenses({super.key});

  @override
  State<OrganizationExpenses> createState() => _OrganizationExpensesState();
}

class _OrganizationExpensesState extends State<OrganizationExpenses> {
  Mydb mydb = Mydb();
  List user = [];

  Future<List<Map>> readData() async {
    List<Map> response = await mydb.readData('SELECT * FROM users');
    user.addAll(response);
    setState(() {});
    return response;
  }

  @override
  void initState() {
    super.initState();
    readData();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor3,
        title: Text(
          "ميزان",
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          HelloMessage(
            word:
                "في هذة الصفحة يتم عرض افضل نسبة لتنظيم مصروفات من خلال مرتبك",
          ),
          Container(
            width: ScreenSize.width * 0.5,
            height: ScreenSize.height * 0.1,
            margin: EdgeInsets.all(5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              color: kPrimaryColor3,
            ),
            child: Center(
              child: Text(
                user.isNotEmpty ? "${user[0]['badget']}" : "لا يوجد بيانات",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),

          Expanded(
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                Container(
                  margin: EdgeInsets.all(8),
                  width: ScreenSize.width * 0.5,
                  height: ScreenSize.height * 0.5,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.green, width: 2.0),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Column(
                    children: [
                      datadisplay(" الادخارات والاستثمار", 0.2, "20.0%"),
                      SizedBox(height: 20),
                      categoryItem("  حالات الطوارئ", "assets/images/l9.png"),
                      categoryItem("تعجل سداد الديون", "assets/images/l10.png"),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(8),
                  width: ScreenSize.width * 0.5,
                  height: ScreenSize.height * 0.5,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.green, width: 2.0),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Column(
                    children: [
                      datadisplay("مصروفاتك الاساسية", 0.3, "30.0%"),
                      SizedBox(height: 20),

                      categoryItem("التسوق", "assets/images/l5.png"),
                      categoryItem("الأنشطة الترفيهية", "assets/images/l6.png"),
                      categoryItem("الرحلات", "assets/images/l7.png"),
                      categoryItem("الهدايا", "assets/images/l8.png"),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(8),
                  width: ScreenSize.width * 0.5,
                  height: ScreenSize.height * 0.5,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.green, width: 2.0),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Column(
                    children: [
                      datadisplay(" مصروفات الشخصية المتغيرة", 0.5, "50.0%"),
                      SizedBox(height: 20),
                      categoryItem(
                        "فواتير الكهرباء و المياة",
                        "assets/images/l1.png",
                      ),
                      categoryItem("مصاريف التعليم", "assets/images/l2.png"),
                      categoryItem("الرعاية الصحية", "assets/images/l3.png"),
                      categoryItem("الاتصالات", "assets/images/l4.png"),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Column datadisplay(String text, double dat, String nespa) {
    return Column(
      children: [
        Text(text, style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
        CircleAvatar(
          radius: 55,
          backgroundColor: kPrimaryColor4,
          child: CircleAvatar(
            radius: 54,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  " $nespa",
                  style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
                ),

                Text(
                  user.isNotEmpty
                      ? ((double.tryParse(user[0]['badget'].toString()) ?? 0) *
                              dat)
                          .toStringAsFixed(1)
                      : "N/A",
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

Widget categoryItem(String label, String image) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(label, style: TextStyle(fontSize: 14)),
        SizedBox(width: 8),
        CircleAvatar(radius: 10, backgroundImage: AssetImage(image)),
      ],
    ),
  );
}
