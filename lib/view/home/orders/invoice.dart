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
  var _orderedPrdInvoive = <OrderInvoiceLineItem?>[].obs;

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
        body: Obx(
          () => _orderedPrdInvoive.length != 0 && _orderInvoive.length != 0
              ? SingleChildScrollView(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (_orderedPrdInvoive.length != 0 &&
                            _orderInvoive.length != 0)
                          customText('INVOICE', black, 18,
                              fontWeight: FontWeight.bold),
                        SizedBox(
                          height: 15,
                        ),
                        customText('CITS Limited | YeahJamaika.com', black, 15),
                        customText('Exed Entrepreneur Center ', black, 15),
                        customText('137 Mountain View Ave ', black, 15),
                        customText('Kingston 3, Jamaica WI', black, 15),
                        customText('Phone: ', black, 15),
                        SizedBox(
                          height: 15,
                        ),
                        customText('Customer Info: ', black, 15,
                            fontWeight: FontWeight.bold),
                        customText(
                            '${_orderInvoive[0]!.shippingAddress}', black, 15),
                        customText('Order#: ${_orderInvoive[0]!.orderNumber}',
                            black, 15),
                        customText(
                            'Invoice-ID#: ${_orderInvoive[0]!.invoiceId}',
                            black,
                            15),
                        customText(
                            'Payment Method: ${_orderInvoive[0]!.paymentMethod}',
                            black,
                            15),
                        customText(
                            'Invoice Date: ${_orderInvoive[0]!.invoiceDate}',
                            black,
                            15),
                        customText('Order Date: ${_orderInvoive[0]!.orderDate}',
                            black, 15),
                        SizedBox(
                          height: 15,
                        ),
                        Divider(),
                        _orderedPrdInvoive.length == 0
                            ? customText('No item available', red, 20)
                            : SizedBox(
                                width: 1.sw,
                                child: ListView.separated(
                                  shrinkWrap: true,
                                  primary: false,
                                  separatorBuilder: (_, __) => SizedBox(
                                    height: 10,
                                  ),
                                  itemCount: _orderedPrdInvoive.length,
                                  itemBuilder: (_, int i) {
                                    return Row(
                                      children: [
                                        customText(
                                            '${_orderedPrdInvoive[0]!.quantity}',
                                            grey,
                                            15),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Flexible(
                                            child: customText(
                                                '${_orderedPrdInvoive[0]!.productName}',
                                                grey,
                                                15)),
                                        customText(
                                            'JMD\$${_orderedPrdInvoive[0]!.productPurchasePrice}',
                                            grey,
                                            15),
                                      ],
                                    );
                                  },
                                ),
                              ),
                        Divider(),
                        customText(
                            'Sub-Total: JMD\$${_orderInvoive[0]!.invoiceSubTotal}',
                            black,
                            15,
                            fontWeight: FontWeight.bold),
                        customText(
                            'Service-Fee: JMD\$${_orderInvoive[0]!.invoiceSubTotal}',
                            black,
                            15,
                            fontWeight: FontWeight.bold),
                        customText(
                            'Shipping & Handiling: JMD\$${_orderInvoive[0]!.shippingAndHandlingCost}',
                            black,
                            15,
                            fontWeight: FontWeight.bold),
                        customText(
                            'Tax: JMD\$${_orderInvoive[0]!.tax}', black, 15,
                            fontWeight: FontWeight.bold),
                        customText(
                            'Coupon/Discount/Saving: JMD\$${_orderInvoive[0]!.couponDiscount}',
                            black,
                            15,
                            fontWeight: FontWeight.bold),
                        customText(
                            'Total: JMD\$${_orderInvoive[0]!.total}', black, 15,
                            fontWeight: FontWeight.bold),
                        Divider(),
                        customText('Total may include canceled items', red, 10,
                            fontWeight: FontWeight.bold),
                        SizedBox(
                          width: 1.sw,
                          child: ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                                primary: grey,
                                onPrimary: black,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10))),
                            child: Text('Print'),
                          ),
                        ),
                      ]),
                )
              : Center(child: CircularProgressIndicator()),
        ));
  }

  void _invoice({required String oderNo}) async {
    showProgress(context);

    var result = await networkcallService.getInvoiceAPICall(
        orderNumber: oderNo, userID: sp.getUserId().toString());
    _orderInvoive.value = result!.orderInvoiceInfo;
    _orderedPrdInvoive.value = result.orderInvoiceLineItem;
    hideProgress(context);
  }
}
