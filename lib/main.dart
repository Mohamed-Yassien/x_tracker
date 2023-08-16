import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rebirth/rebirth.dart';
import 'package:x_tracker_map/modules/splash_screen.dart';
import 'package:x_tracker_map/shared/themes.dart';
import 'cubit/bloc_observer.dart';
import 'network/local/cache_helper.dart';
import 'network/remote/dio_helper.dart';

main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.init();
  await Firebase.initializeApp();
  await CacheHelper.init();

  Bloc.observer = MyBlocObserver();
  runApp(
    WidgetRebirth(
      materialApp: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: lightTheme,
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}

//DE:8C:6A:25:23:16:7E:F2:20:DD:F2:65:01:65:04:16:FA:95:D1:3C
//AIzaSyDHthXKTy4ty7KM2MwxVobiuJ9El3jBasM
