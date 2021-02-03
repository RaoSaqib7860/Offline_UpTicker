import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:path/path.dart';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_picker/image_picker.dart';

class BlockFeedBack extends ChangeNotifier {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  GlobalKey<ScaffoldState> get scaffoldKey => _scaffoldKey;

  TextEditingController _nameCon = TextEditingController();
  TextEditingController get nameCon => _nameCon;

  bool _istext = false;
  bool get istext=>_istext;
  setisText(bool v){
    _istext=v;
    notifyListeners();
  }

  bool _isfile = false;
  bool get isfile=>_isfile;
  setisFile(bool v){
    _isfile=v;
    notifyListeners();
  }

  File _imageFile;
  File get imageFile => _imageFile;

  setImageFile(PickedFile f) async {
    final filePath = f.path;
    final lastIndex = filePath.lastIndexOf(new RegExp(r'.jp'));
    final splitted = filePath.substring(0, (lastIndex));
    final outPath = "${splitted}_out${filePath.substring(lastIndex)}";

    final compressedImage = await FlutterImageCompress.compressAndGetFile(
        filePath, outPath,
        minWidth: 600, minHeight: 1000, quality: 30);
    _imageFile = compressedImage;
    setisFile(false);
    notifyListeners();
  }

  final ImagePicker _picker = ImagePicker();

  void onImageButtonPressed(ImageSource source, {BuildContext context}) async {
    try {
      final pickedFile = await _picker.getImage(
        source: source,
      );
      setImageFile(pickedFile);
    } catch (e) {}
  }

  void onVideoButtonPressed() async {
    try {
      FilePickerResult result = await FilePicker.platform.pickFiles();
      if(result!=null){
        setVideofile(result);
      }
    } catch (e) {}
  }

  File _videofile;
  File get videofile => _videofile;
  setVideofile(FilePickerResult f) {
    print('path is = ${f.files.single.path}');
    _videofile = File(f.files.single.path);
    notifyListeners();
  }
}
