import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ToastMessageHelper {
  static void toastSuccessShortMessage(String message){
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: const Color.fromARGB(255, 17, 144, 74),
      textColor: const Color.fromARGB(255, 255, 255, 255),
      fontSize: 16.0
    );
  }
  static void toastErrorShortMessage(String message){
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Color.fromARGB(255, 144, 17, 17),
      textColor: const Color.fromARGB(255, 255, 255, 255),
      fontSize: 16.0
    );
  }
}