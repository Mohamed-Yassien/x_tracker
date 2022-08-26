import 'package:flutter/material.dart';
import 'package:x_tracker_map/network/local/cache_helper.dart';

Color defaultColor = Colors.deepOrange;
String? deviceId = CacheHelper.getData(key: 'deviceId') ?? '';
String? deviceToken = CacheHelper.getData(key: 'deviceToken') ?? '';
bool? loginBefore = CacheHelper.getData(key: 'login') ?? false;
