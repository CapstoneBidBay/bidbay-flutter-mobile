import 'package:bidbay_mobile/common/values.dart';
import 'package:bidbay_mobile/cubit/authentication_state.dart';
import 'package:bidbay_mobile/service/user_service.dart';
import 'package:bidbay_mobile/utils/toast_message.dart';
import 'package:bloc/bloc.dart';


class AuthenticationCubit extends Cubit<AuthenticationState> {

  final UserService userService;

  AuthenticationCubit({required this.userService}) : super(Unauthenticated());

  Future<void> login(String email, String password) async {
    try {
      // call the user service to check the user credentials
      //final storage = FlutterSecureStorage();
      await userService.signIn(email, password);
      //var isConfirm = await storage.read(key: IS_CONFIRM_STORAGE_KEY);
      var isConfirm = IS_CONFIRM_VALUE; 
      emit(Authenticated(isConfirm: isConfirm == 'true'));
    } catch (e) {
      ToastMessageHelper.toastErrorShortMessage("Sai tên tài khoản, mật khẩu hoặc tài khoản đã bị ban");
      emit(LoginFailed(error: e.toString()));
      rethrow;
    }
  }

  Future<bool> register(String email, String password, String confirmPassword, String fullname, String phoneNumber) async {
    try {
      // call the user service to check the user credentials
      return await userService.register(email, password, confirmPassword, fullname, phoneNumber);
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> verifyOtp(String otp, String? jwtToken) async {
    try {
      return await userService.verifyOtp(otp, jwtToken);
    } catch(e) {
      rethrow;
    }
  }

  Future<void> resendOtp(String? jwtToken) async {
    await userService.resendOtp(jwtToken);
  }

  Future<void> logout(String? token) async {
    try {
      return await userService.logout(token);
    }
    catch (e) {
      rethrow;
    }
  }
}
