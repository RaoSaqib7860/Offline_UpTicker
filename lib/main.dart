import 'dart:io';
import 'package:facebook_analytics/facebook_analytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:upticker/ApiConfig/APiUtil.dart';
import 'package:upticker/ColorsThems/ThemesColors.dart';
import 'package:page_transition/page_transition.dart';
import 'package:upticker/Pages/FinalHomePage.dart';
import 'package:upticker/Pages/Login.dart';
import 'package:provider/provider.dart';
import 'package:upticker/Provider/BlockFinalHomePage.dart';
import 'package:upticker/Provider/LoginBlock.dart';
import 'package:flutter/foundation.dart';
import 'package:device_info/device_info.dart';
import 'package:upticker/SharedPreference/SharedPreference.dart';
import 'package:overlay_support/overlay_support.dart';
import 'ServicesForApp/FireBaseAnalytics.dart';
import 'ServicesForApp/OverlaySupport.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  static GlobalKey<ScaffoldState> scaffoldKey;
  static FirebaseAnalytics analytics = FirebaseAnalytics();
  static FirebaseAnalyticsObserver observer =
      FirebaseAnalyticsObserver(analytics: analytics);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    return OverlaySupport(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'UpTicker',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: MyHomePage(
          title: 'UpTicker',
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({
    Key key,
    this.title,
  }) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  FirebaseMessaging _fcm = FirebaseMessaging();
  bool isnotify;

  Future handleNotificatio(BuildContext context) async {
    await initialize(context);
  }
  final facebookAnalytics = FacebookAnalytics();
  @override
  initState() {
    Future<String> token = SharedPreferenceClass.getuserIDSF();
    token.then((value) => {ApiUtils.token = value});
    handleNotificatio(context);
    _fcm.getToken().then((value) =>
        {print('fcm token is = $value'), ApiUtils.firebasetoken = value});
    _getId().then((value) => {ApiUtils.deviceID = value});
    DateTime dt = DateTime.now();
    Future<String> image = SharedPreferenceClass.getuserImage();
    image.then((value) => {ApiUtils.userImage = value});
    Future<String> name = SharedPreferenceClass.getUserName();
    name.then((value) => {ApiUtils.fistName = value});
    Future<String> five_minute_sound =
        SharedPreferenceClass.five_minute_sound();
    five_minute_sound.then((value) => {ApiUtils.five_minute_sound = value});
    Future<String> five_second_sound =
        SharedPreferenceClass.five_second_sound();
    five_second_sound.then((value) => {ApiUtils.five_second_sound = value});
    Future<String> complete_sound = SharedPreferenceClass.complete_sound();
    complete_sound.then((value) => {ApiUtils.complete_sound = value});
    Future<String> notifications = SharedPreferenceClass.notifications();
    notifications.then((value) => {ApiUtils.notifications = value});
    Future<String> pop_up = SharedPreferenceClass.pop_up();
    pop_up.then((value) => {ApiUtils.pop_up = value});
    Future.delayed(Duration(seconds: 3), () {
      if (isnotify != true) {
        Future<String> token = SharedPreferenceClass.getuserIDSF();
        token.then((value) => {
              if (value != null)
                {
                  ApiUtils.token = value,
                  Navigator.push(
                      context,
                      PageTransition(
                          duration: Duration(milliseconds: 50),
                          type: PageTransitionType.rightToLeft,
                          child: ChangeNotifierProvider(
                            create: (_) => BlockFinalHomePage(),
                            child: FinalHomePageClass(
                              token: value,
                            ),
                          ))),
                  ApiUtils.timeOffset(timezone: '${dt.timeZoneOffset}'),
                }
              else
                {
                  Navigator.push(
                      context,
                      PageTransition(
                          duration: Duration(milliseconds: 50),
                          type: PageTransitionType.rightToLeft,
                          child: ChangeNotifierProvider(
                            create: (_) => BlockLogin(),
                            child: LoginPage(),
                          )))
                }
            });
      }
    });
    FireBaseAnalyticsServices.setCurrentScreen(
        screenClass: 'Initial Page UpTicker', screenName: 'Initial Page');
    facebookAnalytics.logEvent(
      name: "UpTicker_Event for ios plugin",
      parameters: {"value": 10, "subname": "exampleStringValue"},
    );
    super.initState();
  }

  Future initialize(BuildContext context) async {
    FirebaseMessaging _fcm = FirebaseMessaging();
    if (Platform.isIOS) {
      _fcm.configure(onMessage: (Map<String, dynamic> message) async {
        print('on messaging;$message');
        Map map = message;
        InAppPushNotification.inAppnotifi(
            context: context,
            title: '${map['aps']['alert']['title']}',
            subTitle: '${map['aps']['alert']['body']}');
        navigationService(message, context);
      }, onLaunch: (Map<String, dynamic> message) async {
        print('on launch;$message');
        isnotify = true;
        setState(() {
          isnotify = true;
        });
        navigationService(message, context);
      }, onResume: (Map<String, dynamic> message) async {
        print('on resume;$message');
        isnotify = true;
        setState(() {
          isnotify = true;
        });
        navigationService(message, context);
      });
      _fcm.requestNotificationPermissions(IosNotificationSettings());
      _fcm.requestNotificationPermissions(const IosNotificationSettings(
          sound: true, badge: true, alert: true, provisional: false));
      _fcm.onIosSettingsRegistered.listen((IosNotificationSettings settings) {
        print("Settings registered: $settings");
      });
    } else {
      _fcm.configure(onMessage: (Map<String, dynamic> message) async {
        print('on messaging;$message');
        Map map = message;
        InAppPushNotification.inAppnotifi(
            context: context,
            title: '${map['notification']['title']}',
            subTitle: '${map['notification']['body']}');
      }, onLaunch: (Map<String, dynamic> message) async {
        print('on launch;$message');
        isnotify = true;
        setState(() {
          isnotify = true;
        });
        navigationService(message, context);
      }, onResume: (Map<String, dynamic> message) async {
        print('on resume;$message');
        isnotify = true;
        setState(() {
          isnotify = true;
        });
        navigationService(message, context);
      });
    }
  }

  void navigationService(Map<String, dynamic> message, BuildContext context) {
    print('on messaging;$message');
    if (Platform.isIOS) {
      var data = message;
      Map map = data;
      if (map.containsKey('task_id')) {
        ApiUtils.getsigleTaskData(context: context, id: map['task_id']);
      }
    } else {
      var data = message;
      Map map = data['data'];
      if (map.containsKey('task_id')) {
        ApiUtils.getsigleTaskData(context: context, id: map['task_id']);
      }
    }
  }

  Future<String> _getId() async {
    var deviceInfo = DeviceInfoPlugin();
    if (Platform.isIOS) {
      // import 'dart:io'
      IosDeviceInfo iosDeviceInfo = await deviceInfo.iosInfo;
      return iosDeviceInfo.identifierForVendor;
    } else {
      AndroidDeviceInfo androidDeviceInfo = await deviceInfo.androidInfo;
      return androidDeviceInfo.androidId; // unique ID on Android
    }
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    MyApp.scaffoldKey = _scaffoldKey;
    return Scaffold(
        key: _scaffoldKey,
        body: Container(
          height: height,
          width: width,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(left: width / 3, right: width / 3),
                  child: Image.asset('assets/layer.png', color: Colors.white),
                ),
                SizedBox(
                  height: width / 50,
                ),
                Padding(
                  padding: EdgeInsets.only(left: width / 3, right: width / 3),
                  child: Image.asset(
                    'assets/uptickerLogo.png',
                    color: Colors.white,
                  ),
                ),
                SizedBox(
                  height: width / 50,
                ),
                Text(
                  'ALWAYS IMPROVING',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      letterSpacing: 0.3,
                      fontWeight: FontWeight.w300),
                ),
              ],
            ),
          ),
          decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
            ColorsThemes.orangeColors,
            ColorsThemes.redColors,
            ColorsThemes.orangeColors,
          ], begin: Alignment.topRight, end: Alignment.bottomLeft)),
        ));
  }
}
