import 'package:altezar/api/apiCall.dart';
import 'package:altezar/models/receiptModel.dart';
import 'package:altezar/utils/const.dart';
import 'package:altezar/utils/sharedPref.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class Receipt extends StatefulWidget {
  @override
  _ReceiptState createState() => _ReceiptState();
}

class _ReceiptState extends State<Receipt> {
  var _receiptList = <Transactionslist>[].obs;
  var isShow = false.obs;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      _getReceipt();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Obx(
      () => Column(
        children: [
          isShow.value
              ? SizedBox(
                  width: 1.sw,
                  height: .07.sh,
                  child: Card(
                    color: grey,
                    child: Center(
                        child: customText(
                            'No Order(s) found', Colors.black45, 25.0)),
                  ),
                )
              : SizedBox(
                  width: 1.sw,
                  child: ListView.separated(
                    primary: false,
                    shrinkWrap: true,
                    separatorBuilder: (_, __) => SizedBox(
                      height: 10,
                    ),
                    itemCount: _receiptList.length,
                    itemBuilder: (_, int i) {
                      return Card(
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(15, 15, 15, 15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: 1.sw,
                                child: Card(
                                  margin: EdgeInsets.zero,
                                  color: blue,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: customText(
                                        'Purchased Receipt ', white, 15.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              customText(
                                  'YJR# : ${_receiptList[i].transactionId}',
                                  black,
                                  16),
                              customText(
                                  'Receipt# : ${_receiptList[i].stripePaymentId}',
                                  black,
                                  16),
                              customText(
                                  'Order Number# : ${_receiptList[i].orderNumber}',
                                  black,
                                  16),
                              customText(
                                  'Service Desc : ${_receiptList[i].serviceDescription}',
                                  black,
                                  16),
                              customText(
                                  'Amount : ${_receiptList[i].amountPaid}',
                                  black,
                                  16),
                              customText(
                                  'Payment Date : ${_receiptList[i].stripePaymentDate}',
                                  black,
                                  16),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
        ],
      ),
    ));
  }

  void _getReceipt() async {
    showProgress(context);
    _receiptList.value = await networkcallService.getReciptAPICall(
        userId: sp.getUserId().toString());
    if (_receiptList.length == 0) {
      isShow.value = true;
    } else {
      isShow.value = false;
    }
    hideProgress(context);
  }
}
