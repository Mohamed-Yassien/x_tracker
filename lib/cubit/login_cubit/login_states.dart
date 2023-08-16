import 'package:x_tracker_map/models/login_model.dart';
import 'package:x_tracker_map/models/logout_model.dart';
import 'package:x_tracker_map/modules/login_screen.dart';

abstract class LoginStates {}

class LoginInitialState extends LoginStates {}

class LoginChangePasswordVisibilityState extends LoginStates {}

class LoginUserLoadingState extends LoginStates {}

class LoginUserSuccessState extends LoginStates {
  final LoginModel loginModel;

  LoginUserSuccessState(this.loginModel);
}

class LoginUserErrorState extends LoginStates {}

class ChangeUserEnableSuccessState extends LoginStates {}

class ChangeUserEnableErrorState extends LoginStates {}
