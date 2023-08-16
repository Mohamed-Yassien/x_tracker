import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:x_tracker_map/cubit/home_cubit/home_cubit.dart';
import 'package:x_tracker_map/cubit/home_cubit/home_states.dart';
import 'package:x_tracker_map/modules/login_screen.dart';
import 'package:x_tracker_map/shared/methods.dart';
import 'package:x_tracker_map/shared/widgets/reusable_toast.dart';

import '../network/local/cache_helper.dart';
import '../shared/constants.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit()
        ..getInitialCameraPosition()
        ..initializedNotification()
        ..saveUserImageOffline()
        ..enableTrack(context),
      child: BlocConsumer<HomeCubit, HomeStates>(
        listener: (context, state) async {
          if (state is UserLogOutSuccessState) {
            navigateToAndFinish(
              widget: LoginScreen(),
              context: context,
            );
            showToast(
              msg: state.logOutModel.message!,
              toastStates: ToastStates.SUCCESS,
            );
          }
        },
        builder: (context, state) {
          var cubit = HomeCubit.get(context);

          return Scaffold(
            appBar: AppBar(
              systemOverlayStyle: const SystemUiOverlayStyle(
                statusBarColor: Colors.deepOrangeAccent,
                statusBarIconBrightness: Brightness.light,
              ),
              backgroundColor: defaultColor,
              title: Text(
                'Home',
                style: Theme.of(context).textTheme.bodyText1!.copyWith(
                      color: Colors.white,
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              actions: [
                state is UserLogOutLoadingState
                    ? const Center(
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 7,
                        ),
                      )
                    : IconButton(
                        onPressed: () {
                          cubit.userLogOut();
                        },
                        icon: const Icon(
                          Icons.logout,
                          size: 25,
                          color: Colors.white,
                        ),
                      ),
                const SizedBox(
                  width: 10,
                ),
              ],
            ),
            body: cubit.cameraPosition == null
                ? const Center(
                    child: CircularProgressIndicator(
                      strokeWidth: 7,
                    ),
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 25, bottom: 25, left: 20, right: 15),
                        child: Row(
                          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              height: 100,
                              width: 100,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: cubit.hasInternet == true
                                      ? NetworkImage(
                                          'https://xtracker.me/${CacheHelper.getData(key: 'user_image')}',
                                        )
                                      : FileImage(
                                          cubit.userImageOffline ?? File(''),
                                        ) as ImageProvider,
                                  fit: BoxFit.cover,
                                ),
                                shape: BoxShape.circle,
                                color: Colors.grey[200],
                              ),
                            ),
                            const SizedBox(
                              width: 35,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                RichText(
                                  text: TextSpan(
                                    text: 'Name : ',
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                    children: <TextSpan>[
                                      TextSpan(
                                        text: CacheHelper.getData(
                                                key: 'user_name') ??
                                            '',
                                        style: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                RichText(
                                  text: TextSpan(
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                    text: 'Status : ',
                                    children: <TextSpan>[
                                      TextSpan(
                                        text: cubit.statusText,
                                        style: TextStyle(
                                          fontWeight: FontWeight.normal,
                                          fontSize: 14,
                                          color: cubit.statusTextColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                        ),
                        child: SizedBox(
                          height: 50,
                          width: double.infinity,
                          child: OutlinedButton(
                            onPressed: () {
                              showDialog(
                                barrierDismissible: false,
                                context: context,
                                builder: (context) => AlertDialog(
                                  title: const Text(
                                    'xTracker',
                                    style: TextStyle(
                                      color: Colors.deepOrange,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  content: Text(
                                    cubit.alertContent,
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        cubit.changeUserStatus();
                                        Navigator.pop(context);
                                      },
                                      child: const Text('confirm'),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: const Text('cancel'),
                                    ),
                                  ],
                                ),
                              );
                            },
                            child: Text(
                              cubit.buttonText,
                              style:
                                  Theme.of(context).textTheme.bodyText1!.copyWith(
                                        fontSize: 30,
                                        color: defaultColor,
                                        fontWeight: FontWeight.bold,
                                      ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Expanded(
                        child: GoogleMap(
                          mapType: MapType.normal,
                          initialCameraPosition:
                              cubit.cameraPosition ?? cubit.initialCameraPosition,
                          onMapCreated: (GoogleMapController controller) {
                            cubit.mController.complete(controller);
                          },
                          markers: cubit.markers,
                        ),
                      ),
                    ],
                  ),
            floatingActionButton: FloatingActionButton(
              onPressed: () async {
                cubit.locationData = await cubit.determinePositionWithLocation();
                cubit.updateMapPosition(cubit.locationData!);
                var list = await cubit.readJsonFile();
                print('list is $list');
              },
              child: const Icon(
                Icons.location_on,
                size: 30,
              ),
            ),
          );
        },
      ),
    );
  }
}
