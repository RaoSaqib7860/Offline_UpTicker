class EditDataModel {
  static const String FINAL_HOME_Table = "EditData_Table";
  static const String PARENT_ID = "id";
  static const String ID = "id";
  static const String DELETE = "delete";
  static const String DATE = "date";

  static const String CREATE_TABLE_EDIT_DATA =
      "CREATE TABLE ${EditDataModel.FINAL_HOME_Table}("
      "${EditDataModel.ID} INTEGER PRIMARY KEY,"
      "${EditDataModel.PARENT_ID} TEXT,"
      "${EditDataModel.DELETE} TEXT,"
      "${EditDataModel.DATE} TEXT"
      ")";

  static const String DELETE_ALL_QUERY =
      "Delete * from ${EditDataModel.FINAL_HOME_Table}";

  int id;
  String parentid;
  String delete;
  String date;

  EditDataModel({this.id, this.parentid, this.delete, this.date});

  factory EditDataModel.fromJson(Map<String, dynamic> json) => EditDataModel(
        id: json["id"],
        parentid: json["name"],
        delete: json["start_time"],
        date: json["end_time"],
      );

  Map<String, dynamic> toJson() =>
      {"id": id, "parentid": parentid, "delete": delete, "date": date};
}
