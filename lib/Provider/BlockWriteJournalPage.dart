import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class BlockWriteJpournalPage extends ChangeNotifier {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  GlobalKey<ScaffoldState> get scaffoldKey => _scaffoldKey;

  TextEditingController _nameCon = TextEditingController();
  TextEditingController get nameCon => _nameCon;
  TextEditingController _disCon = TextEditingController();
  TextEditingController get disCon => _disCon;

  bool _loading = false;
  bool get loading => _loading;
  setLoading(bool isload) {
    _loading = isload;
    notifyListeners();
  }

  var _finallist;
  get finalList => _finallist;
  setFinalList(var list) {
    _finallist = list;
  }

  List _listaudio = [];
  List get audiolist => _listaudio;
  setListofAudio(List list) {
    _listaudio = list;
  }

  removeAudio(int index) {
    _listaudio.removeAt(index);
    notifyListeners();
  }

  List _listnote = [];
  List get listnote => _listnote;
  setlistnote(List list) {
    _listnote = list;
  }

  removernotedata(int index) {
    _listnote.removeAt(index);
    notifyListeners();
  }

  List _listimages = [];
  List get listimages => _listimages;
  setlistimages({List list, String update}) {
    _listimages = list;
    if (update == 'update') {
      notifyListeners();
    }
  }

  removeListofImagesData(int index) {
    _listimages.removeAt(index);
    notifyListeners();
  }

  setforwardlistData() {
    setListofAudio(_finallist['audios']);
    setlistnote(_finallist['notes']);
    setlistimages(list: _finallist['images'], update: 'update');
    print('$_listnote');
  }

  String _current = 'note';
  String get current => _current;
  setCurrent(String c) {
    _current = c;
    notifyListeners();
  }

  String _floatingText = 'add note';
  String get floatingText => _floatingText;
  setfloatingText(String c) {
    _floatingText = c;
    notifyListeners();
  }

  PickedFile _imageFile;
  PickedFile get imageFile => _imageFile;
  setImageFile(PickedFile f) {
    _imageFile = f;
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

  pickAudio() async {
    FilePickerResult result =
        await FilePicker.platform.pickFiles(type: FileType.audio);

    if (result != null) {
      _file = File(result.files.single.path);
      notifyListeners();
    }
  }
}
