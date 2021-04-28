import 'package:altezar/utils/const.dart';
import 'package:altezar/view/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Receipt extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: 1.sw,
          height: .07.sh,
          child: Card(
            color: grey,
            child: Center(
                child: customText('No Order(s) found', Colors.black45, 25.0)),
          ),
        ),
        SizedBox(
          height: 15,
        ),
        Divider(),
        Container(
          decoration: BoxDecoration(border: Border.all(color: black)),
          width: 0.9.sw,
          height: .4.sh,
          child: Card(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 1.sw,
                  height: 0.085.sh,
                  child: ColoredBox(
                      color: grey,
                      child: customText(
                          'Device Orientation', Colors.black45, 25.0)),
                ),
                Divider(),
                SizedBox(height: 20),
                customText(
                    'You May Need To Turn Your Phone/Device Horizontally For a Full View of the Page. ',
                    black,
                    18.0),
                SizedBox(height: 20),
                Center(child: button(() {}, 'Close', Color(0xffEFEFEF), black))
              ],
            ),
          ),
        ),
      ],
    );
  }
}
