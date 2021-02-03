class FinalHomePageDataModel {
  static const String FINAL_HOME_Table = "finalHomePageData_Table";
  static const String ID = "id";
  static const String NAME = "name";
  static const String START_TIME = "start_time";
  static const String END_TIME = "end_time";
  static const String POIT = "point";
  static const String FOCUS = "focus";
  static const String BAT_HABBIT = "bad_habbit";
  static const String ANIMATION = "animation";
  static const String AUDIO = "audio";
  static const String FIVE_MIN_BEFORE = "_5_mins_before";
  static const String FIVE_SEC_BEFORE = "_5_sec_before";
  static const String DESCRIPTION = "description";
  static const String COLOR = "color";
  static const String DATE = "date";
  static const String UPDATE = "update";
  static const String DELETE = "delete";

  static const String CREATE_TABLE_FINAL_HOME_PAGE =
      "CREATE TABLE ${FinalHomePageDataModel.FINAL_HOME_Table}("
      "${FinalHomePageDataModel.ID} INTEGER PRIMARY KEY,"
      "${FinalHomePageDataModel.NAME} TEXT,"
      "${FinalHomePageDataModel.START_TIME} TEXT,"
      "${FinalHomePageDataModel.END_TIME} TEXT,"
      "${FinalHomePageDataModel.POIT} TEXT,"
      "${FinalHomePageDataModel.FOCUS} TEXT,"
      "${FinalHomePageDataModel.BAT_HABBIT} TEXT,"
      "${FinalHomePageDataModel.ANIMATION} TEXT,"
      "${FinalHomePageDataModel.AUDIO} TEXT,"
      "${FinalHomePageDataModel.FIVE_MIN_BEFORE} TEXT,"
      "${FinalHomePageDataModel.FIVE_SEC_BEFORE} TEXT,"
      "${FinalHomePageDataModel.DESCRIPTION} TEXT,"
      "${FinalHomePageDataModel.COLOR} TEXT,"
      "${FinalHomePageDataModel.DATE} TEXT,"
      "${FinalHomePageDataModel.UPDATE} TEXT,"
      "${FinalHomePageDataModel.DELETE} TEXT"
      ")";

  static const String DELETE_ALL_QUERY =
      "Delete * from ${FinalHomePageDataModel.FINAL_HOME_Table}";

  int id;
  String name;
  String start_time;
  String end_time;
  String point;
  String focus;
  String bad_habbit;
  String animation;
  String audio;
  String f_5_mins_before;
  String f_5_sec_before;
  String description;
  String color;
  String date;
  String update;
  String delete;
  FinalHomePageDataModel(
      {this.id,
      this.name,
      this.start_time,
      this.end_time,
      this.point,
      this.focus,
      this.animation,
      this.audio,
      this.f_5_mins_before,
      this.f_5_sec_before,
      this.description,
      this.color,
      this.bad_habbit,
      this.date,
      this.update,
      this.delete});

  factory FinalHomePageDataModel.fromJson(Map<String, dynamic> json) =>
      FinalHomePageDataModel(
        id: json["id"],
        name: json["name"],
        start_time: json["start_time"],
        end_time: json["end_time"],
        point: json["point"],
        focus: json["focus"],
        bad_habbit: json["bad_habbit"],
        animation: json["animation"],
        audio: json["audio"],
        f_5_mins_before: json["f_5_mins_before"],
        f_5_sec_before: json["f_5_sec_before"],
        description: json["description"],
        color: json["color"],
        date: json["date"],
        update: json["update"],
        delete: json["delete"]
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "start_time": start_time,
        "end_time": end_time,
        "point": point,
        "focus": focus,
        "bad_habbit": bad_habbit,
        "animation": animation,
        "audio": audio,
        "_5_mins_before": f_5_mins_before,
        "_5_sec_before": f_5_sec_before,
        "description": description,
        "color": color,
        "date": date,
        "update": update,
        "delete": delete
      };
}
