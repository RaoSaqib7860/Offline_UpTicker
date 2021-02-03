import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:upticker/LocalWidget/LocalWidget.dart';
import 'package:upticker/Pages/AdditionalSubMentorTask.dart';
import 'package:upticker/Pages/FinalHomePage.dart';
import 'package:upticker/Pages/HomePage.dart';
import 'package:upticker/Pages/Login.dart';
import 'package:upticker/Pages/MantorSelectionPage.dart';
import 'package:upticker/Pages/OTPVarefication.dart';
import 'package:upticker/Pages/OnFocasAnimation.dart';
import 'package:upticker/Pages/ProfileUpdate.dart';
import 'package:upticker/Pages/PullCalanderPage.dart';
import 'package:upticker/Pages/SingleTaskEdition.dart';
import 'package:upticker/Provider/BlockAddAditionalMentorTask.dart';
import 'package:upticker/Provider/BlockAddCustomTask.dart';
import 'package:upticker/Provider/BlockCalenderList.dart';
import 'package:upticker/Provider/BlockCreateCustomTaskBucket.dart';
import 'package:upticker/Provider/BlockCreateSubCustomTaskBucket.dart';
import 'package:upticker/Provider/BlockCustomSubbucket.dart';
import 'package:upticker/Provider/BlockDrawerPage.dart';
import 'package:upticker/Provider/BlockExcercise1.dart';
import 'package:upticker/Provider/BlockExcercise2.dart';
import 'package:upticker/Provider/BlockFeedBack.dart';
import 'package:upticker/Provider/BlockFinalHomePage.dart';
import 'package:upticker/Provider/BlockForgetPassword.dart';
import 'package:upticker/Provider/BlockHomePage.dart';
import 'package:upticker/Provider/BlockHomeSubMentor.dart';
import 'package:upticker/Provider/BlockMantorSelection.dart';
import 'package:upticker/Provider/BlockPullCalender.dart';
import 'package:upticker/Provider/BlockSettings.dart';
import 'package:upticker/Provider/BlockSinglePageEdition.dart';
import 'package:upticker/Provider/BlockUserGenderSelection.dart';
import 'package:upticker/Provider/BlockWriteJournalPage.dart';
import 'package:upticker/Provider/GraphProvider.dart';
import 'package:upticker/Provider/LoginBlock.dart';
import 'package:upticker/Provider/ProviderGraphSubBucket.dart';
import 'package:upticker/Provider/SignUpProvider.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:upticker/ServicesForApp/FireBaseAnalytics.dart';
import 'package:upticker/SharedPreference/SharedPreference.dart';
import 'package:path/path.dart';

class ApiUtils {
  //static String apiURL = 'http://192.168.18.60:8000';
  //static String apiURL = 'http://212.46.130.138:8080';http://212.46.130.138:8080/
  static String apiURL = 'http://app.uptickerapp.com:8080';
  static final String baseURLForAccounts = '$apiURL/account/1';
  static final String baseURLForAppTask = '$apiURL/apptask/1';
  static String deviceID = '';
  static String accountKey =
      'Api-Key Sboh50nD.udOmy4lHGROQrTS0eRwG37HOeXIgu2wL';
  static String devicetype = 'android';
  static String firebasetoken = '';
  static String token = '';
  static String userImage = '';
  static String fistName = '';
  static String lastName = '';

  static String five_minute_sound = '';
  static String five_second_sound = '';
  static String complete_sound = '';
  static String notifications = '';
  static String pop_up = '';

  static final String signUp = '/register/';
  static final String login = '/login/';
  static final String otprequest = '/email-verify/';
  static final String resendOtp = '/resend-otp/';
  static final String createNewPasswordforemail = '/request-reset-password/';
  static final String createNewPassword = '/password-reset-complete/';
  static final String fbLoginRequest = '/facebook/';
  static final String gmailLoginRequest = '/google/';
  static final String task = '/default-tasks/';
  static final String sendSlectedTask = '/default-tasks/';
  static final String mantor = '/mentors/';
  static final String sendSelectedmantor = '/mentors/';
  static final String finalHomePage = '/dailytasks/';
  static final String subtask = '/subtask';
  static final String bucket = '/bucket/';
  static final String subbucket = '/subbucket';
  static final String note = '/note';
  static final String getuserGender = '/user/';
  static final String getGeneralDataurl = '/journal/';
  static final String postJournalNoteDataURL = '/note';
  static final String postJournalImageDataURL = '/image';
  static final String postJournalAudioDataURL = '/audio';
  static final String calendeRegister = '/calendar/';
  static final String getcalenderlist = '/calendar/';
  static final String submentorlist = '/mentors/';
  static final String graphData = '/stat/1/stats/';
  static final String graphDataBucket = '/stat/1/buckets/';
  static final String graphDataSubBucket = '/stat/1/task/';

  static Future getGraphDataSubBucket(
      {GraphSubBucketProvider provider,
      String date,
      String period,
      String id}) async {
    try {
      var responce = await Dio().get('$apiURL$graphDataSubBucket$id',
          queryParameters: {'end_date': '$date', 'period': '$period'},
          options: Options(
            headers: {
              'Authorization': 'Bearer $token',
              'Content-Type': 'application/json'
            },
          ));
      var data = responce.data;
      print('Graph data SubBucket in $period is == $data');
      print('Graph data is == ${responce.statusCode}');
      if (responce.statusCode == 200) {
        provider.setlistOfGraph(data['data']);
        provider.setloading(true);
      }
    } catch (e) {
      print('${e.toString()}');
    }
  }

  static Future getGraphDataBucket(
      {GraphProvider provider, String date, String period}) async {
    try {
      var responce = await Dio().get('$apiURL$graphDataBucket',
          queryParameters: {'end_date': '$date', 'period': '$period'},
          options: Options(
            headers: {
              'Authorization': 'Bearer $token',
              'Content-Type': 'application/json'
            },
          ));
      var data = responce.data;
      print('Graph data Bucket in $period is == $data');
      print('Graph data is == ${responce.statusCode}');
      if (responce.statusCode == 200) {
        provider.listOfBucket.clear();
        provider.setlistOfBucket(data['data']);
        provider.setloadingBucket(true);
      }
    } catch (e) {
      print('${e.toString()}');
    }
  }

  static Future getGraphData(
      {GraphProvider provider, String date, String period}) async {
    try {
      var responce = await Dio().get('$apiURL$graphData',
          queryParameters: {'end_date': '$date', 'period': '$period'},
          options: Options(
            headers: {
              'Authorization': 'Bearer $token',
              'Content-Type': 'application/json'
            },
          ));
      var data = responce.data;
      print('Graph data is == $data');
      print('Graph data is == ${responce.statusCode}');
      if (responce.statusCode == 200) {
        provider.listOfGraphline.clear();
        provider.setListOfGraph(data['data']);
        provider.setloading(true);
      }
    } catch (e) {
      print('${e.toString()}');
    }
  }

