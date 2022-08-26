import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:x_tracker_map/cubit/login_cubit/login_cubit.dart';
import 'package:x_tracker_map/cubit/login_cubit/login_states.dart';
import 'package:x_tracker_map/modules/home_screen.dart';
import 'package:x_tracker_map/shared/constants.dart';
import 'package:x_tracker_map/shared/methods.dart';
import 'package:x_tracker_map/shared/widgets/reusable_text_field.dart';
import 'package:x_tracker_map/shared/widgets/reusable_toast.dart';

class LoginScreen extends StatelessWidget {
  var phoneController = TextEditingController();
  var pinController = TextEditingController();

  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit()..enableBackGroundTrack(),
      child: BlocConsumer<LoginCubit, LoginStates>(
        listener: (context, state) async {
          if (state is LoginUserSuccessState) {
            if (state.loginModel.data == null) {
              showToast(
                msg: state.loginModel.message!,
                toastStates: ToastStates.ERROR,
              );
            } else {
              navigateToAndFinish(
                widget: HomeScreen(),
                context: context,
              );
              showToast(
                msg: state.loginModel.message!,
                toastStates: ToastStates.SUCCESS,
              );
            }
          }
        },
        builder: (context, state) {
          var cubit = LoginCubit.get(context);

          return Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 40,
                ),
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'xTracker',
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                              fontSize: 35,
                              color: defaultColor,
                            ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Image.asset(
                        'assets/images/logo icon.png',
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover,
                      ),
                      const SizedBox(
                        height: 55,
                      ),
                      ReusableTextField(
                        controller: phoneController,
                        textLabel: 'Phone Number',
                        validate: (String value) {
                          if (value.isEmpty) {
                            return 'phone must not be empty';
                          }
                          return null;
                        },
                        type: TextInputType.phone,
                        onChange: (String value) {},
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      ReusableTextField(
                        controller: pinController,
                        textLabel: 'PIN',
                        validate: (String value) {
                          if (value.isEmpty) {
                            return 'Pin must not be empty';
                          }
                          return null;
                        },
                        type: TextInputType.number,
                        onChange: (String value) {},
                        inRating: true,
                        isPassword: cubit.isPassword,
                        iconData: IconButton(
                          onPressed: () {
                            cubit.changePasswordVisibility();
                          },
                          icon: Icon(
                            cubit.iconData,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      state is LoginUserLoadingState
                          ? const Center(
                              child: CircularProgressIndicator(
                                strokeWidth: 7,
                              ),
                            )
                          : SizedBox(
                              width: double.infinity,
                              height: 50,
                              child: OutlinedButton(
                                onPressed: () {
                                  if (formKey.currentState!.validate()) {
                                    cubit.userLogin(
                                      phone: phoneController.text,
                                      pin: pinController.text,
                                    );
                                  }
                                },
                                child: const Text(
                                  'LOGIN',
                                  style: TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
