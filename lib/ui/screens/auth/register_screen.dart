import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kiloin/ui/screens/wrapper.dart';

import '../../widgets/action_button.dart';
import '../../widgets/input_field.dart';
import '../../widgets/loading_bar.dart';
import '../../widgets/social_button.dart';
import '../../widgets/validation_bar.dart';
import '../../../models/auth.dart';
import '../../../models/response_handler.dart';
import '../../../services/auth_services.dart';
import '../../../services/social_services.dart';
import '../../../shared/color.dart';
import '../../../shared/font.dart';
import '../../../shared/size.dart';
import '../../../ui/screens/auth/login_screen.dart';
import '../../../utils/firebase_exception_util.dart';

class RegisterScreen extends StatefulWidget {
  static String routeName = "/register_screen";

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController rePasswordController = TextEditingController();

  bool isLogining = false;
  bool isGooglePressed = false;
  bool isFacebookPressed = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: 1.sw,
          color: whitePure,
          padding: EdgeInsets.only(
            top: 70.r + ScreenUtil().statusBarHeight,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              /// WIDGET: APP LOGO
              Padding(
                padding: EdgeInsets.only(
                  bottom: 70.r,
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
                      ClipRRect(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(4.r),
                          topRight: Radius.circular(4.r),
                        ),
                        child: InputField(
                          controller: emailController,
                          hintText: "Email Address",
                          keyboardType: TextInputType.emailAddress,
                          borderRadius: 0,
                        ),
                      ),
                      SizedBox(
                        height: 1.h,
                      ),

                      /// WIDGET: CUSTOM TEXT FIELD
                      InputField(
                        controller: phoneController,
                        hintText: "Nomor HP",
                        keyboardType: TextInputType.phone,
                        borderRadius: 0,
                      ),
                      SizedBox(
                        height: 1.h,
                      ),

                      /// WIDGET: CUSTOM TEXT FIELD
                      InputField(
                        obscureText: true,
                        controller: passwordController,
                        hintText: "Password",
                        keyboardType: TextInputType.text,
                        borderRadius: 0,
                      ),
                      SizedBox(
                        height: 1.h,
                      ),

                      /// WIDGET: CUSTOM TEXT FIELD
                      ClipRRect(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(4.r),
                          bottomRight: Radius.circular(4.r),
                        ),
                        child: InputField(
                          obscureText: true,
                          controller: rePasswordController,
                          hintText: "Re-Password",
                          keyboardType: TextInputType.text,
                          borderRadius: 0,
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
                          text: "SIGN UP",
                          textColor: whitePure,
                          color: lightGreen,
                          onPressed: () {
                            setState(() {
                              isLogining = true;
                            });
                            onSubmitPressed(
                              context,
                              email: emailController.text,
                              phone: phoneController.text,
                              password: passwordController.text,
                              rePassword: rePasswordController.text,
                            );
                          },
                        ),
                      SizedBox(
                        height: 20.h,
                      ),

                      /// WIDGET: FORGOT PASSWORD LINK
                      Text(
                        "OR",
                        style: boldCalibriFont.copyWith(
                          fontSize: 14.sp,
                        ),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),

                      /// WIDGET: SOCIAL BUTTON
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          if (isFacebookPressed)
                            SizedBox(
                              width: 140.r,
                              child: Center(
                                child: LoadingBar(),
                              ),
                            )
                          else
                            SocialButton(
                              image: "assets/image/logo_facebook.png",
                              color: whitePure,
                              onPressed: () {
                                setState(() {
                                  isFacebookPressed = true;
                                });
                                onFacebookPressed(context);
                              },
                            ),
                          if (isGooglePressed)
                            SizedBox(
                              width: 140.r,
                              child: Center(
                                child: LoadingBar(),
                              ),
                            )
                          else
                            SocialButton(
                              image: "assets/image/logo_google.png",
                              color: whitePure,
                              onPressed: () {
                                setState(() {
                                  isGooglePressed = true;
                                });
                                onGooglePressed(context);
                              },
                            ),
                        ],
                      ),
                      SizedBox(
                        height: 24.h,
                      ),

                      /// WIDGET: LOGIN ACTION
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Already Have Account ? ",
                            style: regularCalibriFont.copyWith(
                              fontSize: 14.sp,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.pushReplacementNamed(
                                context,
                                LoginScreen.routeName,
                              );
                            },
                            child: Text(
                              "Login",
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

  /// Method will be execute when submit (sign up) button is pressed
  Future<void> onSubmitPressed(
    BuildContext context, {
    String email = "",
    String phone = "",
    String password = "",
    String rePassword = "",
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
    }
    // Check to ensure password and re-password isn't same
    else if (!(password == rePassword)) {
      setState(() {
        isLogining = false;
      });

      showValidationBar(
        context,
        message: "Konfirmasi Password Harus Sama",
      );
    } else {
      // Execute auth register service method
      ResponseHandler result = await AuthServices.register(
        Auth(
          email: email,
          phone: phone,
          password: password,
        ),
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

  /// Method will be execute when google button is pressed
  Future<void> onGooglePressed(BuildContext context) async {
    // Execute auth google service method
    ResponseHandler result = await SocialServices.signInGoogle();

    // Check to ensure success property is true
    if (result.success == true) {
      // Navigate to wrapper screen
      Navigator.pushReplacementNamed(
        context,
        Wrapper.routeName,
      );
    }
    // Stop loading bar and show validation
    else {
      setState(() {
        isGooglePressed = false;
      });

      showValidationBar(
        context,
        message: result.message ?? "",
      );
    }
  }

  /// Method will be execute when facebook button is pressed
  Future<void> onFacebookPressed(BuildContext context) async {
    // Execute auth facebook service method
    ResponseHandler result = await SocialServices.loginFacebook();

    // Check to ensure success property is true
    if (result.success == true) {
      // Navigate to wrapper screen
      Navigator.pushReplacementNamed(
        context,
        Wrapper.routeName,
      );
    }
    // Stop loading bar and show validation
    else {
      setState(() {
        isFacebookPressed = false;
      });

      showValidationBar(
        context,
        message: generateAuthMessage(result.message),
      );
    }
  }
}
