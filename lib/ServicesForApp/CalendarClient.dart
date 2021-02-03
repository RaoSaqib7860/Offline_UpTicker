import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:oauth2_client/google_oauth2_client.dart';
import 'package:oauth2_client/oauth2_client.dart';
import 'package:upticker/ApiConfig/APiUtil.dart';
import 'package:url_launcher/url_launcher.dart';

class CalendarClient {
  insertGoogleCalender(
      {String token, BuildContext context, bool isfirst}) async {
    GoogleOAuth2Client client = GoogleOAuth2Client(
      customUriScheme: 'com.epochs.upticker',
      redirectUri: 'com.epochs.upticker:/oauth2redirect',
    );
    var tknResp = await client.getTokenWithAuthCodeFlow(
        clientId:
            '482670398286-dk9o8lagd95dds1dq6aj8plr74ikijh4.apps.googleusercontent.com',
        scopes: [
          'https://www.googleapis.com/auth/calendar',
        ]);
    print('aaaaaaaaaaaaaaaaaaaaaaaaaaaaa in = ${tknResp.accessToken}');
    print('rrrrrrrrrrrrrrrrrrrrrrrrrrrrr${tknResp.refreshToken}');

    ApiUtils.calenderAccess(
        context: context,
        isfirst: true,
        accesstoken: '${tknResp.accessToken}',
        refreshtoken: '${tknResp.refreshToken}',
        expire: "${tknResp.expiresIn}",
        wichCalender: 'Google',
        wich: 'google');
  }

  void prompt(String url) async {
    if (await canLaunch(url)) {
      await launch(
        url,
      );
    } else {
      throw 'Could not launch $url';
    }
  }

  Future<void> fetchOutlookCalender({
    BuildContext context,
  }) async {
    var tknResp;
    if(Platform.isAndroid || Platform.isIOS){
      var client = OAuth2Client( authorizeUrl: "https://login.microsoftonline.com/common/oauth2/v2.0/authorize",
          tokenUrl: "https://login.microsoftonline.com/common/oauth2/v2.0/token",
          redirectUri: "msauth.com.epochsitSolution.upticker://auth",
          customUriScheme: "msauth.com.epochsitSolution.upticker");
       tknResp = await client.getTokenWithAuthCodeFlow(
          clientId: '32502b36-55e3-44b7-88ab-cf8d0ce273db',
          clientSecret: '3z~a6Z5oc-zsi07-ZZ-YyE838R3z-Tw~PG',
          scopes: ['https://graph.microsoft.com/Calendars.Read']);
    }else{
      var client = OAuth2Client(
          authorizeUrl:
          'https://login.microsoftonline.com/common/oauth2/v2.0/authorize',
          tokenUrl: 'https://login.microsoftonline.com/common/oauth2/v2.0/token',
          redirectUri: '://oauth2redirect',
          customUriScheme: '');
       tknResp = await client.getTokenWithAuthCodeFlow(
          clientId: '32502b36-55e3-44b7-88ab-cf8d0ce273db',
          scopes: ['openid profile offline_access user.read calendars.read']);
    }
    print('aaaaaaaaaaaaaaaaaaaaaaaaaaaaa in = ${tknResp.accessToken}');
    print('rrrrrrrrrrrrrrrrrrrrrrrrrrrrr${tknResp.refreshToken}');
    ApiUtils.calenderAccess(
        context: context,
        accesstoken: '${tknResp.accessToken}',
        refreshtoken: '${tknResp.refreshToken}',
        expire: "${tknResp.expiresIn}",
        wich: 'outlook',
        isfirst: true,
        wichCalender: 'Outlook');
  }
}
