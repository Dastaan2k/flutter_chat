import 'package:get/get.dart';

class LoginStateController extends GetxController {

  Rx<LoginStateEnum> currentState = LoginStateEnum.SPLASH.obs;

}


enum LoginStateEnum {
  SPLASH,
  SPLASH_START,
  PHONE,
  OTP
}