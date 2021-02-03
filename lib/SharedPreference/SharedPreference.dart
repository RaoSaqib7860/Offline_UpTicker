import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceClass {
  static addStringToSP(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('user_token', "$token");
  }

  static addImageUrl(String image) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('profile_image', "$image");
  }

  static addUserInapp(String mail) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('user_inApp', "$mail");
  }

  static addUserName(String name) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('user_name', "$name");
  }

  static addfive_minute_sound(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('five_minute_sound', "$token");
  }

  static addfive_second_sound(String image) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('five_second_sound', "$image");
  }

  static addcomplete_sound(String mail) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('complete_sound', "$mail");
  }

  static addnotifications(String name) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('notifications', "$name");
  }

  static addpop_up(String name) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('pop_up', "$name");
  }

  static Future<String> getuserIDSF() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('user_token');
    return token;
  }

  static Future<String> getuserImage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('profile_image');
    return token;
  }

  static Future<String> getInApp() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('user_inApp');
    return token;
  }

  static Future<String> getUserName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('user_name');
    return token;
  }

  static Future<String> five_minute_sound() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('five_minute_sound');
    return token;
  }

  static Future<String> five_second_sound() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('five_second_sound');
    return token;
  }

  static Future<String> complete_sound() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('complete_sound');
    return token;
  }

  static Future<String> notifications() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('notifications');
    return token;
  }

  static Future<String> pop_up() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('pop_up');
    return token;
  }

  static removeValues() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove("user_token");
    prefs.remove("profile_image");
    // prefs.remove("user_email");
    prefs.remove("user_name");
    prefs.remove("five_minute_sound");
    prefs.remove("five_second_sound");
    prefs.remove("complete_sound");
    prefs.remove("notifications");
    prefs.remove("pop_up");
  }
}
