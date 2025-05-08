import 'package:flutter/material.dart';
import 'package:mezaan/DB/sqflite.dart';
import 'package:mezaan/models/models.dart';
import 'package:mezaan/screen/apper_table.dart';

class Showdialog extends StatefulWidget {
  const Showdialog({super.key});

  @override
  State<Showdialog> createState() => _ShowdialogState();
}

class _ShowdialogState extends State<Showdialog> {
  Mydb mydb = Mydb();
  List user = [];
  Future<List<Map>> readData() async {
    List<Map> response = await mydb.readData('SELECT * FROM installments');
    user.addAll(response);
    setState(() {});
    return response;
  }

  @override
  void initState() {
    super.initState();
    readData();
  }

  final TextEditingController fristcontroler = TextEditingController();
  final TextEditingController timecontroller = TextEditingController();
  final TextEditingController notescontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        showDialog(
          context: context,
          builder:
              (context) => AlertDialog(
                backgroundColor: kPrimaryColor3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "اضافه قسط جديد",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    TextField(
                      controller: fristcontroler,
                      decoration: InputDecoration(hintText: "القسط الشهري"),
                    ),
                    TextField(
                      controller: timecontroller,
                      decoration: InputDecoration(hintText: "المعاد"),
                    ),
                    TextField(
                      controller: notescontroller,
                      decoration: InputDecoration(hintText: "ملاحظات"),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: Text("الغاء"),
                        ),

                        ElevatedButton(
                          onPressed: () async {
                            String monyflow = fristcontroler.text;
                            String date = timecontroller.text;
                            String notes = notescontroller.text;

                            await mydb.insertdata('''
                          INSERT INTO "installments" (monyflow, date, notes)
                          VALUES ('$monyflow','$date' ,'$notes' )
                        ''');

                            await readData();
                            setState(() {
                              Navigator.pop(context);
                              ApperTable();
                              print(user);
                            });
                          },
                          child: Text("اضافة"),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
        );
      },
      child: Icon(Icons.add),
    );
  }
}
