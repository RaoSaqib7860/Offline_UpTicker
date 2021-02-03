import 'dart:io';
import 'dart:math';
import 'dart:ui';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:upticker/ApiConfig/APiUtil.dart';
import 'package:upticker/ColorsThems/ThemesColors.dart';
import 'package:upticker/Pages/Login.dart';
import 'package:upticker/Provider/LoginBlock.dart';
import 'package:upticker/Provider/SignUpProvider.dart';
import 'package:upticker/ServicesForApp/FireBaseAnalytics.dart';

class SignUpPage extends StatefulWidget {
  SignUpPage({Key key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  bool showpassword = false;
  var passKey = GlobalKey<FormFieldState>();
  bool error = false;
  bool doublechckPassword = false;

  @override
  void initState() {
    DateTime dt = DateTime.now();
    print('Time zone name = ${dt.timeZoneName}');
    print('Time zone offset = ${dt.timeZoneOffset}');
    FireBaseAnalyticsServices.setCurrentScreen(
        screenClass: 'SignUp class', screenName: 'SignUp');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final BlockSignUp _provider = Provider.of<BlockSignUp>(context);
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        key: _provider.scaffoldKey,
        backgroundColor: Color(0xFFe6ebf2),
        body: Stack(
          children: [
            Container(
              height: height,
              width: width,
              child: ListView(
                children: <Widget>[
                  SizedBox(
                    height: width / 20,
                  ),
                  Center(
                    child: Padding(
                      padding:
                          EdgeInsets.only(left: width / 3, right: width / 3),
                      child: Image.asset(
                        'assets/layer.png',
                        color: ColorsThemes.mailColors,
                      ),
                    ),
                  ),
                  Center(
                    child: Padding(
                      padding:
                          EdgeInsets.only(left: width / 3, right: width / 3),
                      child: Image.asset(
                        'assets/uptickerLogo.png',
                        color: ColorsThemes.mailColors,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: width / 100,
                  ),
                  Center(
                    child: Text(
                      'Sign up to join us',
                      style: TextStyle(
                          color: Colors.black26,
                          fontSize: 14,
                          letterSpacing: 0.3,
                          fontWeight: FontWeight.w300),
                    ),
                  ),
                  SizedBox(
                    height: height / 40,
                  ),
                  ElasticInLeft(
                    delay: Duration(milliseconds: 500),
                    child: Container(
                      width: width,
                      height: height / 17,
                      margin:
                          EdgeInsets.only(left: width / 10, right: width / 10),
                      decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.white.withOpacity(.7),
                              blurRadius: 3,
                              offset: Offset(
                                -5.0,
                                -5.0,
                              ),
                            ),
                            BoxShadow(
                              color: Colors.black.withOpacity(.11),
                              blurRadius: 3,
                              offset: Offset(
                                3.0,
                                3.0,
                              ),
                            ),
                          ],
                          color: Color(0xFFe6ebf2),
                          borderRadius: BorderRadius.circular(5)),
                      child: TextFormField(
                        controller: _provider.firstNameCon,
                        textCapitalization: TextCapitalization.sentences,
                        style: TextStyle(
                            color: ColorsThemes.orangeColors, fontSize: 14),
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            prefixIcon: Icon(
                              Icons.person,
                              size: 16,
                              color: ColorsThemes.orangeColors,
                            ),
                            contentPadding: EdgeInsets.all(width / 40),
                            labelText: 'First name',
                            labelStyle: TextStyle(
                                fontSize: 12,
                                color: Colors.black38,
                                fontWeight: FontWeight.w600)),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: height / 50,
                  ),
                  ElasticInRight(
                    delay: Duration(milliseconds: 500),
                    child: Container(
                      width: width,
                      height: height / 17,
                      margin:
                          EdgeInsets.only(left: width / 10, right: width / 10),
                      decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.white.withOpacity(.7),
                              blurRadius: 3,
                              offset: Offset(
                                -5.0,
                                -5.0,
                              ),
                            ),
                            BoxShadow(
                              color: Colors.black.withOpacity(.11),
                              blurRadius: 3,
                              offset: Offset(
                                3.0,
                                3.0,
                              ),
                            ),
                          ],
                          color: Color(0xFFe6ebf2),
                          borderRadius: BorderRadius.circular(5)),
                      child: TextFormField(
                        controller: _provider.lastNameCon,
                        textCapitalization: TextCapitalization.sentences,
                        style: TextStyle(
                            color: ColorsThemes.orangeColors, fontSize: 14),
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            prefixIcon: Icon(
                              Icons.person,
                              size: 16,
                              color: ColorsThemes.orangeColors,
                            ),
                            contentPadding: EdgeInsets.all(width / 40),
                            labelText: 'Last name',
                            labelStyle: TextStyle(
                                fontSize: 12,
                                color: Colors.black38,
                                fontWeight: FontWeight.w600)),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: height / 50,
                  ),
                  ElasticInLeft(
                    delay: Duration(milliseconds: 500),
                    child: Container(
                      width: width,
                      height: height / 17,
                      margin:
                          EdgeInsets.only(left: width / 10, right: width / 10),
                      decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.white.withOpacity(.7),
                              blurRadius: 3,
                              offset: Offset(
                                -5.0,
                                -5.0,
                              ),
                            ),
                            BoxShadow(
                              color: Colors.black.withOpacity(.11),
                              blurRadius: 3,
                              offset: Offset(
                                3.0,
                                3.0,
                              ),
                            ),
                          ],
                          color: Color(0xFFe6ebf2),
                          borderRadius: BorderRadius.circular(5)),
                      child: TextFormField(
                        controller: _provider.emailCon,
                        textCapitalization: TextCapitalization.sentences,
                        style: TextStyle(
                            color: ColorsThemes.orangeColors, fontSize: 14),
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            prefixIcon: Icon(
                              Icons.mail,
                              size: 16,
                              color: ColorsThemes.orangeColors,
                            ),
                            contentPadding: EdgeInsets.all(width / 40),
                            labelText: 'Email',
                            labelStyle: TextStyle(
                                fontSize: 12,
                                color: Colors.black38,
                                fontWeight: FontWeight.w600)),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: height / 50,
                  ),
                  ElasticInRight(
                    delay: Duration(milliseconds: 500),
                    child: Container(
                      width: width,
                      height: height / 17,
                      margin:
                          EdgeInsets.only(left: width / 10, right: width / 10),
                      decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.white.withOpacity(.7),
                              blurRadius: 3,
                              offset: Offset(
                                -5.0,
                                -5.0,
                              ),
                            ),
                            BoxShadow(
                              color: Colors.black.withOpacity(.11),
                              blurRadius: 3,
                              offset: Offset(
                                3.0,
                                3.0,
                              ),
                            ),
                          ],
                          color: Color(0xFFe6ebf2),
                          borderRadius: BorderRadius.circular(5)),
                      child: TextFormField(
                        key: passKey,
                        obscureText: showpassword == true ? false : true,
                        keyboardType: TextInputType.emailAddress,
                        controller: _provider.passwordCon,
                        textCapitalization: TextCapitalization.sentences,
                        onChanged: (value) {
                          bool value = validateStructure(
                              _provider.passwordCon.text.toString());
                          if (value == true) {
                            setState(() {
                              error = true;
                            });
                          } else {
                            setState(() {
                              error = false;
                            });
                          }
                        },
                        style: TextStyle(
                            color: ColorsThemes.orangeColors, fontSize: 14),
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            helperStyle:
                                TextStyle(fontSize: 8, color: Colors.red),
                            prefixIcon: Icon(
                              Icons.lock,
                              size: 16,
                              color: ColorsThemes.orangeColors,
                            ),
                            contentPadding: EdgeInsets.all(width / 40),
                            labelText: 'Password',
                            labelStyle: TextStyle(
                                fontSize: 12,
                                color: Colors.black38,
                                fontWeight: FontWeight.w600)),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: height / 100,
                  ),
                  Container(
                    margin:
                        EdgeInsets.only(left: width / 10, right: width / 10),
                    child: Text(
                      error == false ? 'Weak password.' : 'Strong password',
                      style: TextStyle(
                          fontSize: 9,
                          color: error == false ? Colors.red : Colors.green),
                    ),
                  ),
                  SizedBox(
                    height: height / 50,
                  ),
                  ElasticInLeft(
                    delay: Duration(milliseconds: 500),
                    child: Container(
                      width: width,
                      height: height / 17,
                      margin:
                          EdgeInsets.only(left: width / 10, right: width / 10),
                      decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.white.withOpacity(.7),
                              blurRadius: 3,
                              offset: Offset(
                                -5.0,
                                -5.0,
                              ),
                            ),
                            BoxShadow(
                              color: Colors.black.withOpacity(.11),
                              blurRadius: 3,
                              offset: Offset(
                                3.0,
                                3.0,
                              ),
                            ),
                          ],
                          color: Color(0xFFe6ebf2),
                          borderRadius: BorderRadius.circular(5)),
                      child: TextFormField(
                        obscureText: showpassword == true ? false : true,
                        controller: _provider.repasswordCon,
                        keyboardType: TextInputType.emailAddress,
                        textCapitalization: TextCapitalization.sentences,
                        style: TextStyle(
                            color: ColorsThemes.orangeColors, fontSize: 14),
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            prefixIcon: Icon(
                              Icons.lock,
                              size: 16,
                              color: ColorsThemes.orangeColors,
                            ),
                            contentPadding: EdgeInsets.all(width / 40),
                            labelText: 'Re-Enter Password',
                            labelStyle: TextStyle(
                                fontSize: 12,
                                color: Colors.black38,
                                fontWeight: FontWeight.w600)),
                      ),
                    ),
                  ),
                  doublechckPassword == true
                      ? SizedBox(
                          height: height / 100,
                        )
                      : SizedBox(),
                  doublechckPassword == true
                      ? Container(
                          margin: EdgeInsets.only(
                              left: width / 10, right: width / 10),
                          child: Text(
                            'password did not match.',
                            style: TextStyle(fontSize: 9, color: Colors.red),
                          ),
                        )
                      : SizedBox(),
                  Container(
                    margin: EdgeInsets.only(left: width / 20),
                    child: CheckboxListTile(
                      title: Text(
                        "Show password",
                        style: TextStyle(color: Colors.black38, fontSize: 14),
                      ),
                      value: showpassword,
                      onChanged: (newValue) {
                        setState(() {
                          showpassword = newValue;
                        });
                      },
                      controlAffinity: ListTileControlAffinity
                          .leading, //  <-- leading Checkbox
                    ),
                  ),
                  SizedBox(
                    height: height / 100,
                  ),
                  InkWell(
                    splashColor: Color(0xFFe6ebf2),
                    highlightColor: Color(0xFFe6ebf2),
                    onTap: () {
                      bool value = validateStructure(
                          _provider.passwordCon.text.toString());
                      print('$value');
                      if (value == true) {
                        setState(() {
                          error = false;
                        });
                        if (_provider.firstNameCon.text.isNotEmpty &&
                            _provider.lastNameCon.text.isNotEmpty &&
                            _provider.emailCon.text.isNotEmpty &&
                            _provider.passwordCon.text.isNotEmpty &&
                            _provider.repasswordCon.text.isNotEmpty) {
                          if (_provider.passwordCon.text ==
                              _provider.repasswordCon.text) {
                            setState(() {
                              doublechckPassword = false;
                            });
                            _provider.setLoding('do');
                            ApiUtils.getSignUpCalling(
                                firstname: _provider.firstNameCon.text,
                                lastname: _provider.lastNameCon.text,
                                email: _provider.emailCon.text,
                                password: _provider.passwordCon.text,
                                scaffoldkey: _provider.scaffoldKey,
                                context: context,
                                provider: _provider);
                          } else {
                            setState(() {
                              doublechckPassword = true;
                            });
                          }
                        }
                      } else {
                        setState(() {
                          error = true;
                        });
                      }
                    },
                    child: FadeInUpBig(
                      delay: Duration(milliseconds: 500),
                      child: Container(
                        width: width,
                        margin: EdgeInsets.only(
                            left: width / 10, right: width / 10),
                        height: height / 15,
                        child: Center(
                          child: _provider.loading == false
                              ? Text(
                                  'Get Started',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      letterSpacing: 0.5),
                                )
                              : Container(
                                  height: height / 20,
                                  width: width / 10,
                                  child: SpinKitRotatingCircle(
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return DecoratedBox(
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: index.isEven
                                              ? Colors.white
                                              : Colors.white,
                                        ),
                                      );
                                    },
                                  ),
                                ),
                        ),
                        decoration: BoxDecoration(
                            color: ColorsThemes.loginColors,
                            borderRadius: BorderRadius.circular(7)),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: height / 60,
                  ),
                  Row(
                    children: <Widget>[
                      Text(
                        'Already have an account?',
                        style: TextStyle(color: Colors.black26, fontSize: 12),
                      ),
                      InkWell(
                        splashColor: Color(0xFFe6ebf2),
                        highlightColor: Color(0xFFe6ebf2),
                        onTap: () {
                          Navigator.push(
                              context,
                              PageTransition(
                                  duration: Duration(milliseconds: 500),
                                  type: PageTransitionType.leftToRight,
                                  child: ChangeNotifierProvider(
                                    create: (_) => BlockLogin(),
                                    child: LoginPage(),
                                  )));
                        },
                        child: Text(
                          'Sign in',
                          style: TextStyle(
                              color: ColorsThemes.orangeColors, fontSize: 12),
                        ),
                      ),
                    ],
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                  ),
                  SizedBox(
                    height: height / 60,
                  ),
                  Center(
                    child: Text(
                      'Or connect with',
                      style: TextStyle(color: Colors.black26, fontSize: 10),
                    ),
                  ),
                  SizedBox(
                    height: height / 60,
                  ),
                  Row(
                    children: <Widget>[
                      InkWell(
                        splashColor: Color(0xFFe6ebf2),
                        highlightColor: Color(0xFFe6ebf2),
                        onTap: () {
                          ApiUtils.faceBookSignUp(provider: _provider).then(
                              (value) => {
                                    ApiUtils.fbSignrequestSent(
                                        provider: _provider)
                                  });
                        },
                        child: Container(
                          height: height / 16,
                          width: width / 8,
                          child: Padding(
                            padding: EdgeInsets.all(width / 40),
                            child: Image.asset(
                              'assets/fb.png',
                              color: Colors.white,
                            ),
                          ),
                          decoration: BoxDecoration(
                              color: ColorsThemes.fbColors,
                              shape: BoxShape.circle),
                        ),
                      ),
                      SizedBox(
                        width: width / 30,
                      ),
                      InkWell(
                        splashColor: Color(0xFFe6ebf2),
                        highlightColor: Color(0xFFe6ebf2),
                        onTap: () {
                          googleLogin(_provider);
                        },
                        child: InkWell(
                          splashColor: Colors.white,
                          highlightColor: Colors.white,
                          child: Container(
                            height: height / 16,
                            width: width / 8,
                            child: Center(
                                child: Text(
                              'G+',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 12),
                            )),
                            decoration: BoxDecoration(
                                color: Colors.red, shape: BoxShape.circle),
                          ),
                        ),
                      )
                    ],
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                  ),
                  SizedBox(
                    height: height / 20,
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
            )
          ],
        ),
      ),
    );
  }

  googleLogin(BlockSignUp provider) async {
    await ApiUtils.gmailforSignUp(provider: provider).then(
        (value) => {ApiUtils.gmailforSignLoginrequestSent(provider: provider)});
  }

  Widget textfield(String text, BlockSignUp provider) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Container(
      width: width,
      height: height / 15,
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
          color: Colors.black12,
          blurRadius: 5,
          spreadRadius: 2.0,
          offset: Offset(
            3.0,
            5.0,
          ),
        ),
      ], color: Colors.white, borderRadius: BorderRadius.circular(5)),
      child: TextFormField(
        style: TextStyle(color: ColorsThemes.orangeColors, fontSize: 14),
        decoration: InputDecoration(
            border: InputBorder.none,
            prefixIcon: Icon(
              '$text' == 'First Name' || '$text' == 'Last Name'
                  ? Icons.person
                  : '$text' == 'Email'
                      ? Icons.mail
                      : Icons.lock,
              size: 16,
              color: ColorsThemes.orangeColors,
            ),
            contentPadding: EdgeInsets.all(width / 40),
            labelText: '$text',
            labelStyle: TextStyle(
                fontSize: 12,
                color: Colors.black38,
                fontWeight: FontWeight.w600)),
      ),
    );
  }

  bool validateStructure(String value) {
    double fff = estimateBruteforceStrength(value);
    print('value is = $fff');
    if (fff > 0.6) {
      return true;
    } else {
      return false;
    }
  }

  double estimateBruteforceStrength(String password) {
    if (password.isEmpty) return 0.0;
    // Check which types of characters are used and create an opinionated bonus.
    double charsetBonus;
    if (RegExp(r'^[a-z]*$').hasMatch(password)) {
      charsetBonus = 1.0;
    } else if (RegExp(r'^[a-z0-9]*$').hasMatch(password)) {
      charsetBonus = 1.2;
    } else if (RegExp(r'^[a-zA-Z]*$').hasMatch(password)) {
      charsetBonus = 1.3;
    } else if (RegExp(r'^[a-z\-_!?]*$').hasMatch(password)) {
      charsetBonus = 1.3;
    } else if (RegExp(r'^[a-zA-Z0-9]*$').hasMatch(password)) {
      charsetBonus = 1.5;
    } else {
      charsetBonus = 1.8;
    }
    final logisticFunction = (double x) {
      return 1.0 / (1.0 + exp(-x));
    };

    final curve = (double x) {
      return logisticFunction((x / 3.0) - 4.0);
    };

    return curve(password.length * charsetBonus);
  }
}
