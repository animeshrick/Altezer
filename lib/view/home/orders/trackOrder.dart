import 'package:altezar/api/apiCall.dart';
import 'package:altezar/models/orderTrackingModel.dart';
import 'package:altezar/utils/const.dart';
import 'package:altezar/utils/sharedPref.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TrackOrder extends StatefulWidget {
  final String orderID;

  const TrackOrder({Key? key, required this.orderID}) : super(key: key);

  @override
  _TrackOrderState createState() => _TrackOrderState();
}

class _TrackOrderState extends State<TrackOrder> {
  var _trackOrder = OrderTrackingModel().obs;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      _trackOrders();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 15,
            ),
            Center(
                child: customText('Your Delivery Information', black, 25,
                    fontWeight: FontWeight.bold)),
            Obx(() => Padding(
                  padding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
                  child: _trackOrder.value.orderTrackingDetails == null
                      ? customText('Loading .... ', red, 16)
                      : Container(
                          padding: const EdgeInsets.fromLTRB(10, 10, 10, 30),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: black,
                            ),
                          ),
                          child: ListView.separated(
                            shrinkWrap: true,
                            primary: false,
                            separatorBuilder: (_, __) => SizedBox(
                              height: 15,
                            ),
                            itemCount:
                                _trackOrder.value.orderTrackingDetails!.length,
                            itemBuilder: (_, int i) {
                              var data =
                                  _trackOrder.value.orderTrackingDetails![i];
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  customText(
                                      'Delivered on ${data.deliveryDate} @${data.deliveryTime}',
                                      green,
                                      20),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  customText(
                                      'By ${data.deliveryType}', green, 18),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  customText(
                                      'Tracking# : ${data.deliveryTrackingNumber}',
                                      green,
                                      18),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  customText('Status# : ${data.deliveryStatus}',
                                      green, 18),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  customText('Order# : ${data.orderNumber}',
                                      green, 18),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  customText(
                                      'Estimated Delivery Date# : ${data.estimatedDeliveryDate}',
                                      green,
                                      18),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  customText('Notes/Addresses : ', black, 20),
                                  customText(
                                      'Tracking Updates Status : ', black, 20),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  SizedBox(
                                    width: 1.sw,
                                    child: ListView.separated(
                                      shrinkWrap: true,
                                      primary: false,
                                      separatorBuilder: (_, __) => SizedBox(
                                        height: 15,
                                      ),
                                      itemCount: _trackOrder
                                          .value
                                          .orderTrackingDetails![0]
                                          .deliveryupdatedlist
                                          .length,
                                      itemBuilder: (_, int j) {
                                        var data1 = _trackOrder
                                            .value
                                            .orderTrackingDetails![0]
                                            .deliveryupdatedlist;
                                        return customText(
                                            '${data1[j].timeStamp} | ${data1[j].time} |\n| ${data1[j].actionAndUpdate}',
                                            green,
                                            18);
                                      },
                                    ),
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                ],
                              );
                            },
                          ),
                        ),
                )),
            SizedBox(
              height: 15,
            ),
            Card(
              color: grey,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: customText(
                    '© 2021 - Altezer.com  a Product of CITS Jamaica Limited',
                    black,
                    18),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _trackOrders() async {
    showProgress(context);
    _trackOrder.value = (await networkcallService.getOrderTrackAPICall(
        userId: sp.getUserId().toString(), orderID: widget.orderID))!;
    hideProgress(context);
  }
}
