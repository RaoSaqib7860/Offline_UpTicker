import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:upticker/ApiConfig/APiUtil.dart';
import 'package:upticker/ColorsThems/ThemesColors.dart';

class ContactUs extends StatefulWidget {
  @override
  _ContactUsState createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {
  TextEditingController _subjectCon = TextEditingController();
  TextEditingController _disCon = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
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
                    margin:
                        EdgeInsets.only(left: width / 10, right: width / 10),
                    height: double.infinity,
                    width: double.infinity,
                    child: Center(
                      child: Container(
                        padding: EdgeInsets.only(top: height / 30),
                        child: Text(
                          'Contact Us',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w300,
                              letterSpacing: 0.3),
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
                      },
                      child: Container(
                        margin:
                            EdgeInsets.only(left: width / 30, top: height / 30),
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
                          BoxShadow(color: Colors.blueGrey[300], blurRadius: 3)
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
      backgroundColor: Colors.white,
      body: Container(
        height: height,
        width: width,
        padding: EdgeInsets.only(
          left: width / 10,
          right: width / 10,
        ),
        child: Column(
          children: [
            FlipInY(
              child: Container(
                width: width,
                decoration: BoxDecoration(
                    color: ColorsThemes.offGraycolor,
                    borderRadius: BorderRadius.circular(8)),
                child: TextFormField(
                  maxLines: 1,
                  textInputAction: TextInputAction.done,
                  controller: _subjectCon,
                  decoration: InputDecoration(
                      hintText: 'Subject',
                      hintStyle: TextStyle(fontSize: 14),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.all(width / 30)),
                ),
              ),
            ),
            SizedBox(
              height: height / 30,
            ),
            FlipInY(
              child: Container(
                height: height / 4,
                width: width,
                decoration: BoxDecoration(
                    color: ColorsThemes.offGraycolor,
                    borderRadius: BorderRadius.circular(8)),
                child: TextFormField(
                  maxLines: 9,
                  textInputAction: TextInputAction.done,
                  controller: _disCon,
                  decoration: InputDecoration(
                      hintText: 'Enter message',
                      hintStyle: TextStyle(fontSize: 14),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.all(width / 30)),
                ),
              ),
            ),
            SizedBox(
              height: height / 30,
            ),
            InkWell(
              onTap: () {
                if (_subjectCon.text.isNotEmpty && _disCon.text.isNotEmpty) {
                  ApiUtils.adminContact(
                      subject: _subjectCon.text.toString(),
                      description: _disCon.text.toString());
                    showSuccessDailog(context);
                }
              },
              child: FlipInY(
                child: Container(
                  height: height / 20,
                  width: width / 3,
                  child: Center(
                    child: Text(
                      'Contact Us',
                      style: TextStyle(
                          color: Colors.white, fontSize: 12, letterSpacing: 1),
                    ),
                  ),
                  decoration: BoxDecoration(
                      color: ColorsThemes.mailColors,
                      borderRadius: BorderRadius.circular(10)),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  showSuccessDailog(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            child: SingleChildScrollView(
                child: FadeIn(
              child: Container(
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(20)),
                padding: EdgeInsets.all(width / 20),
                child: Column(
                  children: [
                    SizedBox(
                      height: height / 80,
                    ),
                    Text(
                      'Thank you very much for providing feedback. We take action to quickly resolve your issues. We will be in touch shortly with an update.',
                      style: TextStyle(
                        fontSize: 17,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: height / 30,
                    ),
                    Center(
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context).pop();
                          Navigator.of(context).pop();
                        },
                        child: Container(
                          height: height / 25,
                          width: width / 4,
                          child: Center(
                            child: Text(
                              'Ok',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          decoration: BoxDecoration(
                              color: ColorsThemes.mailColors,
                              borderRadius: BorderRadius.circular(10)),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            )),
          );
        });
  }
}

class GenaricTextField extends StatefulWidget {
  final TextEditingController controller;
  final int line;
  final double topwidth;
  final double botomwidth;
  final Widget prefixIcon;
  final String hint;
  final bool isnumber;

  GenaricTextField(
      {Key key,
      @required this.controller,
      @required this.line,
      @required this.topwidth,
      @required this.botomwidth,
      this.prefixIcon,
      this.hint,
      this.isnumber})
      : super(key: key);

  @override
  _GenaricTextFieldState createState() => _GenaricTextFieldState();
}

class _GenaricTextFieldState extends State<GenaricTextField> {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return TextFormField(
      controller: widget.controller,
      maxLines: widget.line,
      textInputAction: TextInputAction.done,
      keyboardType: widget.isnumber == true ? TextInputType.number : null,
      decoration: InputDecoration(
          hintText: widget.hint ?? '',
          hintStyle: TextStyle(fontSize: 10),
          border: InputBorder.none,
          focusColor: Colors.black26,
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black38),
              borderRadius: BorderRadius.circular(30)),
          contentPadding: EdgeInsets.only(
              left: width / 20,
              right: width / 20,
              top: widget.topwidth,
              bottom: widget.botomwidth),
          suffixIcon: widget.prefixIcon == null ? null : widget.prefixIcon,
          disabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black26),
              borderRadius: BorderRadius.circular(30)),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black26),
              borderRadius: BorderRadius.circular(30))),
      style: TextStyle(color: Colors.black, fontSize: 14),
    );
  }
}
