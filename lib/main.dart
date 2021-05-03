import 'package:altezar/utils/sharedPref.dart';
import 'package:altezar/view/home/home.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/screenutil_init.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import 'appController/appController.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
          [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown])
      .then((_) async {
    Provider.debugCheckInvalidValueType = null;
    await sp.init();
    runApp(
      StartApp(),
    );
  });
}

//
class StartApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      navigatorKey: NavigatorStore.navKey,
      debugShowCheckedModeBanner: false,
      home: MyApp(),
    );
  }
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var returnWidget1 = Home();
  // var returnWidget1 = SignUp();

  var scafoldKey = GlobalKey<FormState>();
  var internetStatus = "Unknown";
  var contentmessage = "Unknown";
  final applicationStarterController = Get.put(ApplicationStarterController());

  @override
  void initState() {
    // checkConnection(context);
    super.initState();
  }

  @override
  void dispose() {
    // listener.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return ScreenUtilInit(
      designSize: Size(width, height),
      allowFontScaling: false,
      builder: () => Obx(() {
        var applicationState = applicationStarterController.state.value;
        if (applicationState == ApplicationState.LoggedIn) {
          return returnWidget1;
        } else if (applicationState == ApplicationState.LoggedOut) {
          return returnWidget1;
        } else {
          return returnWidget1;
        }
      }),
    );
  }
}

class NavigatorStore {
  static final navKey = new GlobalKey<NavigatorState>();
}
