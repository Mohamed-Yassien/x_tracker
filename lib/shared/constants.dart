import 'package:flutter/material.dart';
import 'package:x_tracker_map/network/local/cache_helper.dart';

Color defaultColor = Colors.deepOrange;

String? deviceId = CacheHelper.getData(key: 'deviceId') ?? '';

String? deviceToken = CacheHelper.getData(key: 'deviceToken') ?? '';

String? userId = CacheHelper.getData(key: 'user_id') ?? '';

String? userName = CacheHelper.getData(key: 'user_name') ?? '';

bool? loginBefore =  CacheHelper.getData(key: 'login') ?? false;


