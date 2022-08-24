class LogOutModel {
  String? success;
  String? message;
  dynamic data;
  String? command;

  LogOutModel({this.success, this.message, this.data, this.command});

  LogOutModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'];
    command = json['command'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['message'] = message;
    data['data'] = data;
    data['command'] = command;
    return data;
  }
}
