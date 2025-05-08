import 'package:flutter/material.dart';
import 'package:mezaan/DB/sqflite.dart';
import 'package:mezaan/models/models.dart';
import 'package:mezaan/screen/hello&massege.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
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
  void initState() {
    super.initState();
    readData();
  }

  @override
  Widget build(BuildContext context) {
    ScreenSize.init(context);
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: kPrimaryColor3,
          title: Text(
            "ميزان",
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),
        ),
        body: Column(
          children: [
            HelloMessage(
              word:
                  user.isNotEmpty
                      ? ' ${user[0]['name']} اهلا بيك في الميزان'
                      : 'أهلا بيك في الميزان',
            ),

            choseelogic(
              "حساب تحويل العملات الي الدولار",
              "assets/images/dolar.png",
              "transfer",
            ),

            choseelogic(
              "عرض الاقساط ومواعيدها",
              "assets/images/aqsat.jpg",
              "installments",
            ),

            choseelogic(
              "تنظيم المصروفات بالنسبة لدخللك الشهري",
              "assets/images/masrouf.png",
              "organized",
            ),

            choseelogic(
              "البيانات الشخصية",
              "assets/images/data.jpg",
              "editdata",
            ),
          ],
        ),
      ),
    );
  }

  InkWell choseelogic(String text, String image, String route) {
    return InkWell(
      child: Container(
        width: ScreenSize.width * 0.98,
        height: ScreenSize.height / 8,
        margin: EdgeInsets.all(8),
        padding: EdgeInsets.all(5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: kPrimaryColor2,
        ),
        child: Row(
          // mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(radius: 40, backgroundImage: AssetImage(image)),
            SizedBox(width: 50),
            Text(text),
          ],
        ),
      ),
      onTap: () {
        user.isNotEmpty ? Navigator.pushNamed(context, route) : print("errors");
      },
    );
  }
}
