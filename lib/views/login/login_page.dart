import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:voice_to_text_chat/api/firestore_api_collection.dart';
import 'package:voice_to_text_chat/controllers/app_state_controller.dart';
import 'package:voice_to_text_chat/models/api_response.dart';
import 'package:voice_to_text_chat/views/home/home_page.dart';
import 'package:voice_to_text_chat/controllers/login_state_controller.dart';

import '../../models/user.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    Future.delayed(const Duration(seconds: 3)).then((_) {
      Get.put(LoginStateController()).currentState.value = LoginStateEnum.SPLASH_START;
    });

    return Material(
      child: GetX<LoginStateController>(
        init: Get.put(LoginStateController()),
        builder: (controller) {
          return Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            color: NeumorphicTheme.baseColor(context),
            child: Stack(
              children: [
                Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const FlutterLogo(size: 120),
                          const SizedBox(width: 30),
                          Text('Flutter Chat', style: Theme.of(context).textTheme.displayLarge)
                        ],
                      ),
                      AnimatedContainer(
                        onEnd: () {
                          controller.currentState.value = LoginStateEnum.PHONE;
                        },
                        duration: const Duration(milliseconds: 300),
                        height: controller.currentState.value == LoginStateEnum.SPLASH ? 0 : 500,
                      )
                    ],
                  ),
                ),
                Center(
                  child: AnimatedOpacity(
                    duration: const Duration(milliseconds: 300),
                    opacity: controller.currentState.value == LoginStateEnum.PHONE ? 1 : 0,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        NeumorphicButton(
                          style: const NeumorphicStyle(boxShape: NeumorphicBoxShape.stadium()),
                          onPressed: () async {
                              loginWithGoogle();
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 7.5),
                            child: Row(
                              children: [
                                Image.asset('assets/google.png', height: 25, width: 25),
                                const SizedBox(width: 20),
                                Text('Connect with Google', style: Theme.of(context).textTheme.titleMedium),
                              ],
                              mainAxisSize: MainAxisSize.min,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          );
        }
      ),
    );
  }

  loginWithGoogle() async {

    GoogleAuthProvider googleProvider = GoogleAuthProvider();
    googleProvider.addScope('https://www.googleapis.com/auth/contacts.readonly');
    googleProvider.setCustomParameters({
      'login_hint': 'user@example.com'
    });
    UserCredential cred = await FirebaseAuth.instance.signInWithPopup(googleProvider);

    if(cred.user != null) {

      print('Info : ${cred.user!.photoURL!}');

      SharedPreferences pref = await SharedPreferences.getInstance();
      await pref.setString('loginType', 'google');
      await pref.setString('googleId', cred.user!.uid);

      APIResponse<FCUser?> getGoogleUserResponse = await FirestoreAPICollection().getGoogleUser(googleId: cred.user!.uid);

      if(getGoogleUserResponse.data == null) {
        APIResponse<FCUser?> createUserResponse = await FirestoreAPICollection().createUser(name: cred.user!.displayName ?? 'User ${Random.secure().nextDouble().toString()}', loginType: 'google', googleId: cred.user!.uid, imageUrl: cred.user!.photoURL!);
        if(createUserResponse.error) {
          print('Error occurred while creating user : ${createUserResponse.reason}');
          return ;
        }
        Get.put(AppStateController()).user = createUserResponse.data!;
      }
      else {
        Get.put(AppStateController()).user = getGoogleUserResponse.data!;
      }

      Get.put(AppStateController()).pageStack.value = [const CupertinoPage(child: HomePage(), key: ValueKey('home'))];

    }
    else {
      print('Signin popup flow error');
    }

  }


  postLoginFlow(UserCredential? cred) async {



  }

}
