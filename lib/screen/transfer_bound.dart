import 'package:flutter/material.dart';
import 'package:mezaan/models/models.dart';
import 'package:mezaan/screen/hello&massege.dart';

class TransferBound extends StatefulWidget {
  const TransferBound({super.key});

  @override
  State<TransferBound> createState() => _TransferBoundState();
}

class _TransferBoundState extends State<TransferBound> {
  TextEditingController bound = TextEditingController();
  String selectedCurrency = " اختر الدولة";
  double result = 0.0;
  void convertCurrency() {
    final amount = double.tryParse(bound.text) ?? 0.0;
    final rate = moneyFelow[selectedCurrency] ?? 0.0;

    setState(() {
      result = amount / rate;
    });
  }

  @override
  Widget build(BuildContext context) {
    ScreenSize.init(context);

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: kPrimaryColor,
        body: ListView(
          scrollDirection: Axis.vertical,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                HelloMessage(
                  word:
                      "في هذة الغرفة يمكنك تحويل العملات الي قيمتها الدولارية",
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text("اختر العمله المراد تحويلها"),
                    DropdownButton(
                      hint: Text(selectedCurrency),
                      items:
                          items
                              .map(
                                (e) => DropdownMenuItem(
                                  child: Text("$e"),
                                  value: e,
                                ),
                              )
                              .toList(),
                      onChanged: (val) {
                        selectedCurrency = val!;
                        setState(() {});
                      },
                    ),
                  ],
                ),
                Center(
                  child: Container(
                    margin: EdgeInsets.only(top: 10),
                    width: ScreenSize.width / 2,
                    height: ScreenSize.height * 0.1,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: TextField(
                      controller: bound,
                      decoration: InputDecoration(
                        hintText: selectedCurrency,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 25),
                Center(
                  child: InkWell(
                    child: Container(
                      width: ScreenSize.width / 2.5,
                      height: ScreenSize.height * 0.1,
                      decoration: BoxDecoration(
                        color: kPrimaryColor3,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Center(
                        child: Text(
                          "تحويل",
                          style: TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    onTap: () {
                      convertCurrency();
                    },
                  ),
                ),
                SizedBox(height: 25),

                Center(
                  child: Container(
                    width: ScreenSize.width * 0.5,

                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.green, width: 2.0),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Center(
                      child: Text(
                        "${(result).toStringAsFixed(3)} = USD",
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
