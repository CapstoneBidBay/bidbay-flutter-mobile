import 'dart:convert';
import 'package:bidbay_mobile/common/values.dart';
import 'package:bidbay_mobile/models/user.dart';
import 'package:http/http.dart' as http;

class UserService {
  final String apiUrl;
  final String jwtSecret;

  UserService({required this.apiUrl, required this.jwtSecret});
  Future<bool> register(String email, String password, String confirmPassword, String fullname, String phoneNumber) async {
    final response = await http.post(
      Uri.parse('$apiUrl/register'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body:jsonEncode(<String, String> {
        'email': email,
        'password': password,
        'confirmPassword': confirmPassword,
        'fullName': fullname,
        'phone': phoneNumber,
      }
      ),
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception('Failed to sign in');
    }
  }
  Future<void> signIn(String email, String password) async {
    // print("check in function");
    // print('$apiUrl/public/auth/login');
    final response = await http.post(
      Uri.parse('$apiUrl/public/auth/login'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body:jsonEncode(<String, String> {
        'phoneNum': email,
        'password': password,
      }
      ),
    );
    if (response.statusCode == 202) {
        final data = await json.decode(response.body);
        //final storage = FlutterSecureStorage();
        //await storage.write(key: JWT_STORAGE_KEY, value: data['token'].toString());
        //await storage.write(key: IS_CONFIRM_STORAGE_KEY, value: data['isConfirm'].toString());
        JWT_TOKEN_VALUE = data['data']['accessToken'].toString();
        REFRESH_TOKEN = data['data']['refreshToken'].toString();
        IS_CONFIRM_VALUE = data['data']['isConfirm'].toString();
        USER_ID = data['data']['userId'].toString();
    } else {
      throw Exception('Failed to sign in');
    }
  }

  Future<User> getUser(String token) async {
    final response = await http.get(
      Uri.parse('$apiUrl/user'),
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      return User.fromJson(json);
    } else {
      throw Exception('Failed to get user');
    }
  }

  Future<void> resendOtp(String? jwtToken) async {
    final response = await http.get(
      Uri.parse('$apiUrl/users/register/otp/resend'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'authorization': 'Bearer $jwtToken',
      },
    );
    if (response.statusCode == 200) {
    } else {
      throw Exception('Failed to resend');
    }
  }
  Future<bool> verifyOtp(String otp, String? jwtToken) async {
    final response = await http.post(
      Uri.parse('$apiUrl/users/register/otp/verify'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'authorization': 'Bearer $jwtToken',
      },
      body:jsonEncode(<String, String> {
        'otpCode': otp,
      }
      ),
    );
    // print(response.statusCode);
    // print(response.body);
    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception('Failed to verify');
    }
  }
  Future<void> logout(String? token) async {
    final response = await http.post(
      Uri.parse('$apiUrl/auth/logout'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'authorization': 'Bearer $token',
        'refreshToken': '$REFRESH_TOKEN'
      },
      );
    if (response.statusCode == 202) {
      return;
    } else {
      throw Exception('Failed to verify');
    }
  }
}
