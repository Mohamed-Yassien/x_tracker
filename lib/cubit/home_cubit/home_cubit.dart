import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:location/location.dart';
import 'package:path_provider/path_provider.dart';
import 'package:x_tracker_map/cubit/home_cubit/home_states.dart';
import 'package:x_tracker_map/models/send_location_model.dart';
import 'package:x_tracker_map/network/local/cache_helper.dart';
import 'package:x_tracker_map/services/local_notification_service.dart';
import 'package:x_tracker_map/shared/widgets/reusable_toast.dart';

import '../../models/logout_model.dart';
import '../../network/endpoints.dart';
import '../../network/remote/dio_helper.dart';
import '../../shared/constants.dart';

class HomeCubit extends Cubit<HomeStates> {
  HomeCubit() : super(HomeInitialState());

  static HomeCubit get(context) => BlocProvider.of(context);

  LogOutModel? logOutModel;

  void userLogOut() {
    emit(UserLogOutLoadingState());
    DioHelper.postData(url: LOGOUT, data: {
      'id': userId,
    }).then((value) async {
      logOutModel = LogOutModel.fromJson(value.data);
      print(logOutModel!.message);
      await CacheHelper.remove(key: 'login');
      await CacheHelper.remove(key: 'user_name');
      await CacheHelper.remove(key: 'user_id');
      emit(UserLogOutSuccessState(logOutModel!));
    }).catchError((error) {
      print(error.toString());
      emit(UserLogOutErrorState());
    });
  }

  bool hasInternet = false;

  Future<void> internetListener() async {
    InternetConnectionChecker().onStatusChange.listen(
      (event) async {
        print('connection now is $event');
        if (event == InternetConnectionStatus.connected) {
          hasInternet = true;
          emit(InternetConnectionListenerConnectedState());
          print('has net = $hasInternet');
        } else if (event == InternetConnectionStatus.disconnected) {
          hasInternet = false;
          emit(InternetConnectionListenerDisConnectedState());
          print('has net = $hasInternet');
        }
      },
    );
  }

  bool isOffline = true;
  String buttonText = 'Start';
  String statusText = 'offline';
  String alertContent = 'Start Sending Your Location';
  Color statusTextColor = Colors.red;

  void changeUserStatus() async {
    isOffline = !isOffline;
    buttonText = isOffline ? 'Start' : 'Stop';
    alertContent = isOffline
        ? 'Start Sending Your Location'
        : 'Stop Sending Your Location';
    statusTextColor = isOffline ? Colors.red : Colors.green;
    statusText = isOffline ? 'offline' : 'online';
    emit(ChangeUserStatusState());
    if (!isOffline) {
      showNotification();
      Timer.periodic(
        const Duration(seconds: 10),
        (timer) async {
          determinePositionWithLocation().then(
            (value) {
              if (!isOffline) {
                internetListener().then(
                  (value2) {
                    if (hasInternet == true) {
                      sendUserLocationToServer(
                        latitude: value.latitude,
                        longitude: value.longitude,
                        dateTime: DateTime.now().toString(),
                        stopPoint: 1,
                      );
                      emit(TrueCheckState());
                    } else if (hasInternet == false) {
                      showToast(
                        msg: 'no internet connection ! saved offline',
                        toastStates: ToastStates.ERROR,
                      );
                      writeJsonData(
                        latKey: 'latitude',
                        latValue: value.latitude.toString(),
                        longKey: 'longitude',
                        longValue: value.longitude.toString(),
                        time: DateTime.now().toString(),
                        stopPoint: 1,
                      ).then(
                        (value3) {
                          emit(WriteJsonToFileState());
                        },
                      );
                      emit(FalseCheckState());
                      print('lat is ${value.latitude}');
                      print('long is ${value.longitude}');
                    }
                  },
                );
              }
            },
          );
        },
      );
    } else {
      if (hasInternet == true) {
        determinePositionWithLocation().then((value) {
          sendUserLocationToServer(
            latitude: value.latitude,
            longitude: value.longitude,
            dateTime: DateTime.now().toString(),
            stopPoint: 0,
          );
        });
      } else if (hasInternet == false) {
        determinePositionWithLocation().then((value) {
          writeJsonData(
            latKey: 'latitude',
            latValue: value.latitude.toString(),
            longKey: 'longitude',
            longValue: value.longitude.toString(),
            time: DateTime.now().toString(),
            stopPoint: 0,
          );
        });
      }
    }
  }

  Completer<GoogleMapController> mController = Completer();

  Set<Marker> markers = {};

  CameraPosition? cameraPosition;

  LocationData? locationData;

