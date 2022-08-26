import '../../models/logout_model.dart';

abstract class HomeStates {}

class HomeInitialState extends HomeStates {}

class UserLogOutLoadingState extends HomeStates {}

class UserLogOutSuccessState extends HomeStates {
  final LogOutModel logOutModel;

  UserLogOutSuccessState(this.logOutModel);
}

class UserLogOutErrorState extends HomeStates {}

class ChangeUserStatusState extends HomeStates {}

class UpdateUserLocationState extends HomeStates {}

class GetCurrentLocationLoadingState extends HomeStates {}

class GetCurrentLocationSuccessState extends HomeStates {}

class SendUserLocationToServerLoadingState extends HomeStates {}

class SendUserLocationToServerSuccessState extends HomeStates {}

class SendUserLocationToServerErrorState extends HomeStates {}

class InternetConnectionCheckerState extends HomeStates {}

class InternetConnectionListenerConnectedState extends HomeStates {}

class InternetConnectionListenerDisConnectedState extends HomeStates {}

class TrueCheckState extends HomeStates {}

class FalseCheckState extends HomeStates {}

class ShowNotificationState extends HomeStates {}

class WriteJsonToFileState extends HomeStates {}

class ReadJsonToFileState extends HomeStates {}

class GetUserOfflineDataLoadingState extends HomeStates {}

class GetUserOfflineDataSuccessState extends HomeStates {}

class GetUserOfflineDataErrorState extends HomeStates {}

class ClearUserOfflineDataAfterSendingItToServerState extends HomeStates{}

class ChangeBackgroundStatusState extends HomeStates{}

class SaveFileImageOfflineState extends HomeStates{}