  static Future updatefinalTaskData({BlockFinalHomePage provider}) async {
    try {
      var responce = await http.post(
        '$baseURLForAppTask$finalHomePage',
        body: json.encode(provider.updatedList),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json'
        },
      );
      var data = jsonDecode(responce.body);
      print('update task data is== $data');
      print('update task status is== ${responce.statusCode}');
      if (responce.statusCode == 200) {
        print('Task Added succesfully');
      }
    } catch (e) {
      print('${e.toString()}');
    }
  }

  static Future addcustomTaskData(
      {BlockAddCustomTask provider, String event}) async {
    try {
      var responce = await http.post(
        '$baseURLForAppTask/dailytasks/add',
        body: {
          "name": "${provider.tasname.text}",
          "start_time": "${provider.startTime}",
          "end_time": "${provider.endTime}",
          "point": '${provider.point}',
          "focus": '${provider.focus}',
          "bad_habbit": '${provider.badHabit}',
          "sub_bucket": '${provider.selectedSubid}',
          "_5_mins_before": '${provider.fiveminBefore}',
          "_5_sec_before": '${provider.fiveSecBefore}',
          "description": "${provider.discription.text}",
          "color": "${provider.colorString}",
          "completed": 'false',
          "completion_time": "${provider.endTime}",
          'recurring': event == '1' ? 'false' : 'true',
          'pin_task': provider.pintask == true ? 'true' : 'false'
        },
        headers: {'Authorization': 'Bearer $token'},
      );

      var data = jsonDecode(responce.body);
      print('add task data is== $data');
      print('add task data is== ${responce.statusCode}');
      if (responce.statusCode == 200) {
        Future.delayed(Duration(milliseconds: 500), () {
          Navigator.pushAndRemoveUntil(
            provider.scaffoldKey.currentContext,
            PageTransition(
                duration: Duration(milliseconds: 200),
                type: PageTransitionType.rightToLeft,
                child: ChangeNotifierProvider(
                  create: (_) => BlockFinalHomePage(),
                  child: FinalHomePageClass(),
                )),
            ModalRoute.withName('/'),
          );
        });
      }
    } catch (e) {
      print('error is = ${e.toString()}');
    }
  }

  static Future updatedailytask(
      {BlockAddCustomTask provider, String event}) async {
    try {
      var responce = await http.post(
        '$baseURLForAppTask/dailytasks/add',
        body: {},
        headers: {'Authorization': 'Bearer $token'},
      );

      var data = jsonDecode(responce.body);
      print('add task data is== $data');
      print('add task data is== ${responce.statusCode}');
      if (responce.statusCode == 200) {
        Future.delayed(Duration(milliseconds: 500), () {
          Navigator.pushAndRemoveUntil(
            provider.scaffoldKey.currentContext,
            PageTransition(
                duration: Duration(milliseconds: 200),
                type: PageTransitionType.rightToLeft,
                child: ChangeNotifierProvider(
                  create: (_) => BlockFinalHomePage(),
                  child: FinalHomePageClass(),
                )),
            ModalRoute.withName('/'),
          );
        });
      }
    } catch (e) {
      print('${e.toString()}');
    }
  }

  static Future postFeedBack({BlockFeedBack provider}) async {
    FormData formData;
    if (provider.imageFile != null) {
      print('is image');
      formData = FormData.fromMap({
        "attachment": await MultipartFile.fromFile(provider.imageFile.path,
            filename: basename(provider.imageFile.path)),
        "description": "${provider.nameCon.text}",
      });
    } else if (provider.videofile != null) {
      print('');
      formData = FormData.fromMap({
        "attachment": await MultipartFile.fromFile(provider.videofile.path,
            filename: basename(provider.videofile.path)),
        "description": "${provider.nameCon.text}",
      });
    } else {
      print('is nothing');
      formData = FormData.fromMap({
        "description": "${provider.nameCon.text}",
      });
    }
    try {
      var responce = await Dio().post('$apiURL/account/1/report/',
          data: formData,
          options: Options(
            headers: {'Authorization': 'Bearer $token'},
          ));
      var data = responce.data;
      print('journal data is== $data');
      print('jounal data is== ${responce.statusCode}');
      if (responce.statusCode == 201) {
        provider.nameCon.clear();

        Future.delayed(Duration(seconds: 2), () {
          Navigator.pushAndRemoveUntil(
            provider.scaffoldKey.currentContext,
            PageTransition(
                duration: Duration(milliseconds: 500),
                type: PageTransitionType.rightToLeft,
                child: ChangeNotifierProvider(
                  create: (_) => BlockFinalHomePage(),
                  child: FinalHomePageClass(taskisComplete: true),
                )),
            ModalRoute.withName('/'),
          );
        });
      }
    } catch (e) {
      print('${e.toString()}');
    }
  }

  static Future updateProfileImage({BlockDrawerPage provider}) async {
    FormData formData = FormData.fromMap({
      "profile_picture": await MultipartFile.fromFile(provider.imageFile.path,
          filename: basename(provider.imageFile.path)),
    });
    try {
      var responce = await Dio().put(
        '$apiURL/account/1/user/',
        data: formData,
        options: Options(
            headers: {'Authorization': 'Bearer $token'},
            followRedirects: false,
            validateStatus: (status) {
              return status <= 500;
            }),
      );
      var data = responce.data;
      print('journal data is== $data');
      print('jounal data is== ${responce.statusCode}');
      ApiUtils.userImage = '${data['profile_picture']}';
      SharedPreferenceClass.addImageUrl('${data['profile_picture']}');
      if (responce.statusCode == 200) {
        File imageFile;
        provider.setDefaultImage(imageFile);
      }
    } catch (e) {
      print('${e.toString()}');
    }
  }

  static Future deleteJournalAudioData(
      {BlockWriteJpournalPage provider, int id, int index}) async {
    try {
      var responce = await Dio().delete(
        '$apiURL/apptask/1/journal/audio/$id',
        options: Options(
            headers: {'Authorization': 'Bearer $token'},
            followRedirects: false,
            validateStatus: (status) {
              return status <= 500;
            }),
      );
      var data = responce.data;
      print('journal data is== $data');
      print('jounal data is== ${responce.statusCode}');
      if (responce.statusCode == 204) {
        provider.removeAudio(index);
      }
    } catch (e) {
      print('${e.toString()}');
    }
  }

  static Future postJournalAudioData(
      {BlockWriteJpournalPage provider, int id, String date}) async {
    FormData formData = FormData.fromMap({
      "audio": await MultipartFile.fromFile(provider.file.path,
          filename: basename(provider.file.path)),
    });
    try {
      var responce = await Dio().post(
        '$apiURL/apptask/1/journal/$id/audio',
        data: formData,
        options: Options(
            headers: {'Authorization': 'Bearer $token'},
            followRedirects: false,
            validateStatus: (status) {
              return status <= 500;
            }),
      );
      var data = responce.data;
      print('journal data is== $data');
      print('jounal data is== ${responce.statusCode}');
      if (responce.statusCode == 201) {
        File file;
        provider.setAudiofile(file);
        getJouralData(date: date, provider: provider);
      }
    } catch (e) {
      print('${e.toString()}');
    }
  }

  static Future deleteJournalImageData(
      {BlockWriteJpournalPage provider, int id, int index}) async {
    try {
      var responce = await Dio().delete(
        '$apiURL/apptask/1/journal/$id$postJournalImageDataURL',
        options: Options(
            headers: {'Authorization': 'Bearer $token'},
            followRedirects: false,
            validateStatus: (status) {
              return status <= 500;
            }),
      );
      var data = responce.data;
      print('journal data is== $data');
      print('jounal data is== ${responce.statusCode}');
      if (responce.statusCode == 204) {
        provider.removeListofImagesData(index);
      }
    } catch (e) {
      print('${e.toString()}');
    }
  }

  static Future postJournalImageData(
      {BlockWriteJpournalPage provider, int id, String date}) async {
    FormData formData = FormData.fromMap({
      "image": await MultipartFile.fromFile(provider.imageFile.path,
          filename: basename(provider.imageFile.path)),
    });
    try {
      var responce = await Dio().post(
        '$apiURL/apptask/1/journal/$id$postJournalImageDataURL',
        data: formData,
        options: Options(
            headers: {'Authorization': 'Bearer $token'},
            followRedirects: false,
            validateStatus: (status) {
              return status <= 500;
            }),
      );
      var data = responce.data;
      print('journal data is== $data');
      print('jounal data is== ${responce.statusCode}');
      if (responce.statusCode == 201) {
        PickedFile imageFile;
        provider.setImageFile(imageFile);
        getJouralData(date: date, provider: provider);
      }
    } catch (e) {
      print('${e.toString()}');
    }
  }

  static Future updateJournalNoteData(
      {BlockWriteJpournalPage provider, int id}) async {
    try {
      var responce = await Dio().put(
        '$apiURL/apptask/1/journal/$id$postJournalNoteDataURL',
        data: {
          'name': '${provider.nameCon.text}',
          'description': '${provider.disCon.text}'
        },
        options: Options(
            headers: {'Authorization': 'Bearer $token'},
            followRedirects: false,
            validateStatus: (status) {
              return status <= 500;
            }),
      );
      var data = responce.data;
      print('journal data is== $data');
      print('jounal data is== ${responce.statusCode}');
      if (responce.statusCode == 200) {
        provider.setFinalList(data);
        provider.setforwardlistData();
        provider.setLoading(true);
      }
    } catch (e) {
      print('${e.toString()}');
    }
  }

  static Future deleteJournalNoteData(
      {BlockWriteJpournalPage provider, int id, int index}) async {
    try {
      var responce = await Dio().delete(
        '$apiURL/apptask/1/journal/$id$postJournalNoteDataURL',
        options: Options(
            headers: {'Authorization': 'Bearer $token'},
            followRedirects: false,
            validateStatus: (status) {
              return status <= 500;
            }),
      );
      var data = responce.data;
      print('journal data is== $data');
      print('jounal data is== ${responce.statusCode}');
      if (responce.statusCode == 204) {
        provider.removernotedata(index);
      }
    } catch (e) {
      print('${e.toString()}');
    }
  }

  static Future postJournalNoteData(
      {BlockWriteJpournalPage provider, int id}) async {
    try {
      var responce = await Dio().post(
        '$apiURL/apptask/1/journal/$id$postJournalNoteDataURL',
        data: {
          'name': '${provider.nameCon.text}',
          'description': '${provider.disCon.text}'
        },
        options: Options(
            headers: {'Authorization': 'Bearer $token'},
            followRedirects: false,
            validateStatus: (status) {
              return status <= 500;
            }),
      );
      var data = responce.data;
      print('journal data is== $data');
      print('jounal data is== ${responce.statusCode}');
      if (responce.statusCode == 200) {
        provider.setFinalList(data);
        provider.setforwardlistData();
        provider.setLoading(true);
      }
    } catch (e) {
      print('${e.toString()}');
    }
  }

  static Future getJouralData(
      {String date, BlockWriteJpournalPage provider}) async {
    try {
      var responce = await Dio().get('$apiURL/apptask/1/journal/',
          options: Options(
              headers: {'Authorization': 'Bearer $token'},
              followRedirects: false,
              validateStatus: (status) {
                return status <= 500;
              }),
          queryParameters: {'date': '$date'});
      var data = responce.data;
      print('journal data is== $data');
      print('jounal data is== ${responce.statusCode}');
      if (responce.statusCode == 200) {
        provider.setFinalList(data);
        provider.setforwardlistData();
        provider.setLoading(true);
      }
    } catch (e) {
      print('${e.toString()}');
    }
  }

  static Future gettaskCompleted(
      {id, BlockFinalHomePage provider, int index}) async {
    print('id is = $id');

    try {
      var responce = await Dio().put('$baseURLForAppTask$finalHomePage$id/',
          data: {'completed': 'true'},
          options: Options(
              headers: {'Authorization': 'Bearer $token'},
              followRedirects: false,
              validateStatus: (status) {
                return status <= 500;
              }));
      var data = responce.data;
      print('Excersice focus data is== $data');
      print('Excersice focus data is== ${responce.statusCode}');
      if (responce.statusCode == 201) {
        print('Task Completed ..');
      }
    } catch (e) {
      print('${e.toString()}');
    }
  }

  static Future gettaskCompletedUndo({id, BlockFinalHomePage provider}) async {
    print('id is = $id');

    try {
      var responce = await Dio().put('$baseURLForAppTask$finalHomePage$id/',
          data: {'completed': 'false'},
          options: Options(
              headers: {'Authorization': 'Bearer $token'},
              followRedirects: false,
              validateStatus: (status) {
                return status <= 500;
              }));
      var data = responce.data;
      print('Excersice focus data is== $data');
      print('Excersice focus data is== ${responce.statusCode}');
      if (responce.statusCode == 201) {
        print('Undo successflully');
      } else {
        print('Undo failed');
      }
    } catch (e) {
      print('${e.toString()}');
    }
  }

  static Future updateFocusExcersice2Data(
      {BuildContext context, BlockExcercise2 provider}) async {
    print('id is = ${provider.id}');

    try {
      var responce =
          await Dio().put('$baseURLForAppTask$finalHomePage${provider.id}/',
              data: {'completed': 'true'},
              options: Options(
                  headers: {'Authorization': 'Bearer $token'},
                  followRedirects: false,
                  validateStatus: (status) {
                    return status <= 500;
                  }));
      var data = responce.data;
      print('Excersice focus data is== $data');
      print('Excersice focus data is== ${responce.statusCode}');
      if (responce.statusCode == 201) {
        Future.delayed(Duration(seconds: 2), () {
          Navigator.pushAndRemoveUntil(
              context,
              PageTransition(
                  duration: Duration(milliseconds: 500),
                  type: PageTransitionType.rightToLeft,
                  child: ChangeNotifierProvider(
                    create: (_) => BlockFinalHomePage(),
                    child: FinalHomePageClass(taskisComplete: true),
                  )),
              ModalRoute.withName('/'));
        });
      } else {}
    } catch (e) {
      print('${e.toString()}');
    }
  }

  static Future updateFocusExcersice1Data(
      {BuildContext context, BlockExcercise1 provider}) async {
    print('${provider.id}');

    try {
      var responce = await http
          .put('$baseURLForAppTask$finalHomePage${provider.id}/', headers: {
        'Authorization': 'Bearer $token'
      }, body: {
        'focus': 'true',
      });
      var data = jsonDecode(responce.body);
      print('Excersice focus data is== $data');
      print('Excersice focus data is== ${responce.statusCode}');
      if (responce.statusCode == 201) {
        Future.delayed(Duration(seconds: 2), () {
          Navigator.push(
              context,
              PageTransition(
                  duration: Duration(milliseconds: 500),
                  type: PageTransitionType.rightToLeft,
                  child: ChangeNotifierProvider(
                    create: (_) => BlockFinalHomePage(),
                    child: FinalHomePageClass(),
                  )));
        });
      }
    } catch (e) {
      print('${e.toString()}');
    }
  }

  static Future getuserGenderPageData({BlockMantorSelection provider}) async {
    try {
      var responce = await http.get(
        '$baseURLForAccounts$getuserGender',
        headers: {'Authorization': 'Bearer $token'},
      );
      var data = jsonDecode(responce.body);
      print('user Gender data is == $data');
      if (responce.statusCode == 200) {
        provider.setUserProfile(data['is_profile_updated']);
      }
    } catch (e) {
      print('${e.toString()}');
    }
  }

  static Future initialchekingPageData(BuildContext context) async {
    try {
      var responce = await http.get(
        '$baseURLForAccounts$getuserGender',
        headers: {'Authorization': 'Bearer $token'},
      );
      var data = jsonDecode(responce.body);
      print('user Gender data is == $data');
      SharedPreferenceClass.addImageUrl('${data['profile_picture']}');
      SharedPreferenceClass.addUserName(
          '${data['first_name']} ${data['last_name']}');
      SharedPreferenceClass.addfive_minute_sound(
          '${data['five_minute_sound']}');
      SharedPreferenceClass.addfive_second_sound(
          '${data['five_second_sound']}');
      SharedPreferenceClass.addcomplete_sound('${data['complete_sound']}');
      SharedPreferenceClass.addnotifications('${data['notifications']}');
      SharedPreferenceClass.addpop_up('${data['pop_up']}');

      ApiUtils.userImage = '${data['profile_picture']}';
      ApiUtils.fistName = '${data['first_name']}';
      ApiUtils.lastName = '${data['last_name']}';
      ApiUtils.five_minute_sound = '${data['five_minute_sound']}';
      ApiUtils.five_second_sound = '${data['five_second_sound']}';
      ApiUtils.complete_sound = '${data['complete_sound']}';
      ApiUtils.notifications = '${data['notifications']}';
      ApiUtils.pop_up = '${data['pop_up']}';

      if (responce.statusCode == 200) {
        if (data['is_profile_updated'] == false) {
          Navigator.push(
              context,
              PageTransition(
                  duration: Duration(milliseconds: 500),
                  type: PageTransitionType.rightToLeft,
                  child: ChangeNotifierProvider(
                    create: (_) => BlockHomePage(),
                    child: HomePage(),
                  )));
        } else {
          Navigator.pushAndRemoveUntil(
              context,
              PageTransition(
                  duration: Duration(milliseconds: 500),
                  type: PageTransitionType.rightToLeft,
                  child: ChangeNotifierProvider(
                    create: (_) => BlockFinalHomePage(),
                    child: FinalHomePageClass(),
                  )),
              ModalRoute.withName('/'));
        }
        FireBaseAnalyticsServices.addUserId(
            '${data['first_name']} ${data['last_name']}');
      }
    } catch (e) {
      print('${e.toString()}');
    }
  }

  static Future putuserGenderPageData(
      {BuildContext context, BlockUserGenderSelection provider}) async {
    print('Data is = ${provider.uploaddate}');
    DateTime dt = DateTime.now();
    try {
      var responce = await http.put(
        '$baseURLForAccounts$getuserGender',
        body: {
          "gender": provider.gender,
          "date_of_birth": provider.uploaddate,
          "time_offset": '${dt.timeZoneOffset}',
        },
        headers: {'Authorization': 'Bearer $token'},
      );
      var data = jsonDecode(responce.body);
      print('Pull Calender Data is == $data');
      print('${responce.statusCode}');
      provider.setapiCall(false);
      if (responce.statusCode == 200) {
        Navigator.push(
            context,
            PageTransition(
                duration: Duration(milliseconds: 500),
                type: PageTransitionType.rightToLeft,
                child: ChangeNotifierProvider(
                    create: (BuildContext context) => PullCalenderBlock(),
                    child: PullCalenderPage())));
      }
    } catch (e) {
      print('${e.toString()}');
    }
  }

  static Future timeOffset({String timezone}) async {
    try {
      var responce = await http.put(
        '$baseURLForAccounts$getuserGender',
        body: {
          "time_offset": '$timezone',
        },
        headers: {'Authorization': 'Bearer $token'},
      );
      var data = jsonDecode(responce.body);
      print('Data is = $data');
    } catch (e) {
      print('${e.toString()}');
    }
  }

  static Future notegetSubTaskData(
      {BuildContext context, BlockSettings provider}) async {
    print('id ${provider.id}');
    try {
      var responce = await http.get(
          '$baseURLForAppTask$finalHomePage${provider.id}/note',
          headers: {'Authorization': 'Bearer $token'});
      List data = jsonDecode(responce.body);
      print('get note Data = $data');
      print('get note Data = ${responce.statusCode}');
      if (responce.statusCode == 200) {
        provider.notsetServerSubList(data);
        for (var i = 0; i < data.length; i++) {
          TextEditingController controller = TextEditingController();
          controller.text = data[i]['name'];
          provider.notsetConList(controller);
        }
      }
    } catch (e) {
      print('${e.toString()}');
    }
  }

  static Future notaddSubTaskData(
      {BuildContext context, BlockSettings provider}) async {
    print('note task List is == ${provider.notserverUploadedSubList}');
    print('note task List is == ${provider.id}');
    try {
      var response = await Dio()
          .post('$baseURLForAppTask$finalHomePage${provider.id}$note',
              data: {"data": provider.notserverUploadedSubList},
              options: Options(
                  headers: {'Authorization': 'Bearer $token'},
                  followRedirects: false,
                  validateStatus: (status) {
                    return status <= 500;
                  }));
      print(' responce note data is ${response.data}');
      print(' responce note data is ${response.statusCode}');
      print(' responce note data is ${response.statusMessage}');
      if (response.statusCode == 201) {
        print('Sub Note Add Succesfully ');
      }
    } catch (e) {
      print('${e.toString()}');
    }
  }

  static Future notdeleteSubTaskData(
      {BuildContext context, BlockSettings provider, int id, int index}) async {
    print('id ${provider.id}');
    try {
      var responce = await http.delete(
          '$baseURLForAppTask$finalHomePage$id$note',
          headers: {'Authorization': 'Bearer $token'});
      print('${responce.statusCode}');
      if (responce.statusCode == 204) {
        provider.notdeleteselectedSubTask(index);
      }
    } catch (e) {
      print('${e.toString()}');
    }
  }

  static Future getSubCustomBucketTaskData(
      {BlockCreateSubCustomBucketTask provider, var id}) async {
    try {
      var responce = await http.get(
        '$baseURLForAppTask$bucket$id$subbucket',
        headers: {'Authorization': 'Bearer $token'},
      );
      var data = jsonDecode(responce.body);
      print('Custom sub data is== $data');
      if (responce.statusCode == 200) {
        provider.setCustomSubBucketData(data);
        provider.setLoading();
      }
    } catch (e) {
      print('${e.toString()}');
    }
  }

  static Future getSubtoSubCustomBucketTaskData(
      {BlockCustomSubbucket provider, var id}) async {
    print('id = $id');
    try {
      var responce = await http.get(
        '$baseURLForAppTask/subbucket/$id',
        headers: {'Authorization': 'Bearer $token'},
      );
      var data = jsonDecode(responce.body);
      print('Custom sub data is== $data');
      if (responce.statusCode == 200) {
        provider.setCustomSubBucketData(data);
        provider.setLoading();
      }
    } catch (e) {
      print('${e.toString()}');
    }
  }

  static Future getSubAdditionalBucketData(
      {BlockAditionalMentorTask provider, var id}) async {
    print('id = $id');
    try {
      var responce = await http.get(
        '$baseURLForAppTask$mantor',
        headers: {'Authorization': 'Bearer $token'},
      );
      var data = jsonDecode(responce.body);
      print('Custom sub data is== $data');
      print('Custom sub data is== ${responce.statusCode}');
      if (responce.statusCode == 200) {
        provider.setCustomSubBucketData(data);
        provider.setLoading();
      }
    } catch (e) {
      print('${e.toString()}');
    }
  }

  static Future getCustomBucketTaskData(
      {BlockCreateCustomTaskBucket provider}) async {
    try {
      var responce = await http.get(
        '$baseURLForAppTask$bucket',
        headers: {'Authorization': 'Bearer $token'},
      );
      var data = jsonDecode(responce.body);
      print('Custom Bucket data is== $data');
      if (responce.statusCode == 200) {
        provider.setCustomBucketData(data);
        provider.setLoading();
      }
    } catch (e) {
      print('${e.toString()}');
    }
  }

  static Future deleteSubTaskAllData(
      {BuildContext context, BlockSettings provider}) async {
    try {
      var responce = await http
          .put('$baseURLForAppTask$finalHomePage${provider.id}/', headers: {
        'Authorization': 'Bearer $token'
      }, body: {
        'name': '${provider.addTaskList}',
      });
      var data = jsonDecode(responce.body);
      print('add Subtask  data is== $data');
    } catch (e) {
      print('${e.toString()}');
    }
  }

  static Future deletefinalHomePagetask(
      {BuildContext context,
      BlockFinalHomePage provider,
      int id,
      int index,
      String event}) async {
    try {
      var responce = await http.post(
        '$baseURLForAppTask$finalHomePage$id/',
        body: {'recurring': event == '1' ? 'false' : 'true'},
        headers: {'Authorization': 'Bearer $token'},
      );
      print('${responce.statusCode}');
      if (responce.statusCode == 204) {
        var value = provider.finalList[index]['point'];
        print('point  is = $value');
        provider.removeFinalListIndex(index);
        provider.settask(true);
        Future.delayed(Duration(seconds: 1), () {
          provider.settask(false);
        });
        provider.minimizefocustotalPoint(value);
        provider.settaskPercentage();
        provider.settextPercentage();
        if (provider.finalList.length < 1) {
          provider.setisCompletedAll(true);
        }
      }
    } catch (e) {
      print('${e.toString()}');
    }
  }

  static Future deleteSubTaskData(
      {BuildContext context, BlockSettings provider, int id, int index}) async {
    print('id ${provider.id}');
    try {
      var responce = await http.delete(
          '$baseURLForAppTask$finalHomePage$id$subtask',
          headers: {'Authorization': 'Bearer $token'});
      print('${responce.statusCode}');
      if (responce.statusCode == 204) {
        provider.deleteselectedSubTask(index);
      }
    } catch (e) {
      print('${e.toString()}');
    }
  }

  static Future getSubTaskData(
      {BuildContext context, BlockSettings provider}) async {
    print('id ${provider.id}');
    try {
      var responce = await http.get(
          '$baseURLForAppTask$finalHomePage${provider.id}$subtask',
          headers: {'Authorization': 'Bearer $token'});
      List data = jsonDecode(responce.body);
      print('sub Task Data = $data');
      if (responce.statusCode == 200) {
        provider.setServerSubList(data);
        for (var i = 0; i < data.length; i++) {
          TextEditingController controller = TextEditingController();
          controller.text = data[i]['name'];
          provider.setConList(controller);
        }
      }
    } catch (e) {
      print('${e.toString()}');
    }
  }

  static Future addSubTaskData(
      {BuildContext context, BlockSettings provider}) async {
    print('sub task List is == ${provider.serverUploadedSubList}');
    print('sub task List is == ${provider.id}');
    try {
      var response = await Dio()
          .post('$baseURLForAppTask$finalHomePage${provider.id}$subtask',
              data: {"data": provider.serverUploadedSubList},
              options: Options(
                  headers: {'Authorization': 'Bearer $token'},
                  followRedirects: false,
                  validateStatus: (status) {
                    return status <= 500;
                  }));
      print(' responce data is ${response.data}');
      print(' responce data is ${response.statusCode}');
      print(' responce data is ${response.statusMessage}');
      if (response.statusCode == 201) {
        print('Sub Task Add Succesfully ');
      }
    } catch (e) {
      print('${e.toString()}');
    }
  }

  static Future missedFinalIDData(
      {BlockFinalHomePage provider, int index, id}) async {
    print('id is = $id');

    try {
      var responce = await http.put('$baseURLForAppTask$finalHomePage$id/',
          headers: {'Authorization': 'Bearer $token'},
          body: {'missed': 'true', 'completed': 'true'});
      var data = jsonDecode(responce.body);
      print('Settings data is== $data');
      if (responce.statusCode == 201) {
        provider.removeFinalListIndex(index);
        provider.settask(true);
        Future.delayed(Duration(seconds: 1), () {
          provider.settask(false);
        });
        if (provider.finalList.length < 1) {
          provider.setisCompletedAll(true);
        }
      } else {}
    } catch (e) {
      print('${e.toString()}');
    }
  }

  static Future updateEditRecordSettingData(
      {BuildContext context,
      BlockSettings provider,
      String event,
      bool isEditSingle}) async {
    print('start time = ${provider.startTime}');
    print('end time = ${provider.endTime}');

    try {
      var responce = await http
          .put('$baseURLForAppTask$finalHomePage${provider.id}/', headers: {
        'Authorization': 'Bearer $token'
      }, body: {
        'name': provider.nameCon.text.isEmpty
            ? '${provider.name}'
            : provider.nameCon.text.trimRight(),
        'start_time': '${provider.startTime}',
        'end_time': '${provider.endTime}',
        'point': '${provider.point}',
        'focus': '${provider.focus}',
        'bad_habbit': '${provider.badHabit}',
        'animation': '${provider.animation}',
        'audio': '${provider.audio}',
        '_5_mins_before': '${provider.fiveminBefore}',
        '_5_sec_before': '${provider.fiveSecBefore}',
        'description': '${provider.setDiscription}',
        'color': '${provider.colorString}',
        'recurring': event == '1' ? 'false' : 'true',
        'pin_task': provider.pintask == true ? 'true' : 'false'
      });
      if (responce.statusCode == 201) {
        if (isEditSingle == true) {
          Navigator.of(provider.scaffoldKey.currentContext).pop();
          Navigator.of(provider.scaffoldKey.currentContext).pop();
          Navigator.push(
              provider.scaffoldKey.currentContext,
              MaterialPageRoute(
                  builder: (c) => ChangeNotifierProvider(
                      create: (_) => BlockSinglePageEdition(),
                      child: SingleTaskEdition())));
        } else {
          Navigator.pushAndRemoveUntil(
            provider.scaffoldKey.currentContext,
            PageTransition(
                duration: Duration(milliseconds: 50),
                type: PageTransitionType.rightToLeft,
                child: ChangeNotifierProvider(
                  create: (_) => BlockFinalHomePage(),
                  child: FinalHomePageClass(),
                )),
            ModalRoute.withName('/'),
          );
        }
      }
    } catch (e) {
      print('${e.toString()}');
    }
  }

  static Future getEditRecordSettingData(
      {BuildContext context, BlockSettings provider}) async {
    print('${provider.id}');
    print('${provider.token}');
    try {
      var responce = await http.get(
        '$baseURLForAppTask$finalHomePage${provider.id}/',
        headers: {'Authorization': 'Bearer $token'},
      );
      var data = jsonDecode(responce.body);
      print('Settings data is== $data');
      if (responce.statusCode == 200) {
        provider.seteditData(data);
        provider.setAllEditData();
        provider.setLoading();
      }
    } catch (e) {
      print('${e.toString()}');
    }
  }

  static Future getfinalHomePageDataUpdated(
      {BuildContext context, BlockFinalHomePage provider}) async {
    try {
      var response = await Dio().get('$baseURLForAppTask$finalHomePage',
          queryParameters: {'date': '${FinalHomePageClass.newdate}'},
          options: Options(
              headers: {
                'Authorization': 'Bearer $token',
              },
              followRedirects: false,
              validateStatus: (status) {
                return status <= 500;
              }));
      print('responce is =${response.data}');
      List data = response.data;
      if (data.length > 0) {
        if (data[0]['order'] < data[1]['order']) {
          print('Sorted');
        } else {
          print('UnSorted');
          for (var i = 0; i < data.length; i++) {
            data[i]['order'] = i;
          }
        }
      }

      if (response.statusCode == 200) {
        data.sort((a, b) => a['order'].compareTo(b['order']));
        provider.setminimizetotalUnCompletedTask();
        provider.setFinalList(data);
        provider.iniFocausCompletePoint();
        provider.iniFocuseTotalPoit();
        for (var i = 0; i < data.length; i++) {
          provider.setfocustotalPoint(data[i]['point']);
          if (data[i]['completed'] == true) {
            provider.setfocusCompletePoint(data[i]['point']);
          } else {
            provider.settotalUnCompletedTask(data[i]['point']);
          }
        }
        provider.settaskPercentage();
        provider.settextPercentage();
        provider.setLoading(true);
        await Future.delayed(Duration(milliseconds: 500), () {
          if (provider.totalUnCompletedTask < 1) {
            provider.setisCompletedAll(true);
          }
        });
        List check = [];
        await Future.delayed(Duration(milliseconds: 300), () {
          provider.finalList.forEach((element) {
            if (element['completed'] == false || element['missed'] == false) {
              check.add(element);
            }
          });
        });
        await Future.delayed(Duration(milliseconds: 300), () {
          if (check.length < 1) {
            provider.setisCompletedAll(true);
          }
        });
        print('total unComplete task = $check');
      }
    } catch (e) {
      print('exception is = ${e.toString()}');
    }
  }

  static Future getSingleEditionTask({BlockSinglePageEdition provider}) async {
    try {
      var response = await Dio().get('$baseURLForAppTask$finalHomePage',
          options: Options(
              headers: {
                'Authorization': 'Bearer $token',
              },
              followRedirects: false,
              validateStatus: (status) {
                return status <= 500;
              }));
      List data = response.data;
      data.sort((a, b) {
        return a['name'].toLowerCase().compareTo(b['name'].toLowerCase());
      });
      print('Single task page data is== $data');
      provider.setListOfTask(data);
      provider.setLoading(true);
    } catch (e) {
      print('${e.toString()}');
    }
  }

  static Future getfinalHomePageData(
      {BuildContext context, BlockFinalHomePage provider}) async {
    print('toooooooooookrn==$token');
    try {
      var responce = await http.get(
        '$baseURLForAppTask$finalHomePage',
        headers: {'Authorization': 'Bearer $token'},
      );
      List data = jsonDecode(responce.body);
      print('final home page data is== $data');
      if (responce.statusCode == 200) {
        if (data.length == 0 || data == [] || data == null) {
          SharedPreferenceClass.removeValues();
          Navigator.push(
              context,
              PageTransition(
                  duration: Duration(milliseconds: 500),
                  type: PageTransitionType.rightToLeft,
                  child: ChangeNotifierProvider(
                    create: (_) => BlockHomePage(),
                    child: HomePage(),
                  )));
        } else {
          print('responce is =${jsonDecode(responce.body)}');
          if (data.length > 0) {
            if (data[0]['order'] < data[1]['order']) {
              print('Sorted');
            } else {
              print('UnSorted');
              for (var i = 0; i < data.length; i++) {
                data[i]['order'] = i;
              }
            }
          }
          data.sort((a, b) => a['order'].compareTo(b['order']));
          provider.setminimizetotalUnCompletedTask();
          provider.setFinalList(data);
          provider.iniFocausCompletePoint();
          provider.iniFocuseTotalPoit();
          // provider.listofStartTime.clear();
          // provider.listofendTime.clear();
          for (var i = 0; i < data.length; i++) {
            provider.setfocustotalPoint(data[i]['point']);
            // provider.setListOfStartTime(data[i]['start_time']);
            // provider.setlistofendTime(data[i]['end_time']);
            if (data[i]['completed'] == true) {
              provider.setfocusCompletePoint(data[i]['point']);
            } else {
              provider.settotalUnCompletedTask(data[i]['point']);
            }
          }
          provider.settaskPercentage();
          provider.settextPercentage();
          provider.setLoading(true);

          List check = [];
          await Future.delayed(Duration(milliseconds: 300), () {
            provider.finalList.forEach((element) {
              if (element['completed'] == false || element['missed'] == false) {
                check.add(element);
              }
            });
          });
          await Future.delayed(Duration(milliseconds: 300), () {
            if (check.length < 1) {
              provider.setisCompletedAll(true);
            }
          });
          // DBProvider.instance.database;
          // for (var i = 0; i < data.length; i++) {
          //   DBProvider.instance.insertfinalHomePageData(FinalHomePageDataModel(
          //       id: data[i]['id'],
          //       name: data[i]['name'],
          //       start_time: (data[i]['start_time']).toString(),
          //       end_time: (data[i]['end_time']).toString(),
          //       point: (data[i]['point']).toString(),
          //       focus: (data[i]['focus']).toString(),
          //       bad_habbit: (data[i]['bad_habbit']).toString(),
          //       animation: (data[i]['animation']).toString(),
          //       audio: (data[i]['audio']).toString(),
          //       f_5_mins_before: (data[i]['_5_mins_before']).toString(),
          //       f_5_sec_before: (data[i]['_5_sec_before']).toString(),
          //       description: (data[i]['description']).toString(),
          //       color: (data[i]['color']).toString(),
          //       // date: (provider.date).toString(),
          //       // delete: 'false',
          //       // update: 'false'
          //       ));
          // }
        }
      }
    } catch (e) {
      print('${e.toString()}');
    }
  }

  static Future getSignUpCalling(
      {String firstname,
      String lastname,
      String email,
      String password,
      GlobalKey<ScaffoldState> scaffoldkey,
      BuildContext context,
      BlockSignUp provider}) async {
    print('$firstname');
    print('$lastname');
    print('$email');
    print('$password');
    try {
      var responce = await http.post(
        '$baseURLForAccounts$signUp',
        body: {
          'first_name': '$firstname',
          'last_name': '$lastname',
          'email': '$email',
          'password': '$password'
        },
        headers: {'Authorization': accountKey},
      );
      var data = jsonDecode(responce.body);
      print('SignUP responce is== $data');
      provider.setLoding('donot');
      if (responce.statusCode == 201) {
        Future.delayed(Duration(seconds: 2), () {
          Navigator.push(
              context,
              PageTransition(
                  duration: Duration(milliseconds: 500),
                  type: PageTransitionType.rightToLeft,
                  child: OTPVareficationPage(
                    email: email,
                  )));
        });
      } else {
        Map mapdata = data;
        if (mapdata.containsKey('email')) {
          String text = (mapdata['email'])
              .toString()
              .replaceAll('[', '')
              .replaceAll(']', '');
          LocalWidgets.snackbar(provider.scaffoldKey, '$text', Colors.black);
        } else if (mapdata.containsKey('password')) {
          String text = (mapdata['password'])
              .toString()
              .replaceAll('[', '')
              .replaceAll(']', '');
          LocalWidgets.snackbar(provider.scaffoldKey, '$text', Colors.black);
        } else {
          LocalWidgets.snackbar(
              provider.scaffoldKey, '${data['error']}', Colors.black);
        }
      }
    } catch (e) {
      print('${e.toString()}');
    }
  }

  static Future getLoginCalling(
      {String email,
      String password,
      GlobalKey<ScaffoldState> scaffoldkey,
      BuildContext context,
      BlockLogin provider}) async {
    try {
      var responce = await http.post(
        '$baseURLForAccounts$login',
        body: {
          'email': '$email',
          'password': '$password',
          'device_id': '${ApiUtils.deviceID}',
          "device_type": "${ApiUtils.devicetype}",
          "firebase_token": "${ApiUtils.firebasetoken}"
        },
        headers: {'Authorization': accountKey},
      );
      var data = jsonDecode(responce.body);
      print('Login responce is== $data');
      print('Login responce code== ${responce.statusCode}');
      provider.setLoding(false);
      if (responce.statusCode == 200) {
        provider.setLoding(false);
        SharedPreferenceClass.addStringToSP('${data['access_token']}');
        ApiUtils.token = '${data['access_token']}';
        initialchekingPageData(provider.scaffoldKey.currentContext);
      } else {
        Map mapdata = data;
        if (mapdata.containsKey('email')) {
          String text = (mapdata['email'])
              .toString()
              .replaceAll('[', '')
              .replaceAll(']', '');
          LocalWidgets.snackbar(provider.scaffoldKey, '$text', Colors.black);
        } else if (mapdata.containsKey('password')) {
          String text = (mapdata['password'])
              .toString()
              .replaceAll('[', '')
              .replaceAll(']', '');
          LocalWidgets.snackbar(provider.scaffoldKey, '$text', Colors.black);
        } else if (mapdata.containsKey('detail')) {
          String text = (mapdata['detail'])
              .toString()
              .replaceAll('[', '')
              .replaceAll(']', '');
          LocalWidgets.snackbar(provider.scaffoldKey, '$text', Colors.black);
        } else {
          // Map map =data['error'];
          // if(map.containsKey('email')){
          //   String text = (map['email'])
          //       .toString()
          //       .replaceAll('[', '')
          //       .replaceAll(']', '');
          //   LocalWidgets.snackbar(
          //       provider.scaffoldKey, '$text', Colors.black);
          // }else{
          //   LocalWidgets.snackbar(
          //       provider.scaffoldKey, '${data['error']}', Colors.black);
          // }
          String text = (data['error'])
              .toString()
              .replaceAll('[', '')
              .replaceAll(':', '')
              .replaceAll('}', '')
              .replaceAll('{', '')
              .replaceAll(']', '');
          LocalWidgets.snackbar(provider.scaffoldKey, '$text', Colors.black);
          if (data['error'] ==
              'Email is not verified, please verify your email to login') {
            getResendCodeCalling(email: '$email');
            Future.delayed(Duration(seconds: 1), () {
              Navigator.push(
                  context,
                  PageTransition(
                      duration: Duration(milliseconds: 500),
                      type: PageTransitionType.rightToLeft,
                      child: OTPVareficationPage(
                        email: email,
                      )));
            });
          }
        }
      }
    } catch (e) {
      provider.setLoding(false);
      print('error is${e.toString()}');
    }
  }

  static Future sendSlectedTaskData(
      {GlobalKey<ScaffoldState> scaffoldkey, BlockHomePage provider}) async {
    try {
      var responce = await http.post('$baseURLForAppTask$sendSlectedTask',
          headers: {'Authorization': 'Bearer $token'},
          body: {'data': '${provider.listSelectedId}'});
      var data = jsonDecode(responce.body);
      print('send task=$data');
      provider.setisloading(false);
      if (responce.statusCode == 200) {
        Navigator.push(
            provider.scaffoldKey.currentContext,
            PageTransition(
                duration: Duration(milliseconds: 500),
                type: PageTransitionType.rightToLeft,
                child: ChangeNotifierProvider(
                  create: (_) => BlockMantorSelection(),
                  child: MantorSelectionPage(),
                )));
      }
      var map = <String, dynamic>{'String': provider.listSelectedId.toString()};
      FireBaseAnalyticsServices.addAnalyticsEvent(
          eventName: 'Bucket_SubBucket', map: map);
    } catch (e) {
      print('${e.toString()}');
    }
  }

  static Future sendSubBucketTaskData(
      {GlobalKey<ScaffoldState> scaffoldkey,
      BlockCustomSubbucket provider}) async {
    try {
      var responce = await http.post('$baseURLForAppTask$sendSlectedTask',
          headers: {'Authorization': 'Bearer $token'},
          body: {'data': '${provider.subbucketList}'});
      var data = jsonDecode(responce.body);
      print('send task=$data');
      if (responce.statusCode == 200) {
        provider.setloadingaddtask(false);
        Future.delayed(Duration(), () {
          Navigator.pushAndRemoveUntil(
            provider.scaffoldKey.currentContext,
            PageTransition(
                duration: Duration(milliseconds: 800),
                type: PageTransitionType.rightToLeft,
                child: ChangeNotifierProvider(
                  create: (_) => BlockFinalHomePage(),
                  child: FinalHomePageClass(
                    token: ApiUtils.token,
                  ),
                )),
            ModalRoute.withName('/'),
          );
        });
      }
    } catch (e) {
      print('${e.toString()}');
    }
  }

  static Future sendSlectedMentorData(
      {GlobalKey<ScaffoldState> scaffoldkey,
      BlockMantorSelection provider,
      bool isafter}) async {
    print('selected id idss == ${provider.listSelectedId}');
    try {
      var responce = await http.post('$baseURLForAppTask$sendSelectedmantor',
          headers: {'Authorization': 'Bearer $token'},
          body: {'data': '${provider.listSelectedId}'});
      var data = jsonDecode(responce.body);
      provider.setAPiCall(false);
      print('send mantor task =$data');
      print('send mantor Status =${responce.statusCode}');
      if (responce.statusCode == 200) {
        if (isafter == true) {
          Navigator.pushAndRemoveUntil(
            provider.scaffoldKey.currentContext,
            PageTransition(
                duration: Duration(milliseconds: 500),
                type: PageTransitionType.rightToLeft,
                child: ChangeNotifierProvider(
                  create: (_) => BlockFinalHomePage(),
                  child: FinalHomePageClass(),
                )),
            ModalRoute.withName('/'),
          );
        } else {
          if (provider.userProfile == false) {
            Navigator.push(
                provider.scaffoldKey.currentContext,
                PageTransition(
                    duration: Duration(milliseconds: 500),
                    type: PageTransitionType.rightToLeft,
                    child: ChangeNotifierProvider(
                      create: (_) => BlockUserGenderSelection(),
                      child: ProfileUpdate(),
                    )));
          } else {
            Navigator.pushAndRemoveUntil(
              provider.scaffoldKey.currentContext,
              PageTransition(
                  duration: Duration(milliseconds: 500),
                  type: PageTransitionType.rightToLeft,
                  child: ChangeNotifierProvider(
                    create: (_) => BlockFinalHomePage(),
                    child: FinalHomePageClass(),
                  )),
              ModalRoute.withName('/'),
            );
          }
        }
        var map = <String, dynamic>{
          'String': provider.listSelectedId.toString()
        };
        FireBaseAnalyticsServices.addAnalyticsEvent(
            eventName: 'Selected_Mentor', map: map);
      }
    } catch (e) {
      print('${e.toString()}');
    }
  }

  static Future addAditionalMentorData(
      {GlobalKey<ScaffoldState> scaffoldkey,
      BlockAdditionalSubMentroTask provider,
      bool isafter}) async {
    print('selected id idss == ${provider.subbucketList}');
    try {
      var responce = await http.post('$baseURLForAppTask$sendSelectedmantor',
          headers: {'Authorization': 'Bearer $token'},
          body: {'data': '${provider.subbucketList}'});
      var data = jsonDecode(responce.body);
      print('send mantor task =$data');
      print('send mantor Status =${responce.statusCode}');
      if (responce.statusCode == 200) {
        provider.setloadingaddtask(false);
        Navigator.pushAndRemoveUntil(
            provider.scaffoldKey.currentContext,
            PageTransition(
                duration: Duration(milliseconds: 500),
                type: PageTransitionType.rightToLeft,
                child: ChangeNotifierProvider(
                  create: (_) => BlockFinalHomePage(),
                  child: FinalHomePageClass(),
                )),
            ModalRoute.withName('/'));
      }
    } catch (e) {
      print('${e.toString()}');
    }
  }

  static Future getMantorTaskData(
      {GlobalKey<ScaffoldState> scaffoldkey,
      BlockMantorSelection provider}) async {
    try {
      var responce = await http.get('$baseURLForAppTask$mantor',
          headers: {'Authorization': 'Bearer $token'});
      var data = jsonDecode(responce.body);
      print('mantor data is data is $data');
      if (responce.statusCode == 200) {
        provider.setTaskList(data);
        print('Data loading');
      } else if (responce.statusCode == 400) {
        print('Data lOading error');
      } else {}
    } catch (e) {
      print('${e.toString()}');
    }
  }

  static Future getTaskData(
      {GlobalKey<ScaffoldState> scaffoldkey, BlockHomePage provider}) async {
    print('task token==${provider.token}');
    try {
      var responce = await http.get('$baseURLForAppTask$task',
          headers: {'Authorization': 'Bearer $token'});
      List data = jsonDecode(responce.body);
      print('task data is $data');
      List l1 = [];
      for (var i in provider.firstIds) {
        for (var j in data) {
          if (i == j['id']) {
            l1.add(j);
          }
        }
      }
      l1.forEach((element) {
        data.remove(element);
      });
      List finaldataList = [...l1, ...data];
      print('first list is == $l1');
      print('final list data is == $finaldataList');
      if (responce.statusCode == 200) {
        provider.setTaskList(finaldataList);
        print('Data loading');
      } else if (responce.statusCode == 400) {
        print('Data lOading error');
      } else {}
    } catch (e) {
      print('${e.toString()}');
    }
  }

  static Future getOTPVareficationCalling({
    String otpText,
    GlobalKey<ScaffoldState> scaffoldkey,
    BuildContext context,
  }) async {
    try {
      var responce = await http.patch(
        '$baseURLForAccounts$otprequest',
        body: {
          'otp': '$otpText',
        },
        headers: {'Authorization': accountKey},
      );
      var data = jsonDecode(responce.body);
      if (responce.statusCode == 200) {
        Future.delayed(Duration(seconds: 1), () {
          SharedPreferenceClass.addStringToSP('${data['access_token']}');
          ApiUtils.token = '${data['access_token']}';
          initialchekingPageData(scaffoldkey.currentContext);
        });
      } else if (responce.statusCode == 400) {
      } else {}
    } catch (e) {
      print('${e.toString()}');
    }
  }

  static Future getResendCodeCalling({
    String email,
    GlobalKey<ScaffoldState> scaffoldkey,
    BuildContext context,
  }) async {
    try {
      var responce = await http.post(
        '$baseURLForAccounts$resendOtp',
        body: {
          'email': '$email',
        },
        headers: {'Authorization': accountKey},
      );
      var data = jsonDecode(responce.body);
      print('otp Data is =$data');
      if (responce.statusCode == 200) {}
    } catch (e) {
      print('${e.toString()}');
    }
  }

  static Future getResendCodeForResetPasswordCalling(
      {String email,
      GlobalKey<ScaffoldState> scaffoldkey,
      BuildContext context,
      BlockForgotPassword provider}) async {
    try {
      var responce = await http.post(
        '$baseURLForAccounts$createNewPasswordforemail',
        body: {
          'email': '$email',
        },
        headers: {'Authorization': accountKey},
      );
      var data = jsonDecode(responce.body);
      print('Data is =$data');
      if (responce.statusCode == 200) {
        provider.setVerifyEmail('do');
      }
    } catch (e) {
      print('${e.toString()}');
    }
  }

  static Future getCreateNewPasswordCalling(
      {String password,
      String otp,
      GlobalKey<ScaffoldState> scaffoldkey,
      BuildContext context}) async {
    try {
      var responce = await http.patch(
        '$baseURLForAccounts$createNewPassword',
        body: {
          'password': '$password',
          'otp': '$otp',
        },
        headers: {'Authorization': accountKey},
      );
      var data = jsonDecode(responce.body);
      print('data is = $data');
      print('responce is =${responce.statusCode}');
      if (responce.statusCode == 200) {
        Navigator.push(
            context,
            PageTransition(
                duration: Duration(milliseconds: 500),
                type: PageTransitionType.leftToRight,
                child: ChangeNotifierProvider(
                  create: (_) => BlockLogin(),
                  child: LoginPage(),
                )));
      }
      if (responce.statusCode == 200) {
      } else if (responce.statusCode == 400) {
      } else {}
    } catch (e) {
      print('${e.toString()}');
    }
  }

  static Future<Null> faceBooklogin({BlockLogin provider}) async {
    FacebookLogin _facebookSignIn = FacebookLogin();
    await _facebookSignIn.logOut();
    final FacebookLoginResult result = await _facebookSignIn.logIn(['email']);

    switch (result.status) {
      case FacebookLoginStatus.loggedIn:
        final FacebookAccessToken accessToken = result.accessToken;
        provider.setfbToken('${accessToken.token}');
        break;
      case FacebookLoginStatus.cancelledByUser:
        provider.setFBLoginSucces(false);
        provider.setfbToken('user cancel fb login request');
        break;
      case FacebookLoginStatus.error:
        provider.setFBLoginSucces(false);
        provider.setfbToken('fb login proces issue');
        break;
    }
  }

  static Future<Null> faceBookSignUp({BlockSignUp provider}) async {
    FacebookLogin _facebookSignIn = FacebookLogin();
    final FacebookLoginResult result = await _facebookSignIn.logIn(['email']);

    switch (result.status) {
      case FacebookLoginStatus.loggedIn:
        final FacebookAccessToken accessToken = result.accessToken;
        provider.setfbToken('${accessToken.token}');
        provider.setFBLoginSucces(true);
        break;
      case FacebookLoginStatus.cancelledByUser:
        provider.setfbToken('user cancel fb login request');
        provider.setFBLoginSucces(false);
        break;
      case FacebookLoginStatus.error:
        provider.setFBLoginSucces(false);
        provider.setfbToken('fb login proces issue');
        break;
    }
  }

  static Future<Null> gmailLogin({BlockLogin provider}) async {
    GoogleSignIn _googleSignIn = GoogleSignIn(
        scopes: ['email', 'https://www.googleapis.com/auth/contacts.readonly']);
    await _googleSignIn.signOut();
    try {
      await _googleSignIn.signIn().then((value) => {
            value.authentication.then((value) => {
                  print('gmai token is==${value.accessToken}'),
                  provider.setGmailToken((value.accessToken).toString()),
                  provider.setGmailLoginSucces(true),
                  ApiUtils.gmailLoginrequestSent(provider: provider)
                })
          });
    } catch (err) {
      print('error is$err');
      provider.setGmailLoginSucces(false);
    }
  }

  static Future<Null> gmailforSignUp({BlockSignUp provider}) async {
    GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);
    try {
      await _googleSignIn.signIn().then((value) => {
            value.authentication.then((value) => {
                  print('Gmail for sign up token is =${value.accessToken}'),
                  provider.setGmailToken((value.accessToken).toString()),
                  provider.setGmailLoginSucces(true)
                })
          });
    } catch (err) {
      print('error is$err');
      provider.setGmailLoginSucces(false);
    }
  }

  static Future gmailforSignLoginrequestSent({BlockSignUp provider}) async {
    try {
      var responce = await http.post(
        '$baseURLForAccounts$gmailLoginRequest',
        body: {
          "access_token": '${provider.userGmailToken}',
          "device_id": '${ApiUtils.deviceID}',
          "device_type": "${ApiUtils.devicetype}",
          "firebase_token": "${ApiUtils.firebasetoken}",
          'refresh_token': '123'
        },
        headers: {'Authorization': accountKey},
      );
      var data = jsonDecode(responce.body);
      print('Data is =$data');
      if (responce.statusCode == 200) {
        SharedPreferenceClass.addStringToSP('${data['access_token']}');
        ApiUtils.token = '${data['access_token']}';
        initialchekingPageData(provider.scaffoldKey.currentContext);
      } else {
        print('error from server$data');
      }
    } catch (e) {
      print('error is ==${e.toString()}');
    }
  }

  static Future gmailLoginrequestSent({BlockLogin provider}) async {
    print("fcm request is = ${ApiUtils.firebasetoken}");
    try {
      var responce = await http.post(
        '$baseURLForAccounts$gmailLoginRequest',
        body: {
          'access_token': '${provider.userGmailToken}',
          'device_id': '${ApiUtils.deviceID}',
          "device_type": "${ApiUtils.devicetype}",
          "firebase_token": "${ApiUtils.firebasetoken}",
          'refresh_token': '123'
        },
        headers: {'Authorization': accountKey},
      );
      var data = jsonDecode(responce.body);
      print('Data is sented=$data');
      if (responce.statusCode == 200) {
        SharedPreferenceClass.addStringToSP('${data['access_token']}');
        ApiUtils.token = '${data['access_token']}';
        initialchekingPageData(provider.scaffoldKey.currentContext);
      } else {
        print('error from server$data');
      }
    } catch (e) {
      print('error is ==${e.toString()}');
    }
  }

  static Future fbLoginrequestSent({BlockLogin provider}) async {
    print('fb token is ${provider.fbToken}');
    try {
      var responce = await http.post(
        '$baseURLForAccounts$fbLoginRequest',
        body: {
          'access_token': '${provider.fbToken}',
          'device_id': '${ApiUtils.deviceID}',
          "device_type": "${ApiUtils.devicetype}",
          "firebase_token": "${ApiUtils.firebasetoken}",
          'refresh_token': '123'
        },
        headers: {'Authorization': accountKey},
      );
      var data = jsonDecode(responce.body);
      print('fbLogin reponce is =$data');
      if (responce.statusCode == 200) {
        SharedPreferenceClass.addStringToSP('${data['access_token']}');
        ApiUtils.token = '${data['access_token']}';
        initialchekingPageData(provider.scaffoldKey.currentContext);
      }
    } catch (e) {
      print('${e.toString()}');
    }
  }

  static Future fbSignrequestSent({BlockSignUp provider}) async {
    try {
      var responce = await http.post(
        '$baseURLForAccounts$fbLoginRequest',
        body: {
          'access_token': '${provider.fbToken}',
          'device_id': '${ApiUtils.deviceID}',
          "device_type": "${ApiUtils.devicetype}",
          "firebase_token": "${ApiUtils.firebasetoken}",
          'refresh_token': '123'
        },
        headers: {'Authorization': accountKey},
      );
      var data = jsonDecode(responce.body);
      print('fb login Data is =$data');
      if (responce.statusCode == 200) {
        SharedPreferenceClass.addStringToSP('${data['access_token']}');
        ApiUtils.token = '${data['access_token']}';
        initialchekingPageData(provider.scaffoldKey.currentContext);
      }
    } catch (e) {
      print('${e.toString()}');
    }
  }

  static Future calenderAccess(
      {BuildContext context,
      String accesstoken,
      String refreshtoken,
      expire,
      bool isfirst,
      String wichCalender,
      String wich}) async {
    try {
      var responce = await http.post(
        '$apiURL/account/1/calendar/',
        body: {
          "access_token": "$accesstoken",
          "refresh_token": "$refreshtoken",
          "platform": "$wich",
          "expire": expire
        },
        headers: {'Authorization': 'Bearer $token'},
      );
      var data = jsonDecode(responce.body);
      if (isfirst == true) {
        Navigator.pushAndRemoveUntil(
            PullCalenderPage.provider.scaffoldKey.currentContext,
            PageTransition(
                duration: Duration(milliseconds: 50),
                type: PageTransitionType.rightToLeft,
                child: ChangeNotifierProvider(
                  create: (_) => PullCalenderBlock(),
                  child: PullCalenderPage(
                    isafter: true,
                  ),
                )),
            ModalRoute.withName('/'));
      }
    } catch (e) {
      print('${e.toString()}');
    }
  }

  static Future getClaenderlistforStart(
      {GlobalKey<ScaffoldState> scaffoldkey,
      bool isafter,
      PullCalenderBlock provider}) async {
    try {
      var responce = await http.get('$baseURLForAccounts$getcalenderlist',
          headers: {'Authorization': 'Bearer $token'});
      List data = jsonDecode(responce.body);
      print('calender data is $data');
      if (responce.statusCode == 200) {
        provider.setlistofcal(data);
        provider.setloading(true);
        if (isafter == true) {
          if (data.length > 0) {
            provider.setiscalender(true);
          }
        }
      } else if (responce.statusCode == 400) {
        print('Data lOading error');
      } else {}
    } catch (e) {
      print('${e.toString()}');
    }
  }

  static Future getClaenderlist(
      {GlobalKey<ScaffoldState> scaffoldkey,
      BlockCalenderList provider}) async {
    try {
      var responce = await http.get('$baseURLForAccounts$getcalenderlist',
          headers: {'Authorization': 'Bearer $token'});
      var data = jsonDecode(responce.body);
      print('calender data is $data');
      if (responce.statusCode == 200) {
        provider.setlistofcal(data);
        provider.setloading(true);
      } else if (responce.statusCode == 400) {
        print('Data lOading error');
      } else {}
    } catch (e) {
      print('${e.toString()}');
    }
  }

  static Future deleteClaenderlist(
      {GlobalKey<ScaffoldState> scaffoldkey,
      BlockCalenderList provider,
      id,
      int index}) async {
    print('$id');
    print('$index');
    try {
      var responce = await http.delete('$baseURLForAccounts$getcalenderlist$id',
          headers: {'Authorization': 'Bearer $token'});
      var data = jsonDecode(responce.body);
      print('calender data is $data');
      print('calender data is ${responce.statusCode}');
      if (responce.statusCode == 200) {
        provider.deleteList(index);
      } else {
        print('object');
      }
    } catch (e) {
      print('${e.toString()}');
    }
  }

  static Future deleteClaenderlistforpullCalender(
      {GlobalKey<ScaffoldState> scaffoldkey,
      PullCalenderBlock provider,
      id,
      int index}) async {
    print('$id');
    print('$index');
    try {
      var responce = await http.delete('$baseURLForAccounts$getcalenderlist$id',
          headers: {'Authorization': 'Bearer $token'});
      var data = jsonDecode(responce.body);
      print('calender data is $data');
      print('calender data is ${responce.statusCode}');
      if (responce.statusCode == 200) {
        provider.deleteList(index);
        if (provider.listofcal.length < 1) {
          provider.setloading(false);
          provider.setiscalender(false);
        }
      } else {
        print('object');
      }
    } catch (e) {
      print('${e.toString()}');
    }
  }

  static Future subMentorTask({
    BlockHomeSubmentor provider,
    BlockMantorSelection parentProvider,
    id,
  }) async {
    print('All url is = $baseURLForAppTask$submentorlist$id');
    try {
      var responce = await http.get('$baseURLForAppTask$submentorlist$id',
          headers: {'Authorization': 'Bearer $token'});
      List data = jsonDecode(responce.body);
      print('subMentorTask data is $data');
      print('subMentorTask status code ${responce.statusCode}');
      if (responce.statusCode == 200) {
        provider.setTaskList(data);
        data.forEach((element) {
          if (!parentProvider.listSelectedId.contains('${element['id']}')) {
            provider.setboolList(false);
          } else {
            provider.setboolList(true);
          }
        });
        provider.setLodingList(true);
      } else {
        print('object');
      }
    } catch (e) {
      print('${e.toString()}');
    }
  }

  static Future getCustomBucketTaskDataINADDTASK(
      {BlockAddCustomTask provider}) async {
    try {
      var responce = await http.get(
        '$baseURLForAppTask$bucket',
        headers: {'Authorization': 'Bearer $token'},
      );
      var data = jsonDecode(responce.body);
      print('Custom Bucket data is== $data');
      if (responce.statusCode == 200) {
        provider.setListOfBucket(data);
      }
    } catch (e) {
      print('${e.toString()}');
    }
  }

  static Future getSubCustomBucketTaskDataINADDTASK(
      {BlockAddCustomTask provider, var id}) async {
    try {
      var responce = await http.get(
        '$baseURLForAppTask$bucket$id$subbucket',
        headers: {'Authorization': 'Bearer $token'},
      );
      List data = jsonDecode(responce.body);
      provider.setlistofSubBucket(data);
    } catch (e) {
      print('${e.toString()}');
    }
  }

  static Future sendSubBucketTaskDataINADDTASK({String id}) async {
    List list = [];
    list.add('$id');
    try {
      var responce = await http.post('$baseURLForAppTask$sendSlectedTask',
          headers: {'Authorization': 'Bearer $token'}, body: {'data': '$list'});
      var data = jsonDecode(responce.body);
      print('send task=$data');
      if (responce.statusCode == 200) {}
    } catch (e) {
      print('${e.toString()}');
    }
  }

  static Future adminContact({String subject, String description}) async {
    try {
      var responce = await http.post('$baseURLForAccounts/contactus/',
          headers: {'Authorization': 'Bearer $token'},
          body: {"subject": "$subject", "message": "$description"});
      var data = jsonDecode(responce.body);
      print('contact us =$data');
      if (responce.statusCode == 200) {}
    } catch (e) {
      print('${e.toString()}');
    }
  }

  static Future UpdateUserData({String key, String description}) async {
    print('sound is = $description');
    try {
      var responce = await http.put('$baseURLForAccounts/user/',
          headers: {'Authorization': 'Bearer $token'},
          body: {"$key": "$description"});
      var data = jsonDecode(responce.body);
      print('user update us =$data');
      if (responce.statusCode == 200) {}
    } catch (e) {
      print('${e.toString()}');
    }
  }

  static Future getSubAdditionalSubBucketData(
      {BlockAdditionalSubMentroTask provider, var id}) async {
    print('id = $id');
    try {
      var responce = await http.get(
        '$baseURLForAppTask$submentorlist$id',
        headers: {'Authorization': 'Bearer $token'},
      );
      var data = jsonDecode(responce.body);
      print('Custom sub data is== $data');
      print('Custom sub data is== ${responce.statusCode}');
      if (responce.statusCode == 200) {
        provider.setCustomSubBucketData(data);
        provider.setLoading();
      }
    } catch (e) {
      print('${e.toString()}');
    }
  }

  static Future getsigleTaskData({BuildContext context, String id}) async {
    print('id is = $id');
    try {
      var responce = await http.get(
        '$baseURLForAppTask$finalHomePage$id',
        headers: {'Authorization': 'Bearer $token'},
      );
      var data = jsonDecode(responce.body);
      print('Single task data is== $data');
      print('Single task data is== ${responce.statusCode}');
      if (responce.statusCode == 200) {
        print('carasol text is = ${data['carousel_text']}');
        DateFormat dateFormat = new DateFormat.Hms();
        String t1 = '${data['start_time']}';
        String t2 = "${data['end_time']}";
        DateTime open = dateFormat.parse(t2);
        DateTime close = dateFormat.parse(t1);
        var difinMin = open.difference(close).inMinutes;
        if (difinMin < 0) {
          DateTime dateMax = dateFormat.parse("24:00:00");
          DateTime dateMin = dateFormat.parse("00:00:00");
          var difinMin2 = dateMax.difference(close).inMinutes;
          var difinMin3 = open.difference(dateMin).inMinutes;
          difinMin = difinMin2 + difinMin3;
          print('$difinMin');
        }
        print('$difinMin');
        Navigator.push(
            context,
            PageTransition(
                duration: Duration(milliseconds: 0),
                type: PageTransitionType.rightToLeft,
                child: OnFocusAnimationPage(
                  carasolList: data['carousel_text'],
                  id: "$id",
                  audio: "${data['audio_file']}",
                  animation: "$data['animation_file']}",
                  taskName: '${data['name']}',
                  min: difinMin,
                )));
      }
    } catch (e) {
      print('${e.toString()}');
    }
  }
}
