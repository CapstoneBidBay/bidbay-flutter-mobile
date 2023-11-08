import 'package:flutter/material.dart';

//Style
const headerStyle = TextStyle(fontSize: 32, fontWeight: FontWeight.bold);
const cityTitleStyle = TextStyle(fontSize: 40, color: Colors.white);

const titleStyle = TextStyle(fontSize: 20, fontWeight: FontWeight.bold);
const subtitleStyle = TextStyle(fontSize: 16, fontWeight: FontWeight.w300, color: Colors.black38);
//Colors

///Shape
final roundedRect16 = RoundedRectangleBorder(
  borderRadius: BorderRadiusDirectional.circular(16),
  side: const BorderSide(width: 0.1, color: Colors.black),
);
final roundedRect12 = RoundedRectangleBorder(
  borderRadius: BorderRadiusDirectional.circular(12),
);

// Dropdown type
// ignore: constant_identifier_names
const String DISTRICT = 'DISTRICT';
// ignore: constant_identifier_names
const String PROVINCE = 'PROVINCE';
// ignore: constant_identifier_names
const String SUB_YARD = 'SUB_YARD';

const jwtSecret = 'booking_mobile_app';

const String apiServer = String.fromEnvironment(
    'SERVER',
    defaultValue: 'https://bidbaybe.site/api/v1',
);

const JWT_STORAGE_KEY = 'jwt';
const IS_CONFIRM_STORAGE_KEY = 'isConfirm';

String IS_CONFIRM_VALUE = 'false';
String JWT_TOKEN_VALUE = '';
String REFRESH_TOKEN = '';
String USER_ID = '';

const AUTO_PLACE_BID = "Auto Place Bid";
const MANUAL_PLACE_BID = "Manual Place Bid";

const NO_IMAGE_URL = "https://firebasestorage.googleapis.com/v0/b/bidbay-project.appspot.com/o/No-Image-Placeholder.svg.png?alt=media";