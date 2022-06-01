import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:voice_to_text_chat/models/user.dart';
import 'package:voice_to_text_chat/views/splash_page.dart';

class AppStateController extends GetxController {

  RxList<CupertinoPage> pageStack = [const CupertinoPage(child: SplashPage(), key: ValueKey('splash'))].obs;

  FCUser? user;

  RxBool isScreenSizeInsufficient = false.obs;

  changePageStack(List<CupertinoPage> newStack) {
   pageStack.value = [...pageStack];
  }

}