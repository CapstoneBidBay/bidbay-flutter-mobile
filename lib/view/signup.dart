import 'package:bidbay_mobile/cubit/authentication_cubit.dart';
import 'package:bidbay_mobile/view/login.dart';
import 'package:bidbay_mobile/widgets/login_form.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../main.dart';

class SignupScreen extends StatelessWidget {
  static const routeName = '/signup';
  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<AuthenticationCubit>(context);
    Future<void> handleRegisterForm(String email, String password, String confirmPassword, String fullname, String phoneNumber) async {
      var isSignup = await cubit.register(email, password, confirmPassword, fullname, phoneNumber);
      if (isSignup) {
        Navigator.pushReplacementNamed(context, LoginScreen.routeName);
      }
    }
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        body: Container(
          decoration: BoxDecoration(
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
                decoration: BoxDecoration(
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
              Flex(
                mainAxisAlignment: MainAxisAlignment.center,
                direction: Axis.vertical,
                children: [
                  Container(
                    child: Text.rich(
                      TextSpan(
                        children: <TextSpan>[
                          TextSpan(
                              text: 'Đăng ký tài khoản Bidbay',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 24,
                                  color: Colors.white)),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(
                        child: SizedBox(
                          width: size.width * 0.9,
                          child: LoginForm(
                            buttonText: "Đăng ký",
                            isSignup: true,
                            onSubmit: (email, password, confirmPassword, fullName, phoneNumber) {
                              handleRegisterForm(email, password, confirmPassword, fullName, phoneNumber);
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
                        text: "Nếu bạn đã có tài khoản, ",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                            color: Colors.white),
                        children: <TextSpan>[
                          TextSpan(
                            text: 'đăng nhập ở đây',
                            style: TextStyle(
                              color: Color(0xFFFF7A00),
                              fontSize: 12.0,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Navigator.pushReplacementNamed(context, LoginScreen.routeName);
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
