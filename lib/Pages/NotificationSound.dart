import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:upticker/ApiConfig/APiUtil.dart';
import 'package:upticker/ColorsThems/ThemesColors.dart';
import 'package:upticker/Provider/BlockNotificationSound.dart';
import 'package:upticker/SharedPreference/SharedPreference.dart';
import 'AccountSettings.dart';

class NotificationSound extends StatefulWidget {
  final String text;
  final String tag;

  const NotificationSound({Key key, this.text, this.tag}) : super(key: key);

  @override
  _NotificationSoundState createState() => _NotificationSoundState();
}

class _NotificationSoundState extends State<NotificationSound> {
  final assetsAudioPlayer = AssetsAudioPlayer();

  @override
  void initState() {
    final _provider =
        Provider.of<BlockNotificationSound>(context, listen: false);
    _provider.setListOFChecks('${widget.tag}');
    super.initState();
  }

  Future onBackPress() async {
    assetsAudioPlayer.dispose();
    Navigator.of(context).pop();
    Navigator.of(context).pop();
    Navigator.push(
        context,
        PageTransition(
          duration: Duration(milliseconds: 500),
          type: PageTransitionType.rightToLeft,
          child: AccountSettingsPage(),
        ));
  }
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    final _provider = Provider.of<BlockNotificationSound>(context);
    return WillPopScope(
      onWillPop: () => onBackPress(),
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(height / 7.5),
            child: AppBar(
              flexibleSpace: Container(
                decoration: BoxDecoration(color: Colors.white),
                height: height / 7.5,
                child: Container(
                  height: height / 7.5,
                  width: width,
                  child: Stack(
                    children: [
                      Container(
                        margin: EdgeInsets.only(
                            left: width / 10, right: width / 10),
                        height: double.infinity,
                        width: double.infinity,
                        child: Center(
                          child: Container(
                            padding: EdgeInsets.only(top: height / 30),
                            child: InkWell(onTap: (){
                            },
                              child: Text(
                                '${widget.text}',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w300,
                                    letterSpacing: 0.3),
                              ),
                            ),
                          ),
                        ),
                        decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(color: Colors.black38, blurRadius: 2)
                            ],
                            color: ColorsThemes.darkThemeColor,
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(10),
                                bottomRight: Radius.circular(10))),
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: InkWell(
                          onTap: () {
                            Navigator.of(context).pop();
                            Navigator.of(context).pop();
                            Navigator.push(
                                context,
                                PageTransition(
                                  duration: Duration(milliseconds: 500),
                                  type: PageTransitionType.rightToLeft,
                                  child: AccountSettingsPage(),
                                ));
                          },
                          child: Container(
                            margin: EdgeInsets.only(
                                left: width / 30, top: height / 30),
                            height: height / 14,
                            width: width / 7,
                            child: Center(
                              child: Icon(
                                Icons.arrow_back_ios,
                                size: 20,
                                color: ColorsThemes.darkThemeColor,
                              ),
                            ),
                            decoration: BoxDecoration(boxShadow: [
                              BoxShadow(
                                  color: Colors.blueGrey[300], blurRadius: 3)
                            ], shape: BoxShape.circle, color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              elevation: 0,
              backgroundColor: Colors.white,
              automaticallyImplyLeading: false,
            ),
          ),
          body: Container(
            height: height,
            width: width,
            child: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemBuilder: (c, i) {
                      return Container(
                        height: height / 20,
                        width: width,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Text(
                                  '${_provider.listofsound[i]}',
                                  style: TextStyle(fontSize: 15),
                                ),
                              ],
                            ),
                            Checkbox(
                                activeColor: ColorsThemes.mailColors,
                                value: _provider.lisofChecks[i],
                                onChanged: (bool istrue) {
                                  print('${_provider.listofsound[i]}');
                                  assetsAudioPlayer.dispose();
                                  assetsAudioPlayer.open(
                                    Audio(
                                        'assets/audios/${_provider.listofsound[i]}.mp3'),
                                  );
                                  assetsAudioPlayer.play();
                                  for (var j = 0;
                                      j < _provider.lisofChecks.length;
                                      j++) {
                                    setState(() {
                                      _provider.lisofChecks[j] = false;
                                    });
                                  }
                                  setState(() {
                                    _provider.lisofChecks[i] = true;
                                  });
                                  if (widget.text == '5 min notification') {
                                    ApiUtils.UpdateUserData(
                                        key: 'five_minute_sound',
                                        description:
                                            '${_provider.listofsound[i]}');
                                    SharedPreferenceClass.addfive_minute_sound(
                                        '${_provider.listofsound[i]}');
                                    ApiUtils.five_minute_sound =
                                        '${_provider.listofsound[i]}';
                                  } else if (widget.text ==
                                      '5 sec notification') {
                                    ApiUtils.UpdateUserData(
                                        key: 'five_second_sound',
                                        description:
                                            '${_provider.listofsound[i]}');
                                    SharedPreferenceClass.addfive_second_sound(
                                        '${_provider.listofsound[i]}');
                                    ApiUtils.five_second_sound =
                                        '${_provider.listofsound[i]}';
                                  } else if (widget.text == 'Complete') {
                                    ApiUtils.UpdateUserData(
                                        key: 'complete_sound',
                                        description:
                                            '${_provider.listofsound[i]}');
                                    SharedPreferenceClass.addcomplete_sound(
                                        '${_provider.listofsound[i]}');
                                    ApiUtils.complete_sound =
                                        '${_provider.listofsound[i]}';
                                  }
                                })
                          ],
                        ),
                      );
                    },
                    itemCount: _provider.listofsound.length,
                  ),
                ),
                SizedBox(
                  height: height / 100,
                )
              ],
            ),
            padding: EdgeInsets.all(height / 30),
          ),
        ),
      ),
    );
  }
}
