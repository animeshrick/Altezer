import 'package:altezar/utils/const.dart';
import 'package:flutter/material.dart';

class RetailSpl extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            customText("Sponsered Ad", black, 20),
            SizedBox(
              height: 15,
            ),
            Image.asset(retailSpl),
          ],
        ),
      ),
    );
  }
}
