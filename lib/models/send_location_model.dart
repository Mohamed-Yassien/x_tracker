class SendLocationModel {
  String? success;
  String? message;
  Data? data;
  String? command;
  dynamic stoppoint;


  SendLocationModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    command = json['command'];
    stoppoint = json['stoppoint'];
  }
}

class Data {
  String? action;
  String? id;
  String? name;
  String? image;
  String? mobile;
  String? address1;
  String? city;
  String? busId;
  String? assistantName;
  String? assistantMobile;
  String? driverId;
  String? schoolId;
  String? number;
  String? logStatus;
  String? devicetoken;

  Data.fromJson(Map<String, dynamic> json) {
    action = json['action'];
    id = json['id'];
    name = json['name'];
    image = json['image'];
    mobile = json['mobile'];
    address1 = json['address1'];
    city = json['city'];
    busId = json['bus_id'];
    assistantName = json['assistant_name'];
    assistantMobile = json['assistant_mobile'];
    driverId = json['driver_id'];
    schoolId = json['school_id'];
    number = json['number'];
    logStatus = json['log_status'];
    devicetoken = json['devicetoken'];
  }

}
