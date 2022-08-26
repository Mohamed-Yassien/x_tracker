// geolocator package
// Future<Position> determinePosition() async {
//   bool serviceEnabled;
//   LocationPermission permission;
//   serviceEnabled = await Geolocator.isLocationServiceEnabled();
//   if (!serviceEnabled) {
//     await Geolocator.requestPermission();
//     permission = await Geolocator.checkPermission();
//     if (permission == LocationPermission.denied) {
//       permission = await Geolocator.requestPermission();
//       if (permission == LocationPermission.denied) {
//         return Future.error('Location permissions are denied');
//       }
//     }
//
//     if (permission == LocationPermission.deniedForever) {
//       return Future.error(
//           'Location permissions are permanently denied, we cannot request permissions.');
//     }
//     return await Geolocator.getCurrentPosition();
//   }
//
//   permission = await Geolocator.checkPermission();
//   if (permission == LocationPermission.denied) {
//     permission = await Geolocator.requestPermission();
//     if (permission == LocationPermission.denied) {
//       return Future.error('Location permissions are denied');
//     }
//   }
//
//   if (permission == LocationPermission.deniedForever) {
//     return Future.error(
//         'Location permissions are permanently denied, we cannot request permissions.');
//   }
//   return await Geolocator.getCurrentPosition();
// }

//////////////////////////////////////////////////////

//show notification with image
// void showNotificationWithImage() {
//   LocalNotificationService.stylishNotification().then((value) {
//     emit(ShowNotificationState());
//     // showToast(msg: 'show notification', toastStates: ToastStates.WARNING);
//   }).catchError((error) {
//     print(error.toString());
//   });
// }
 //////////////////////////
// readJsonFile().then(
//   (value) {
//     showToast(
//       msg: 'you has offline data',
//       toastStates: ToastStates.WARNING,
//     );
//     if (value!.isNotEmpty) {
//       emit(GetUserOfflineDataLoadingState());
//       value.forEach(
//         (element) {
//           offlineData!.add(element);
//           print('element lat is ${element['latitude']}');
//         },
//       );
//       emit(GetUserOfflineDataSuccessState());
//     } else {
//       offlineData = [];
//       emit(GetUserOfflineDataErrorState());
//     }
//   },
// ).catchError((error) {
//   print(error);
//   emit(GetUserOfflineDataErrorState());
// });
 ////////////////////////////
// readJsonFile().then(
//   (offlineLocations) {
//     print('file json is $offlineLocations');
//     print(
//         'file json latitude is ${offlineLocations![0]['latitude']}');
//     if (offlineLocations.isNotEmpty) {
//       offlineLocations.forEach(
//         (element) {
//           print('latitude: ${element['latitude']}');
//           print('longitude: ${element['longitude']}');
//           sendUserLocationToServer(
//             latitude: element['latitude'],
//             longitude: element['longitude'],
//           );
//         },
//       );
//     }
//   },
// ).then((value5) {
//   showToast(
//       msg: 'finish send offline locations',
//       toastStates: ToastStates.WARNING);

////////////////////////////////////////////


// } else if (hasInternet == false) {
//   Timer.periodic(
//     const Duration(seconds: 5),
//     (timer) {
//       determinePositionWithLocation().then(
//         (value) {
//           internetListener().then((value2) {
//             if (hasInternet == true) {
//               sendUserLocationToServer(
//                 latitude: value.latitude,
//                 longitude: value.longitude,
//               );
//             } else if (hasInternet == false) {
//               showToast(
//                 msg: 'no internet connection',
//                 toastStates: ToastStates.ERROR,
//               );
//               print('lat is ${value.latitude}');
//               print('long is ${value.longitude}');
//             }
//           });
//         },
//       );
//     },
//   );
// }

////////////////////////////////////


// bool internetChecker() {
//   InternetConnectionChecker().hasConnection.then((value) {
//     hasInternet = value;
//     emit(InternetConnectionCheckerState());
//
//   }).catchError(
//     (error) {
//       print(error.toString());
//     },
//   );
//   return hasInternet;
// }

////////////////////////////////////

// if (defaultTargetPlatform == TargetPlatform.android) {
//   AndroidGoogleMapsFlutter.useAndroidViewSurface = true;
// }

/////////////////////////////////

// Timer(
//   const Duration(seconds: 3),
//   () => Navigator.pushReplacement(
//     context,
//     MaterialPageRoute(
//       builder: (context) =>  LoginScreen(),
//     ),
//   ),
// );

///////////////////////////////////////



// if (hasInternet = false) {
//   return;
// }
// var offline = await readJsonFile();
// if (offline!.isNotEmpty) {
//   if (hasInternet = true) {
//     showToast(
//       msg: 'you have offline data',
//       toastStates: ToastStates.WARNING,
//     );
//     offline.forEach(
//       (element) {
//         sendUserLocationToServer(
//           latitude: element['latitude'],
//           longitude: element['longitude'],
//           dateTime: element['time'],
//           stopPoint: 1,
//         );
//       },
//     );
//     localJsonFile.then(
//       (value) {
//         value.delete();
//         emit(ClearUserOfflineDataAfterSendingItToServerState());
//       },
//     );
//   }
// }

///////////////////////////////////////////////

// if (permissionGranted == PermissionStatus.denied) {
//   permissionGranted = await location.requestPermission();
//   if (permissionGranted == PermissionStatus.grantedLimited) {
//     return await Location().getLocation();
//   }
//   if (permissionGranted != PermissionStatus.granted) {
//     Future.error('error');
//   }
// }

///////////////////////////////////////////////

// final response = await http.get(Uri.parse(
//     'https://xtracker.me/${CacheHelper.getData(key: 'user_image')}'));
// final imageName = path.basename(
//     'https://xtracker.me/${CacheHelper.getData(key: 'user_image')}');
// final appDir = await pathProvider.getApplicationDocumentsDirectory();
// final localPath = path.join(appDir.path, imageName);
// final imageFile = File(localPath);
// await imageFile.writeAsBytes(response.bodyBytes);
// return imageFile;