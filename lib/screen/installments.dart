import 'package:flutter/material.dart';
import 'package:mezaan/models/models.dart';
import 'package:mezaan/screen/apper_table.dart';
import 'package:mezaan/screen/hello&massege.dart';
import 'package:mezaan/screen/showdialog.dart';

class Installments extends StatefulWidget {
  const Installments({super.key});

  @override
  State<Installments> createState() => _InstallmentsState();
}

class _InstallmentsState extends State<Installments> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Showdialog(),
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
            word: " في هذة الصفحة يتم عرض او اضاقة الاقساط الملتزم بها حاليا",
          ),

          Expanded(
            child: ListView(
              scrollDirection: Axis.vertical,
              children: [ApperTable()],
            ),
          ),
        ],
      ),
    );
  }
}
