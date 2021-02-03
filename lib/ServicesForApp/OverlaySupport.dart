import 'package:flutter/material.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:upticker/ColorsThems/ThemesColors.dart';
import 'package:upticker/main.dart';

class InAppPushNotification {
  static inAppnotifi(
      {String title, String subTitle,BuildContext context,}) {
    BuildContext cc;
    Future.delayed(Duration(seconds: 0), () {
      showSimpleNotification(
        Text(
          "$title",
          style: TextStyle(
              fontSize: 15,
              fontFamily: 'Comfortaa',
              letterSpacing: 0.3,
              color: Colors.black,
              fontWeight: FontWeight.bold),
        ),
        duration: Duration(seconds: 2),
        elevation: 8,
        position: NotificationPosition.top,
        slideDismiss: true,
        subtitle: Text(
          '$subTitle',
          style: TextStyle(
              fontSize: 10,
              fontFamily: 'Comfortaa',
              letterSpacing: 0.3,
              color: Colors.black,
              ),
        ),
        background: Colors.blueGrey[100],
        autoDismiss: false,
        trailing: Builder(builder: (context) {
          cc=context;
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              InkWell(
                child: Text(
                  'Close',
                  style: TextStyle(
                      fontSize: 12,
                      fontFamily: 'Comfortaa',
                      letterSpacing: 0.3,
                      color: Colors.blue,
                      fontWeight: FontWeight.bold),
                ),
                onTap: () {
                  OverlaySupportEntry.of(context).dismiss();
                },
              ),
            ],
          );
        }),
      );
    });
    Future.delayed(Duration(seconds: 4),(){
      OverlaySupportEntry.of(cc).dismiss();
    });
  }
}

