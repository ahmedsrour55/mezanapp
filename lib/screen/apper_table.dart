import 'package:flutter/material.dart';
import 'package:mezaan/DB/sqflite.dart';

class ApperTable extends StatefulWidget {
  const ApperTable({super.key});

  @override
  State<ApperTable> createState() => _ApperTableState();
}

class _ApperTableState extends State<ApperTable> {
  Mydb mydb = Mydb();
  List<Map> items = [];

  Future<void> readData() async {
    List<Map> response = await mydb.readData('SELECT * FROM installments');
    setState(() {
      items = response;
    });
  }

  @override
  void initState() {
    super.initState();
    readData(); // Load data initially
  }

  @override
  Widget build(BuildContext context) {
    return items.isEmpty
        ? Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset("assets/images/no quest.gif", fit: BoxFit.fill),
        )
        : Padding(
          padding: const EdgeInsets.all(8.0),
          child: Table(
            border: TableBorder.all(color: Colors.black, width: 1),
            defaultVerticalAlignment: TableCellVerticalAlignment.middle,
            columnWidths: {
              0: FlexColumnWidth(1.5),
              1: FlexColumnWidth(1.5),
              2: FlexColumnWidth(1.5),
            },
            children: [
              // Header row
              TableRow(
                decoration: BoxDecoration(color: Colors.brown[100]),
                children: [
                  tableCell("القسط الشهري", isHeader: true),
                  tableCell("المیعاد", isHeader: true),
                  tableCell("ملاحظات", isHeader: true),
                ],
              ),
              // Data rows
              for (var item in items)
                TableRow(
                  children: [
                    tableCell(item['monyflow']),
                    tableCell(item['date']),
                    tableCell(item['notes']),
                  ],
                ),
            ],
          ),
        );
  }

  Widget tableCell(String text, {bool isHeader = false}) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Center(
        child: Text(
          text,
          style: TextStyle(
            fontWeight: isHeader ? FontWeight.bold : FontWeight.normal,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
