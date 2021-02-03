import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:upticker/ApiConfig/APiUtil.dart';
import 'package:upticker/ColorsThems/ThemesColors.dart';
import 'package:upticker/Provider/BlockUserGenderSelection.dart';
import 'package:upticker/ServicesForApp/FireBaseAnalytics.dart';

class ProfileUpdate extends StatefulWidget {
  ProfileUpdate({Key key}) : super(key: key);

  @override
  _ProfileUpdateState createState() => _ProfileUpdateState();
}

class _ProfileUpdateState extends State<ProfileUpdate> {
  bool anim = true;

  @override
  void initState() {
    _gpsService();
    getLocation();
    FireBaseAnalyticsServices.setCurrentScreen(
        screenName: 'Profile', screenClass: 'Profile class');
    super.initState();
  }

  LatLng latLng;

  Future<void> getLocation() async {
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) {
      if (position != null) {
        setState(() {
          latLng = LatLng(position.latitude, position.longitude);
          print('lat${latLng.latitude}');
          print('long${latLng.latitude}');
        });
      }
    });
  }

  Future _gpsService() async {
    if (!(await Geolocator.isLocationServiceEnabled())) {
      _checkGps();
      return null;
    } else
      return true;
  }

  Future _checkGps() async {
    if (!(await Geolocator.isLocationServiceEnabled())) {
      if (Theme.of(context).platform == TargetPlatform.android) {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text("Can't get Current location"),
                content:
                    const Text('Please make sure you enable GPS and try again'),
                actions: <Widget>[
                  FlatButton(
                      child: Text('Ok'),
                      onPressed: () {
                        Navigator.of(context).pop();
                        /*final AndroidIntent intent = AndroidIntent(
                            action:
                                'android.settings.LOCATION_SOURCE_SETTINGS');
                        intent.launch();
                        Navigator.of(context, rootNavigator: true).pop();
                        _gpsService();*/
                      })
                ],
              );
            });
      }
    }
  }

  Future<bool> onbackpress() async {
    return false;
  }

  @override
  Widget build(BuildContext context) {
    final BlockUserGenderSelection _provider =
        Provider.of<BlockUserGenderSelection>(context);

    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        key: _provider.scaffoldKey,
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            Container(
              height: height,
              width: width,
              padding: EdgeInsets.all(width / 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: height / 10),
                  Text(
                    'With what gender do you most identify ?',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black.withOpacity(0.7),
                      fontSize: 20,
                    ),
                  ),
                  Column(
                    children: _provider.listindex.map((e) {
                      return Column(
                        children: [
                          SizedBox(
                            height: height / 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: width / 5,
                              ),
                              _provider.list[e] == true
                                  ? InkWell(
                                      splashColor: Colors.white,
                                      highlightColor: Colors.white,
                                      onTap: () {
                                        setState(() {
                                          _provider.list[e] = false;
                                        });
                                        _provider.setGneder('Select Gender');
                                      },
                                      child: Container(
                                          height: height / 40,
                                          width: width / 20,
                                          decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: ColorsThemes.mailColors)),
                                    )
                                  : InkWell(
                                      splashColor: Colors.white,
                                      highlightColor: Colors.white,
                                      onTap: () {
                                        for (var i = 0;
                                            i < _provider.list.length;
                                            i++) {
                                          setState(() {
                                            _provider.list[i] = false;
                                          });
                                        }
                                        setState(() {
                                          _provider.list[e] = true;
                                        });
                                        _provider.setGneder(
                                            '${_provider.listgender[e]}');
                                      },
                                      child: Container(
                                          height: height / 40,
                                          width: width / 20,
                                          decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              border: Border.all(
                                                  color:
                                                      ColorsThemes.mailColors,
                                                  width: 2))),
                                    ),
                              SizedBox(
                                width: width / 10,
                              ),
                              Text(
                                '${_provider.listgender[e]}',
                                style: TextStyle(
                                    color: Colors.black.withOpacity(0.7),
                                    fontSize: 15),
                              ),
                            ],
                          )
                        ],
                      );
                    }).toList(),
                  ),
                  SizedBox(
                    height: height / 10,
                  ),
                  InkWell(
                    splashColor: Colors.white,
                    highlightColor: Colors.white,
                    onTap: () {
                      DatePicker.showDatePicker(context,
                          showTitleActions: true,
                          minTime: DateTime(1880, 3, 5),
                          maxTime: DateTime(2020, 6, 7),
                          theme: DatePickerTheme(
                              headerColor: Colors.white,
                              backgroundColor: Colors.white,
                              itemStyle:
                                  TextStyle(color: Colors.black, fontSize: 14),
                              doneStyle: TextStyle(
                                  color: Colors.blue,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold)),
                          onChanged: (date) {
                        String a = '$date';
                        List st = a.split(' ');
                        print('Date is = ${st[0]}');
                        _provider.setuploaddate('${st[0]}');
                        _provider.setDate(
                            '${(date.day).toString().length == 1 ? '0' : ''}${date.day} / ${(date.month).toString().length == 1 ? '0' : ''}${(date.month)} / ${date.year}');
                      },
                          onConfirm: (date) {},
                          currentTime: DateTime.now(),
                          locale: LocaleType.en);
                    },
                    child: AnimatedContainer(
                      duration: Duration(seconds: 300),
                      height: height / 20,
                      width: width / 2,
                      child: Row(
                          children: [
                            Text(
                              '${_provider.date}',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center),
                      decoration: BoxDecoration(
                          color: ColorsThemes.mailColors,
                          borderRadius: BorderRadius.circular(5)),
                    ),
                  ),
                  SizedBox(
                    height: height / 10,
                  ),
                  InkWell(
                    splashColor: Colors.white,
                    highlightColor: Colors.white,
                    onTap: () {
                      if (_provider.gender != 'Select Gender' &&
                          _provider.date != 'Date of Birth') {
                        if (_provider.apiCall == false) {
                          _provider.setapiCall(true);
                          ApiUtils.putuserGenderPageData(
                              context: context, provider: _provider);
                        }
                      }
                    },
                    child: Container(
                      height: height / 20,
                      width: width / 4,
                      child: Center(
                        child: Text('Next',
                            style: TextStyle(
                                color: Colors.white,
                                letterSpacing: 0.3,
                                fontSize: 12,
                                fontWeight: FontWeight.bold)),
                      ),
                      decoration: BoxDecoration(
                          color: ColorsThemes.mailColors,
                          borderRadius: BorderRadius.circular(5)),
                    ),
                  )
                ],
              ),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: EdgeInsets.all(width / 20),
                child: InkWell(
                  child: Icon(Platform.isAndroid
                      ? Icons.arrow_back
                      : Icons.arrow_back_ios),
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