  void getInitialCameraPosition() {
    determinePositionWithLocation().then(
      (value) {
        cameraPosition = CameraPosition(
          target: LatLng(
            value.latitude!,
            value.longitude!,
          ),
          zoom: 14,
        );
        emit(GetCurrentLocationSuccessState());
      },
    );
  }

  CameraPosition initialCameraPosition = const CameraPosition(
    target: LatLng(
      37.42796133580664,
      -122.085749655962,
    ),
    zoom: 14.4746,
  );

  Future<void> updateMapPosition(LocationData position) async {
    final GoogleMapController controller = await mController.future;
    controller.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: LatLng(
            position.latitude!,
            position.longitude!,
          ),
          zoom: 17,
        ),
      ),
    );
    markers.clear();
    markers.add(
      Marker(
          markerId: const MarkerId('currentLocation'),
          position: LatLng(
            position.latitude!,
            position.longitude!,
          ),
          icon: BitmapDescriptor.defaultMarker,
          onTap: () {
            showToast(
              msg: 'current Location',
              toastStates: ToastStates.SUCCESS,
            );
          }),
    );
    emit(UpdateUserLocationState());
  }

  Future<LocationData> determinePositionWithLocation() async {
    Location location = Location();

    bool serviceEnabled;
    PermissionStatus permissionGranted;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        Future.error('error');
      }
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted == PermissionStatus.deniedForever) {
        Future.error('error');
      }
    }
    return await Location().getLocation();
  }

  void enableBackGroundTrack() async {
    try {
      await Location.instance.enableBackgroundMode(enable: true);
    } catch (e) {
      print(e.toString());
    }
  }

  SendLocationModel? sendLocationModel;

  void sendUserLocationToServer({
    required latitude,
    required longitude,
    required dateTime,
    required stopPoint,
  }) {
    emit(SendUserLocationToServerLoadingState());
    DioHelper.postData(
      url: SEND_LOCATION,
      data: {
        'empId': userId,
        'dateTime': dateTime,
        'latitude': latitude,
        'longitude': longitude,
        'stoppoint': stopPoint,
      },
    ).then((value) {
      sendLocationModel = SendLocationModel.fromJson(value.data);
      print(sendLocationModel!.message);
      emit(SendUserLocationToServerSuccessState());
    }).catchError(
      (error) {
        print(error.toString());
        emit(SendUserLocationToServerErrorState());
      },
    );
  }

  void showNotification() {
    LocalNotificationService.showNotification().then((value) {
      emit(ShowNotificationState());
    }).catchError((error) {
      print(error.toString());
    });
  }

  Future<String> localPath() async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get localJsonFile async {
    final path = await localPath();
    return File('$path/location.json');
  }

  List<dynamic> json = [];
  String? jsonString;

  Future<File> writeJsonData({
    required String latKey,
    required String latValue,
    required String longKey,
    required String longValue,
    required String time,
    required stopPoint,
  }) async {
    final filePath = await localJsonFile;
    Map<String, dynamic> newJson = {
      latKey: latValue,
      longKey: longValue,
      'time': time,
      'stop point': stopPoint,
    };
    print('1.(_writeJson) _newJson: $newJson');
    json.add(newJson);
    print('2.(_writeJson) _json(updated): $json');
    jsonString = jsonEncode(json);
    print('3.(_writeJson) _jsonString: $jsonString\n - \n');
    return filePath.writeAsString(jsonString!);
  }

  Future<List<dynamic>?> readJsonFile() async {
    final filePath = await localJsonFile;
    bool fileExists = await filePath.exists();
    print('0. File exists? $fileExists');
    if (fileExists) {
      try {
        jsonString = await filePath.readAsString();
        print('1.(_readJson) _jsonString: $jsonString');
        json = jsonDecode(jsonString!);
        print('2.(_readJson) _json: $json \n - \n');
        return json;
      } catch (e) {
        print('Tried reading _file error: $e');
      }
    }
    return json;
  }

  Future<void> checkIfUserHasOfflineData() async {
    await internetListener();

    if (hasInternet = true) {
      var offline = await readJsonFile();
      if (offline!.isNotEmpty) {
        if (hasInternet) {
          showToast(
            msg: 'you have offline data',
            toastStates: ToastStates.WARNING,
          );
          offline.forEach(
            (element) {
              sendUserLocationToServer(
                latitude: element['latitude'],
                longitude: element['longitude'],
                dateTime: element['time'],
                stopPoint: 1,
              );
            },
          );
          localJsonFile.then(
            (value) {
              value.delete();
              emit(ClearUserOfflineDataAfterSendingItToServerState());
            },
          );
          showToast(
            msg: 'finish sending offline data',
            toastStates: ToastStates.SUCCESS,
          );
        }
      }
    }
  }

  void initializedNotification() async {
    await LocalNotificationService.initialize();
  }
}
