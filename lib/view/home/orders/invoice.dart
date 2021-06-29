import 'package:altezar/api/apiCall.dart';
import 'package:altezar/models/invoiceModel.dart';
import 'package:altezar/utils/const.dart';
import 'package:altezar/utils/sharedPref.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class InvoicePage extends StatefulWidget {
  final String ordNo;

  const InvoicePage({Key? key, required this.ordNo}) : super(key: key);

  @override
  _InvoicePageState createState() => _InvoicePageState();
}

class _InvoicePageState extends State<InvoicePage> {
  var _orderInvoive = <OrderInvoiceInfo?>[].obs;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      _invoice(oderNo: widget.ordNo);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: appbarColor,
        title: Row(
          children: [
            IconButton(
                onPressed: () => Get.back(), icon: Icon(Icons.arrow_back)),
            SizedBox(
              width: 0.2.sw,
            ),
            Image.asset(
              appbarImg,
              height: 0.1.sh,
            ),
          ],
        ),
      ),
      body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Image.asset(
          appbarImg,
          height: 0.1.sh,
        ),
      ]),
    );
  }

  void _invoice({required String oderNo}) async {
    showProgress(context);
    _orderInvoive.value = await networkcallService.getInvoiceAPICall(
        orderNumber: oderNo, userID: sp.getUserId().toString());
    hideProgress(context);
  }
}
