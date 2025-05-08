import 'package:flutter/material.dart';
import 'package:mezaan/DB/sqflite.dart';
import 'package:mezaan/models/models.dart';

class Editdata extends StatefulWidget {
  const Editdata({super.key});

  @override
  State<Editdata> createState() => _EditdataState();
}

class _EditdataState extends State<Editdata> {
  Mydb mydb = Mydb();
  List user = [];
  @override
  void initState() {
    super.initState();
    readData();
  }

  Future<List<Map>> readData() async {
    List<Map> response = await mydb.readData('SELECT * FROM users');
    user.clear();
    user.addAll(response);
    setState(() {});
    return response;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        title: Text(
          "ميزان",
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Center(
            child: Container(
              margin: EdgeInsets.all(10),
              width: ScreenSize.width * 0.9,
              height: ScreenSize.height / 1.6,
              decoration: BoxDecoration(
                color: kPrimaryColor2,
                borderRadius: BorderRadius.circular(15),
              ),
            ),
          ),
          Positioned(
            left: ScreenSize.width / 3.2,
            child: CircleAvatar(
              radius: 80,
              backgroundColor: kPrimaryColor2,
              child: CircleAvatar(
                radius: 75,
                backgroundImage: AssetImage("assets/images/slogan.gif"),
              ),
            ),
          ),
          Positioned(
            left: ScreenSize.width / 10,
            top: ScreenSize.height / 5,
            child: Container(
              width: ScreenSize.width * 0.8,
              height: ScreenSize.height * 0.5,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  user.isNotEmpty
                      ? Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            " الاسم :${user[0]['name']}",
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          Text(
                            " الايميل:${user[0]['email']}",
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(height: 10), // spacing between text and row
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CircleAvatar(
                                radius: 40,
                                backgroundColor: kPrimaryColor3,
                                child: CircleAvatar(
                                  radius: 37,
                                  backgroundColor: Colors.white,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "${user[0]['badget']}",
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                        ),
                                      ),
                                      Text(
                                        "الراتب الشهري",
                                        style: TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              CircleAvatar(
                                radius: 40,
                                backgroundColor: kPrimaryColor3,
                                child: CircleAvatar(
                                  radius: 37,
                                  backgroundColor: Colors.white,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "${user[0]['balancebank']}",
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                        ),
                                      ),
                                      Text(
                                        "الحساب البنكي",
                                        style: TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          ElevatedButton(
                            onPressed: () {
                              setState(() {
                                showdialog(context);
                              });
                            },

                            child: Text("تعديل"),
                          ),
                        ],
                      )
                      : Text("not found"),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<dynamic> showdialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        TextEditingController nameController = TextEditingController(
          text: user[0]['name'],
        );
        TextEditingController emailController = TextEditingController(
          text: user[0]['email'],
        );
        TextEditingController bankController = TextEditingController(
          text: user[0]['balancebank'].toString(),
        );
        TextEditingController salaryController = TextEditingController(
          text: user[0]['badget'].toString(),
        );

        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  "تعديل البيانات الشخصية",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                SizedBox(height: 10),
                TextField(
                  controller: nameController,
                  decoration: InputDecoration(labelText: "الاسم"),
                ),
                TextField(
                  controller: emailController,
                  decoration: InputDecoration(labelText: "البريد الإلكتروني"),
                ),
                TextField(
                  controller: bankController,
                  decoration: InputDecoration(labelText: "الحساب البنكي"),
                  keyboardType: TextInputType.number,
                ),
                TextField(
                  controller: salaryController,
                  decoration: InputDecoration(labelText: "الراتب الشهري"),
                  keyboardType: TextInputType.number,
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                      onPressed: () async {
                        String newName = nameController.text;
                        String newEmail = emailController.text;
                        String newBank = bankController.text;
                        String newSalary = salaryController.text;

                        await mydb.updateData('''
    UPDATE "users" SET 
      name = "$newName", 
      email = "$newEmail", 
      balancebank = $newBank, 
      badget = $newSalary 
    WHERE id = ${user[0]['id']}
  ''');

                        await readData();
                        Navigator.pop(context);
                        setState(() {});
                      },

                      child: Text("حفظ"),
                    ),
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text("إلغاء"),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
