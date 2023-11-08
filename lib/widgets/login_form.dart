import 'package:flutter/material.dart';

class LoginForm extends StatefulWidget {
  final void Function(String, String, String, String, String) onSubmit;
  final String buttonText;
  final bool isSignup;
  const LoginForm({super.key, required this.buttonText, required this.onSubmit, this.isSignup = false});

  @override
  // ignore: library_private_types_in_public_api
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  String _phone = '';
  String _password = '';
  String _confirmPassword = '';

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            cursorColor: Colors.white,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Mời bạn nhập số điện thoại';
              }
              return null;
            },
            onChanged: (value) => setState(() {
              _phone = value.toString();
            }),
            decoration: InputDecoration(
              floatingLabelBehavior: FloatingLabelBehavior.never,
              filled: true,
              labelText: 'Số điện thoại',
              hintStyle: const TextStyle(color: Colors.white),
              border: const OutlineInputBorder(),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: const BorderSide(
                  color: Colors.transparent,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: const BorderSide(
                  color: Colors.transparent,
                ),
              ),
              fillColor: Colors.white.withOpacity(0.5),
              prefixIcon: const Icon(
                  Icons.phone,
                  color: Colors.white,
                ),
            ),
          ),
          const SizedBox(height: 8),
          TextFormField(
            obscureText: true,
            cursorColor: Colors.white,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Mời bạn nhập mật khẩu';
              } else if (value.length < 8) {
                return 'Mật khẩu phải lớn hơn 8 kí tự';
              }
              return null;
            },
            onChanged: (value) => setState(() {
              _password = value.toString();
            }),
            decoration: InputDecoration(
              floatingLabelBehavior: FloatingLabelBehavior.never,
              filled: true,
              labelText: 'Mật khẩu',
              hintStyle: const TextStyle(color: Colors.white),
              border: const OutlineInputBorder(),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: const BorderSide(
                  color: Colors.transparent,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: const BorderSide(
                  color: Colors.transparent,
                ),
              ),
              fillColor: Colors.white.withOpacity(0.5),
              prefixIcon: const Icon(
                  Icons.lock_outline_rounded,
                  color: Colors.white,
                ),
            ),
          ),
          const SizedBox(height: 8),
          if (widget.isSignup == true)
             Column(
              children: [
                TextFormField(
                  obscureText: true,
                  cursorColor: Colors.white,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Mời bạn nhập mật khẩu';
                    } else if (value.length < 8) {
                      return 'Mật khẩu phải lớn hơn 8 kí tự';
                    } else if (value != _password) {
                      return 'Mật khẩu không khớp';
                    }
                    return null;
                  },
                  onChanged: (value) => setState(() {
                    _confirmPassword = value.toString();
                  }),
                  decoration: InputDecoration(
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    filled: true,
                    labelText: 'Nhập lại mật khẩu',
                    hintStyle: const TextStyle(color: Colors.white),
                    border: const OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: const BorderSide(
                        color: Colors.transparent,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: const BorderSide(
                        color: Colors.transparent,
                      ),
                    ),
                    fillColor: Colors.white.withOpacity(0.5),
                    prefixIcon: const Padding(
                      padding: EdgeInsets.only(top: 8), // add padding to adjust icon
                      child: Icon(
                        Icons.lock_outline_rounded,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
              ],
            ),
          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              onPressed: () {
                if(widget.isSignup) {
                  widget.onSubmit(_phone, _password, _confirmPassword, '', '');
                } else {
                  widget.onSubmit(_phone, _password, '', '', '');
                }
              },
              style: ButtonStyle(
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                backgroundColor: MaterialStateProperty.resolveWith<Color>(
                    (Set<MaterialState> states) {
                  if (states.contains(MaterialState.pressed)) {
                    return Colors.orangeAccent;
                  }
                  return Colors.orange;
                }),
              ),
              child: Text(widget.buttonText),
            ),
          )
        ],
      ),
    );
  }
}

bool isValidEmail(String email) {
  // Use RegExp to validate email address format
  final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
  return emailRegex.hasMatch(email);
}
