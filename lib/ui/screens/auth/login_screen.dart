import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:kiloin/ui/screens/wrapper.dart';
import 'package:kiloin/ui/widgets/social_button.dart';

import '../../widgets/action_button.dart';
import '../../widgets/input_field.dart';
import '../../widgets/loading_bar.dart';
import '../../../shared/color.dart';
import '../../../shared/font.dart';
import '../../../shared/size.dart';
import '../../../ui/screens/auth/register_screen.dart';

class LoginScreen extends StatefulWidget {
  static String routeName = "/login_screen";

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  FirebaseAuth auth = FirebaseAuth.instance;

  bool isLogining = false;
  bool isGooglePressed = false;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: lightGreen,
    ));

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

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
              Form(
                key: formKey,
                child: Container(
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
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Email tidak boleh kosong";
                            }
                          },
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
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Password tidak boleh kosong";
                            }
                          },
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
                              signInPressed();
                            },
                          ),
                        SizedBox(
                          height: 20.h,
                        ),

                        /// WIDGET: FORGOT PASSWORD LINK
                        // GestureDetector(
                        //   onTap: () {},
                        //   child: Text(
                        //     "Forgot Password ?",
                        //     style: boldCalibriFont.copyWith(
                        //       fontSize: 14.sp,
                        //     ),
                        //   ),
                        // ),
                        // SizedBox(
                        //   height: 24.h,
                        // ),
                        Text(
                          "OR\n LOGIN WITH",
                          textAlign: TextAlign.center,
                          style: boldCalibriFont.copyWith(
                            fontSize: 14.sp,
                          ),
                        ),
                        SizedBox(
                          height: 24.h,
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
                              googlePressed();
                              // onGooglePressed(context);
                            },
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
                                Navigator.pushNamed(
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
              ),
            ],
          ),
        ),
      ),
    );
  }

  void signInPressed() async {
    if (formKey.currentState!.validate()) {
      setState(() {
        isLogining = true;
      });
    }
    String email = emailController.text;
    String password = passwordController.text;
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text(
        "Trying to logging you in...",
      ),
      duration: Duration(
        milliseconds: 500,
      ),
    ));
    try {
      await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      Navigator.of(context).pushReplacementNamed(
        Wrapper.routeName,
      );
    } on FirebaseAuthException catch (e) {
      String errorMessage = e.message ?? "Terjadi kesalahan";
      final snackBar = SnackBar(
        content: Text(
          errorMessage,
        ),
        backgroundColor: redDanger,
      );
      ScaffoldMessenger.of(context).showSnackBar(
        snackBar,
      );
      setState(() {
        isLogining = false;
      });
    }
  }

  void googlePressed() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    await FirebaseAuth.instance.signInWithCredential(
      credential,
    );
    Navigator.of(context).pushReplacementNamed(
      Wrapper.routeName,
    );
  }

  /// Method will be execute when submit (sign in) button is pressed
  // Future<void> onSubmitPressed(
  //   BuildContext context, {
  //   required String email,
  //   required String password,
  // }) async {
  //   // Check to ensure email and password isn't empty
  //   if (!(email.trim() != "" && password.trim() != "")) {
  //     setState(() {
  //       isLogining = false;
  //     });

  //     showValidationBar(
  //       context,
  //       message: "Semua Field Harus Diisi",
  //     );
  //   } else {
  //     // Execute auth login service method
  //     ResponseHandler result = await AuthService.signIn(
  //       emailController.text,
  //       passwordController.text,
  //     );

  //     // Check to ensure user result is null
  //     if (result.user == null) {
  //       setState(() {
  //         isLogining = false;
  //       });

  //       showValidationBar(
  //         context,
  //         message: generateAuthMessage(result.message),
  //       );
  //     } else {
  //       // Navigate to wrapper screen
  //       Navigator.pushReplacementNamed(
  //         context,
  //         Wrapper.routeName,
  //       );
  //     }
  //   }
  // }
}
