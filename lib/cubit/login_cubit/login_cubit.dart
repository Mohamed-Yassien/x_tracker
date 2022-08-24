import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:x_tracker_map/cubit/login_cubit/login_states.dart';
import 'package:x_tracker_map/models/login_model.dart';
import 'package:x_tracker_map/network/remote/dio_helper.dart';
import 'package:x_tracker_map/shared/constants.dart';

import '../../network/endpoints.dart';
import '../../network/local/cache_helper.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(LoginInitialState());

  static LoginCubit get(context) => BlocProvider.of(context);

  bool isPassword = true;

  IconData iconData = Icons.visibility_off;

  void changePasswordVisibility() {
    isPassword = !isPassword;
    iconData = isPassword ? Icons.visibility_off : Icons.visibility;
    emit(LoginChangePasswordVisibilityState());
  }

  LoginModel? loginModel;

  void userLogin({
    required String phone,
    required String pin,
  }) async {
    emit(LoginUserLoadingState());
    await getDeviceInfo();
    DioHelper.postData(url: LOGIN, data: {
      'mobile_no': phone,
      'pin': pin,
      'deviceid': deviceId,
      'devicetoken': deviceToken,
      'devicetype': 'a',
    }).then((value) {
      loginModel = LoginModel.fromJson(value.data);
      print(loginModel!.message);
      emit(LoginUserSuccessState(loginModel!));
    }).catchError((error) {
      print(error.toString());
      emit(LoginUserErrorState());
    });
  }

  Future<void> getDeviceInfo() async {
    Future<String?> getId() async {
      var deviceInfo = DeviceInfoPlugin();
      if (Platform.isAndroid) {
        var androidDeviceInfo = await deviceInfo.androidInfo;
        return androidDeviceInfo.id ?? '';
      }
      return null;
    }

    FirebaseMessaging messaging = FirebaseMessaging.instance;
    String? token = await messaging.getToken();

    String? id = await getId();

    await CacheHelper.saveData(key: 'deviceId', value: id);
    await CacheHelper.saveData(key: 'deviceToken', value: token);

    print('device id is $deviceId');
    print('device token is $deviceToken');
  }
}
