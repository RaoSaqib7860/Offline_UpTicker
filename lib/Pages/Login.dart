import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:upticker/ApiConfig/APiUtil.dart';
import 'package:upticker/ColorsThems/ThemesColors.dart';
import 'package:upticker/InternetConnectivity/InternetConnectivity.dart';
import 'package:upticker/NoConnectionDailog/NoConnectionDailog.dart';
import 'package:upticker/Pages/ForgotPassword.dart';
import 'package:upticker/Pages/SignUp.dart';
import 'package:upticker/Provider/BlockForgetPassword.dart';
import 'package:upticker/Provider/LoginBlock.dart';
import 'package:upticker/Provider/SignUpProvider.dart';
import 'package:upticker/ServicesForApp/FireBaseAnalytics.dart';

import 'PullCalanderPage.dart';

class LoginPage extends StatefulWidget {
  static List defaultlistAfter = [];

  LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool anim = false;

  @override
  void initState() {
    internet();
    Future.delayed(Duration(seconds: 0), () {
      setState(() {
        anim = true;
        print('object');
      });
    });
    FireBaseAnalyticsServices.setCurrentScreen(
        screenClass: 'Login Page', screenName: 'Login');
    super.initState();
  }

  internet() async {
    await InterNetConnectivity.chekInternetConnection();
    if (InterNetConnectivity.internet == false) {
      NoConnectionDailog.connection(context);
    } else {}
  }

  @override
  void dispose() {
    FacebookLogin _facebookSignIn = FacebookLogin();
    GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);
    _facebookSignIn.logOut();
    _googleSignIn.signOut();
    super.dispose();
  }

  Future onBackPress() async {}

  @override
  Widget build(BuildContext context) {
    final BlockLogin _provider = Provider.of<BlockLogin>(context);
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return WillPopScope(
      onWillPop: () => onBackPress(),
      child: Scaffold(
        key: _provider.scaffoldKey,
        backgroundColor: Color(0xFFe6ebf2),
        body: ListView(
          children: <Widget>[
            SizedBox(height: width / 9),
            Center(
              child: Padding(
                padding: EdgeInsets.only(left: width / 3, right: width / 3),
                child: Image.asset(
                  'assets/layer.png',
                  color: ColorsThemes.mailColors,
                ),
              ),
            ),
            SizedBox(
              height: width / 50,
            ),
            Center(
              child: Padding(
                padding: EdgeInsets.only(left: width / 3, right: width / 3),
                child: Image.asset(
                  'assets/uptickerLogo.png',
                  color: ColorsThemes.mailColors,
                ),
              ),
            ),
            SizedBox(
              height: width / 30,
            ),
            Center(
              child: Text(
                'Sign in to continue',
                style: TextStyle(
                    color: Colors.black26,
                    fontSize: 14,
                    letterSpacing: 0.3,
                    fontWeight: FontWeight.w300),
              ),
            ),
            SizedBox(
              height: width / 6,
            ),
            FadeInLeft(
              duration: Duration(seconds: 1),
              child: Container(
                padding: EdgeInsets.only(left: width / 10, right: width / 10),
                child: Container(
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
            ),
            SizedBox(
              height: height / 30,
            ),
            FadeInRight(
              duration: Duration(seconds: 1),
              child: Container(
                width: width,
                height: height / 15,
                padding: EdgeInsets.only(left: width / 10, right: width / 10),
                child: Container(
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
                    obscureText: true,
                    keyboardType: TextInputType.emailAddress,
                    controller: _provider.passwordCon,
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
                        labelText: 'Password',
                        labelStyle: TextStyle(
                            fontSize: 12,
                            color: Colors.black38,
                            fontWeight: FontWeight.w600)),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: height / 20,
            ),
            Container(
              width: width,
              child: Row(
                children: <Widget>[
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          PageTransition(
                              duration: Duration(milliseconds: 500),
                              type: PageTransitionType.rightToLeft,
                              child: ChangeNotifierProvider(
                                create: (_) => BlockForgotPassword(),
                                child: ForgotPassword(),
                              )));
                    },
                    child: Text(
                      'Forgot Password?',
                      style: TextStyle(
                          color: ColorsThemes.orangeColors, fontSize: 12),
                    ),
                  )
                ],
                mainAxisAlignment: MainAxisAlignment.end,
              ),
              padding: EdgeInsets.only(left: width / 10, right: width / 10),
            ),
            SizedBox(
              height: height / 20,
            ),
            InkWell(
              splashColor: Color(0xFFe6ebf2),
              highlightColor: Color(0xFFe6ebf2),
              onTap: () {
                if (_provider.loading == false) {
                  if (_provider.emailCon.text.isNotEmpty &&
                      _provider.passwordCon.text.isNotEmpty) {
                    _provider.setLoding(true);
                    ApiUtils.getLoginCalling(
                        context: context,
                        email: _provider.emailCon.text,
                        password: _provider.passwordCon.text,
                        scaffoldkey: _provider.scaffoldKey,
                        provider: _provider);
                  }
                }
              },
              child: ElasticInUp(
                duration: Duration(seconds: 2),
                child: Container(
                  width: width,
                  height: height / 13,
                  child: Center(
                    child: _provider.loading == false
                        ? Text(
                            'Login',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                letterSpacing: 0.5),
                          )
                        : Container(
                            height: height / 20,
                            width: width / 10,
                            child: SpinKitRotatingCircle(
                              itemBuilder: (BuildContext context, int index) {
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
                  margin: EdgeInsets.only(left: width / 10, right: width / 10),
                ),
              ),
            ),
            SizedBox(
              height: height / 30,
            ),
            Row(
              children: <Widget>[
                Text(
                  'Don\'t have an account?',
                  style: TextStyle(color: Colors.black26, fontSize: 12),
                ),
                SizedBox(
                  width: width / 30,
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        PageTransition(
                            duration: Duration(milliseconds: 500),
                            type: PageTransitionType.rightToLeft,
                            child: ChangeNotifierProvider(
                                create: (BuildContext context) => BlockSignUp(),
                                child: SignUpPage())));
                  },
                  splashColor: Color(0xFFe6ebf2),
                  highlightColor: Color(0xFFe6ebf2),
                  child: Text(
                    'Create a new account',
                    style: TextStyle(
                        color: ColorsThemes.orangeColors, fontSize: 12),
                  ),
                ),
              ],
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
            ),
            SizedBox(
              height: height / 30,
            ),
            Center(
              child: Text(
                'Or connect with',
                style: TextStyle(color: Colors.black26, fontSize: 10),
              ),
            ),
            SizedBox(
              height: height / 40,
            ),
            Row(
              children: <Widget>[
                InkWell(
                  onTap: () {
                    ApiUtils.faceBooklogin(provider: _provider)
                        .then((value) => {
                              ApiUtils.fbLoginrequestSent(provider: _provider),
                            });
                  },
                  splashColor: Color(0xFFe6ebf2),
                  highlightColor: Color(0xFFe6ebf2),
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
                        color: ColorsThemes.fbColors, shape: BoxShape.circle),
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
                )
              ],
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
            ),
            SizedBox(
              width: height / 15,
            ),
          ],
        ),
      ),
    );
  }

  googleLogin(BlockLogin provider) async {
    await ApiUtils.gmailLogin(provider: provider).then((value) => {});
  }
}
