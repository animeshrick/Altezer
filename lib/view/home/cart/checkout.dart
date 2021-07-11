import 'package:altezar/api/apiCall.dart';
import 'package:altezar/models/confirmedModel.dart';
import 'package:altezar/utils/const.dart';
import 'package:altezar/view/widgets/detailsPageAppBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CheckOut extends StatefulWidget {
  final String orderNo;

  const CheckOut({Key? key, required this.orderNo}) : super(key: key);

  @override
  _CheckOutState createState() => _CheckOutState();
}

class _CheckOutState extends State<CheckOut> {
  var _result = <ConfOrderInfo>[].obs;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      _resultConf();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(50.0), child: detailsPageAppBar()),
        body: Obx(
          () => Padding(
            padding: const EdgeInsets.all(20.0),
            child: _result.length != 0
                ? SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        customText(
                            'Thank you very much. You will receive an order confirmation email. Please remember to also check your junk email if the order confirmation does not show up in your regular email.',
                            greenColor,
                            15),
                        SizedBox(
                          height: 15,
                        ),
                        customText(
                            'Your order Number : ${_result[0].productOrderId}',
                            black,
                            15),
                        customText(
                            'Order Date : ${_result[0].timeStamp}', black, 15),
                        if (_result[0].orderFinalTotal != null)
                          customText(
                              'Total Order : ${_result[0].orderFinalTotal}',
                              black,
                              15),
                        customText(
                            'Name : ${_result[0].firstName} ${_result[0].lastName}',
                            black,
                            15),
                        customText(
                            'Contact : ${_result[0].phoneNumber}', black, 15),
                        SizedBox(
                          height: 15,
                        ),
                        RichText(
                          text: TextSpan(
                            children: <TextSpan>[
                              TextSpan(
                                  text:
                                      'To check the status of your order, track progress or view order details please click the ',
                                  style: TextStyle(color: black, fontSize: 30)),
                              TextSpan(
                                  text: 'myYJ Portal ',
                                  style: TextStyle(color: blue, fontSize: 30)),
                              TextSpan(
                                  text:
                                      ' link. Please print this confirmation or write down your order number and bring with you to pick-up your order. ',
                                  style: TextStyle(color: black, fontSize: 30)),
                            ],
                          ),
                          textScaleFactor: 0.5,
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        RichText(
                          text: TextSpan(
                            children: <TextSpan>[
                              TextSpan(
                                  text:
                                      'If your personal information or shipping address is incorrect please click ',
                                  style: TextStyle(color: black, fontSize: 30)),
                              TextSpan(
                                  text: 'here ',
                                  style: TextStyle(color: blue, fontSize: 30)),
                              TextSpan(
                                  text: 'to change it IMMEDIATELY',
                                  style: TextStyle(color: black, fontSize: 30)),
                            ],
                          ),
                          textScaleFactor: 0.5,
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Center(
                          child: Image.asset(
                            logoImage,
                            height: 0.1.sh,
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Center(
                          child: Image.asset(
                            yj,
                            height: 0.1.sh,
                          ),
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        customText(
                            '© 2021 - YeahJamaica.com a Product of CITS Jamaica Limited',
                            black,
                            18),
                      ],
                    ),
                  )
                : Center(child: CircularProgressIndicator()),
          ),
        ));
  }

  void _resultConf() async {
    showProgress(context);
    _result.value =
        (await networkcallService.getConfPayment(orderNumber: widget.orderNo))!;
    hideProgress(context);
  }
}
