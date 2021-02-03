import 'dart:async';
import 'dart:io';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:upticker/ApiConfig/APiUtil.dart';
import 'package:upticker/ColorsThems/ThemesColors.dart';
import 'package:upticker/ServicesForApp/FireBaseAnalytics.dart';

class OTPVareficationPage extends StatefulWidget {
  OTPVareficationPage({Key key, this.email}) : super(key: key);
  final String email;

  @override
  _OTPVareficationPageState createState() => _OTPVareficationPageState();
}

class _OTPVareficationPageState extends State<OTPVareficationPage> {
  var onTapRecognizer;

  TextEditingController textEditingController = TextEditingController();

  // ..text = "123456";

  StreamController<ErrorAnimationType> errorController;

  bool hasError = false;
  String currentText = "";
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    onTapRecognizer = TapGestureRecognizer()
      ..onTap = () {
        Navigator.pop(context);
      };
    errorController = StreamController<ErrorAnimationType>();
    FireBaseAnalyticsServices.setCurrentScreen(
        screenClass: 'Otp Verification class', screenName: 'Otp Verification');
    super.initState();
  }

  @override
  void dispose() {
    errorController.close();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.blue.shade50,
          automaticallyImplyLeading: false,
          leading: IconButton(
              icon: Icon(
                Platform.isAndroid ? Icons.arrow_back : Icons.arrow_back_ios,
                color: Colors.black,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              }),
        ),
        backgroundColor: Colors.blue.shade50,
        key: scaffoldKey,
        body: GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: ListView(
              children: <Widget>[
                SizedBox(height: height / 10),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Text(
                    'OTP Verification',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Form(
                  key: formKey,
                  child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8.0, horizontal: 30),
                      child: PinCodeTextField(
                        length: 6,
                        inputFormatters: <TextInputFormatter>[
                          LengthLimitingTextInputFormatter(6),
                          WhitelistingTextInputFormatter.digitsOnly,
                          BlacklistingTextInputFormatter.singleLineFormatter,
                        ],
                        animationType: AnimationType.fade,
                        validator: (v) {
                          if (v.length < 3) {
                            return "";
                          } else {
                            return null;
                          }
                        },
                        pinTheme: PinTheme(
                          shape: PinCodeFieldShape.box,
                          borderRadius: BorderRadius.circular(5),
                          fieldHeight: 50,
                          fieldWidth: 40,
                          activeFillColor: hasError
                              ? ColorsThemes.orangeColors
                              : Colors.white,
                        ),
                        animationDuration: Duration(milliseconds: 300),
                        backgroundColor: Colors.blue.shade50,
                        enableActiveFill: true,
                        errorAnimationController: errorController,
                        controller: textEditingController,
                        onCompleted: (v) {
                          print("Completed");
                        },
                        onChanged: (value) {
                          setState(() {
                            currentText = value;
                          });
                        },
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30.0),
                  child: Text(
                    hasError ? "Please fill up all the cells properly" : "",
                    style: TextStyle(
                        color: Colors.red,
                        fontSize: 11,
                        fontWeight: FontWeight.w400),
                  ),
                ),
                SizedBox(
                  height: height / 50,
                ),
                InkWell(
                  splashColor: Colors.white,
                  highlightColor: Colors.white,
                  child: Center(
                      child: Text(
                    'Clear Text',
                    style: TextStyle(
                        fontSize: 13, color: ColorsThemes.orangeColors),
                  )),
                  onTap: () {
                    textEditingController.clear();
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: <Widget>[
                    Text(
                      'Didn\'t receive the code? ',
                      style: TextStyle(color: Colors.black54, fontSize: 13),
                    ),
                    InkWell(
                      splashColor: Colors.white,
                      highlightColor: Colors.white,
                      onTap: () {
                        ApiUtils.getResendCodeCalling(
                            context: context,
                            email: widget.email,
                            scaffoldkey: scaffoldKey);
                      },
                      child: Text('RESEND',
                          style: TextStyle(
                              color: ColorsThemes.orangeColors,
                              fontWeight: FontWeight.w500,
                              fontSize: 14)),
                    )
                  ],
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                ),
                SizedBox(
                  height: 14,
                ),
                Container(
                  margin: const EdgeInsets.symmetric(
                      vertical: 16.0, horizontal: 30),
                  child: ButtonTheme(
                    height: 50,
                    child: FlatButton(
                      onPressed: () {
                        formKey.currentState.validate();
                        if (currentText.length != 6) {
                          errorController.add(ErrorAnimationType.shake);
                          setState(() {
                            hasError = true;
                          });
                        } else {
                          setState(() {
                            hasError = false;
                          });
                          ApiUtils.getOTPVareficationCalling(
                              context: context,
                              scaffoldkey: scaffoldKey,
                              otpText: textEditingController.text);
                        }
                      },
                      child: Center(
                          child: Text(
                        "VERIFY".toUpperCase(),
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            letterSpacing: 0.5,
                            fontWeight: FontWeight.w500),
                      )),
                    ),
                  ),
                  decoration: BoxDecoration(
                    color: ColorsThemes.loginColors,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    FlatButton(
                      child: Text(
                        "OTP verification code sent to your email",
                        style: TextStyle(
                            color: ColorsThemes.orangeColors, fontSize: 12),
                      ),
                      onPressed: () {},
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
