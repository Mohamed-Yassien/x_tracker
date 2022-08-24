class LoginModel {
  String? mobileNo;
  String? success;
  String? message;
  Data? data;
  String? command;

  LoginModel({
    this.mobileNo,
    this.success,
    this.message,
    this.data,
    this.command,
  });

  LoginModel.fromJson(Map<String, dynamic> json) {
    mobileNo = json['mobile_no'];
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    command = json['command'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['mobile_no'] = mobileNo;
    data['success'] = success;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['command'] = command;
    return data;
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

  Data(
      {this.action,
      this.id,
      this.name,
      this.image,
      this.mobile,
      this.address1,
      this.city,
      this.busId,
      this.assistantName,
      this.assistantMobile,
      this.driverId,
      this.schoolId,
      this.number,
      this.logStatus});

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
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['action'] = action;
    data['id'] = id;
    data['name'] = name;
    data['image'] = image;
    data['mobile'] = mobile;
    data['address1'] = address1;
    data['city'] = city;
    data['bus_id'] = busId;
    data['assistant_name'] = assistantName;
    data['assistant_mobile'] = assistantMobile;
    data['driver_id'] = driverId;
    data['school_id'] = schoolId;
    data['number'] = number;
    data['log_status'] = logStatus;
    return data;
  }
}
