import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kiloin/ui/screens/wrapper.dart';

import '../../widgets/action_button.dart';
import '../../widgets/input_field.dart';
import '../../widgets/loading_bar.dart';
import '../../widgets/validation_bar.dart';
import '../../../models/auth.dart';
import '../../../models/response_handler.dart';
import '../../../services/auth_services.dart';
import '../../../shared/color.dart';
import '../../../shared/font.dart';
import '../../../shared/size.dart';
import '../../../ui/screens/auth/register_screen.dart';
import '../../../utils/firebase_exception_util.dart';

class LoginScreen extends StatefulWidget {
  static String routeName = "/login_screen";

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool isLogining = false;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: lightGreen,
    ));

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: 1.sw,
          color: whitePure,
          padding: EdgeInsets.only(
            top: 94.r + ScreenUtil().statusBarHeight,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              /// WIDGET: APP LOGO
              Padding(
                padding: EdgeInsets.only(
                  bottom: 90.r,
                ),
                child: Image(
                  width: 125.r,
                  height: 105.r,
                  fit: BoxFit.cover,
                  image: AssetImage("assets/image/splash.png"),
                ),
              ),

              /// SECTION: LOGIN FORM
              Container(
                width: 1.sw,
                decoration: BoxDecoration(
                  color: darkGreen,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(32.r),
                    topRight: Radius.circular(32.r),
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: defaultMargin,
                    vertical: 36.r,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      /// WIDGET: CUSTOM TEXT FIELD
                      InputField(
                        controller: emailController,
                        hintText: "Email Address",
                        keyboardType: TextInputType.emailAddress,
                        prefixIcon: Theme(
                          data: Theme.of(context).copyWith(
                            primaryColor: grayPure,
                          ),
                          child: Padding(
                            padding: EdgeInsets.only(
                              right: 16.r,
                              left: 20.r,
                              top: 12.r,
                              bottom: 12.r,
                            ),
                            child: Icon(
                              Icons.account_circle,
                              size: 28.r,
                              color: grayPure,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 16.h,
                      ),

                      /// WIDGET: CUSTOM TEXT FIELD
                      InputField(
                        obscureText: true,
                        controller: passwordController,
                        hintText: "Password",
                        keyboardType: TextInputType.text,
                        prefixIcon: Theme(
                          data: Theme.of(context).copyWith(
                            primaryColor: grayPure,
                          ),
                          child: Padding(
                            padding: EdgeInsets.only(
                              right: 16.r,
                              left: 20.r,
                              top: 12.r,
                              bottom: 12.r,
                            ),
                            child: Icon(
                              Icons.lock,
                              size: 28.sp,
                              color: grayPure,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 24.h,
                      ),

                      /// WIDGET: CUSTOM MATERIAL BUTTON
                      if (isLogining)
                        LoadingBar()
                      else
                        ActionButton(
                          text: "SIGN IN",
                          textColor: whitePure,
                          color: lightGreen,
                          onPressed: () {
                            setState(() {
                              isLogining = true;
                            });
                            onSubmitPressed(
                              context,
                              email: emailController.text,
                              password: passwordController.text,
                            );
                          },
                        ),
                      SizedBox(
                        height: 20.h,
                      ),

                      /// WIDGET: FORGOT PASSWORD LINK
                      GestureDetector(
                        onTap: () {},
                        child: Text(
                          "Forgot Password ?",
                          style: boldCalibriFont.copyWith(
                            fontSize: 14.sp,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 24.h,
                      ),

                      /// WIDGET: HORIZONTAL DIVIDER
                      Container(
                        width: 1.sw,
                        height: 1.r,
                        color: grayPure.withOpacity(0.5),
                      ),
                      SizedBox(
                        height: 24.h,
                      ),

                      /// WIDGET: REGISTER ACTION
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Don't Have Account ? ",
                            style: regularCalibriFont.copyWith(
                              fontSize: 14.sp,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.pushReplacementNamed(
                                context,
                                RegisterScreen.routeName,
                              );
                            },
                            child: Text(
                              "Register",
                              style: regularCalibriFont.copyWith(
                                fontSize: 14.sp,
                                color: lightGreen,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Method will be execute when submit (sign in) button is pressed
  Future<void> onSubmitPressed(
    BuildContext context, {
    required String email,
    required String password,
  }) async {
    // Check to ensure email and password isn't empty
    if (!(email.trim() != "" && password.trim() != "")) {
      setState(() {
        isLogining = false;
      });

      showValidationBar(
        context,
        message: "Semua Field Harus Diisi",
      );
    } else {
      // Execute auth login service method
      ResponseHandler result = await AuthServices.login(
        Auth(email: email, password: password),
      );

      // Check to ensure user result is null
      if (result.user == null) {
        setState(() {
          isLogining = false;
        });

        showValidationBar(
          context,
          message: generateAuthMessage(result.message),
        );
      } else {
        // Navigate to wrapper screen
        Navigator.pushReplacementNamed(
          context,
          Wrapper.routeName,
        );
      }
    }
  }
}
