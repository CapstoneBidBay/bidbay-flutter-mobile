import 'package:bidbay_mobile/common/values.dart';
import 'package:bidbay_mobile/cubit/authentication_cubit.dart';
import 'package:bidbay_mobile/view/signup.dart';
import 'package:bidbay_mobile/view/verify_otp.dart';
import 'package:bidbay_mobile/widgets/login_form.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../main.dart';

class LoginScreen extends StatelessWidget {
  static const routeName = '/login';
  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<AuthenticationCubit>(context);
    Future<void> handleLoginFormSubmit(String email, String password) async {
      print("checkin handleLoginForm");
      await cubit.login(email, password);
      //final storage = FlutterSecureStorage();
      // var isConfirm = await storage.read(key: IS_CONFIRM_STORAGE_KEY);
      // var token = await storage.read(key: JWT_STORAGE_KEY);
      if (IS_CONFIRM_VALUE == 'true') {
        Navigator.pushReplacementNamed(context, MyHomePage.routeName);
      } else {
        await cubit.resendOtp(JWT_TOKEN_VALUE);
        Navigator.pushReplacementNamed(context, VerifyOtpPage.routeName);
      }
    }
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        body: Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(
              'assets/background.jpg'),
          fit: BoxFit.cover,
        ),
      ),
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xFFFF7A00).withOpacity(0.2),
                  Color(0xFF1F0F00).withOpacity(0.2),
                ],
              ),
            ),
          ),
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.transparent,
                  Colors.black,
                ],
              ),
            ),
          ),
          const SizedBox(),
          Flex(
            mainAxisAlignment: MainAxisAlignment.center,
            direction: Axis.vertical,
            children: [
              const Text.rich(
                TextSpan(
                  children: <TextSpan>[
                    TextSpan(
                        text: 'Xin chào!',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 30,
                            color: Colors.white)),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 10),
                child: const Text.rich(
                  TextSpan(
                    children: <TextSpan>[
                      TextSpan(
                          text: 'Chào mừng đến với nền tảng đấu giá thời trang',
                          style: TextStyle(
                              fontWeight: FontWeight.normal,
                              fontSize: 16,
                              color: Colors.white)),
                    ],
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 60, bottom: 40),
                child: const Center(
                  child: Text.rich(
                    TextSpan(
                      children: <TextSpan>[
                        TextSpan(
                            text: 'Bidbay',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 24,
                                color: Colors.white)),
                      ],
                    ),
                  ),
                ),
              ),
              Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: SizedBox(
                      width: size.width * 0.9,
                      child: LoginForm(
                        buttonText: "Đăng nhập",
                        onSubmit: (email, password, value, value2, value3) {
                          handleLoginFormSubmit(email, password);
                        },
                      ),
                    ),
                  )
                ],
              ),
              Container(
                padding: EdgeInsets.only(top: 20),
                child: Text.rich(
                  TextSpan(
                    text: "Nếu bạn chưa có tài khoản, ",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                        color: Colors.white),
                    children: <TextSpan>[
                      TextSpan(
                        text: 'đăng ký ở đây',
                        style: TextStyle(
                          color: Color(0xFFFF7A00),
                          fontSize: 12.0,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.pushReplacementNamed(context, SignupScreen.routeName);
                          },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          )
          // Add other widgets here, such as text or buttons
        ],
      ),
    ));
  }
}
