import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_picker/image_picker.dart';

class BlockDrawerPage extends ChangeNotifier {
  File _imageFile;
  File get imageFile => _imageFile;
  setImageFile(PickedFile f) async{
    final filePath = f.path;
    final lastIndex = filePath.lastIndexOf(new RegExp(r'.jp'));
    final splitted = filePath.substring(0, (lastIndex));
    final outPath = "${splitted}_out${filePath.substring(lastIndex)}";

    final compressedImage = await FlutterImageCompress.compressAndGetFile(
        filePath, outPath,
        minWidth: 600, minHeight: 1000, quality: 30);
    _imageFile = compressedImage;
    notifyListeners();
  }

  setDefaultImage(File file){
    _imageFile=file;
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

  File _file;
  File get file => _file;
  setAudiofile(File f) {
    _file = f;
    notifyListeners();
  }
}
