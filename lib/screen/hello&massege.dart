import 'package:flutter/material.dart';
import 'package:mezaan/models/models.dart';

class HelloMessage extends StatelessWidget {
  final String word;
  HelloMessage({Key? key, required this.word}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Container(
        width: double.infinity,
        height: 150,

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.only(right: 5),
              child: Align(
                alignment: Alignment.topRight,
                child: CircleAvatar(
                  backgroundImage: AssetImage("assets/images/logo (2).png"),
                  radius: 25,
                ),
              ),
            ),
            Container(
              width: ScreenSize.width * 0.8,
              decoration: BoxDecoration(
                color: kPrimaryColor3,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15),
                  bottomLeft: Radius.circular(15),
                  bottomRight: Radius.circular(15),
                ),
              ),
              height: ScreenSize.width / 5,
              child: Text(
                word,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
