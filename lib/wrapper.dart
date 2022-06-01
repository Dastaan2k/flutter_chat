import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:voice_to_text_chat/api/firestore_api_collection.dart';
import 'package:voice_to_text_chat/controllers/app_state_controller.dart';
import 'package:voice_to_text_chat/models/api_response.dart';
import 'package:voice_to_text_chat/models/user.dart';
import 'package:voice_to_text_chat/views/home/home_page.dart';
import 'package:voice_to_text_chat/views/login/login_page.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    WidgetsBinding.instance.addObserver(Test());

    checkAccountPersistence();

    return Material(
      child: Stack(
        children: [
          GetX<AppStateController>(
            init: Get.put(AppStateController()),
            builder: (controller) {
              return Navigator(
                transitionDelegate: NoAnimationTransitionDelegate(),
                  onPopPage: (_, __) {return true;},
                pages: [...controller.pageStack]
              );
            }
          ),
          GetX<AppStateController>(
            builder: (controller) {
              return controller.isScreenSizeInsufficient.value ? Container(
                width: Get.width, height: Get.height,
                color: Colors.black.withOpacity(0.85),
                child: const Center(child: Text('App currently only supports full screen', style: TextStyle(color: Colors.white, fontSize: 26)))
              ) : const SizedBox();
            },
          )
        ],
      ),
    );
  }

  checkAccountPersistence() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? loginType = pref.getString('loginType');
    if(loginType == null) {
      Get.put(AppStateController()).pageStack.value = [const CupertinoPage(child: LoginPage(), key: ValueKey('login'))];
    }
    else {
      if(loginType == 'google') {
        APIResponse<FCUser?> getUserResult = await FirestoreAPICollection().getGoogleUser(googleId: pref.getString('googleId')!);
        if(getUserResult.error) {
          Get.put(AppStateController()).pageStack.value = [const CupertinoPage(child: LoginPage(), key: ValueKey('login'))];
        }
        else {
          Get.put(AppStateController()).user = getUserResult.data! as FCUser;
          Get.put(AppStateController()).pageStack.value = [const CupertinoPage(child: HomePage(), key: ValueKey('home'))];
        }
      }
      else {

      }
    }
  }

}




class NoAnimationTransitionDelegate extends TransitionDelegate<void> {
  @override
  Iterable<RouteTransitionRecord> resolve({
    required List<RouteTransitionRecord> newPageRouteHistory,
    required Map<RouteTransitionRecord?, RouteTransitionRecord> locationToExitingPageRoute,
    required Map<RouteTransitionRecord?, List<RouteTransitionRecord>> pageRouteToPagelessRoutes,
  }) {
    final List<RouteTransitionRecord> results = <RouteTransitionRecord>[];

    for (final RouteTransitionRecord pageRoute in newPageRouteHistory) {
      if (pageRoute.isWaitingForEnteringDecision) {
        pageRoute.markForAdd();
      }
      results.add(pageRoute);

    }
    for (final RouteTransitionRecord exitingPageRoute in locationToExitingPageRoute.values) {
      if (exitingPageRoute.isWaitingForExitingDecision) {
        exitingPageRoute.markForRemove();
        final List<RouteTransitionRecord>? pagelessRoutes = pageRouteToPagelessRoutes[exitingPageRoute];
        if (pagelessRoutes != null) {
          for (final RouteTransitionRecord pagelessRoute in pagelessRoutes) {
            pagelessRoute.markForRemove();
          }
        }
      }
      results.add(exitingPageRoute);

    }
    return results;
  }
}




class Test with WidgetsBindingObserver {
  @override
  void didChangeMetrics() {
    super.didChangeMetrics();
    print('Width : ${Get.width}     Height : ${Get.height}');
    if(Get.width < 1362 || Get.height < 848) {
      Get.put(AppStateController()).isScreenSizeInsufficient.value = true;
    }
    else {
      Get.put(AppStateController()).isScreenSizeInsufficient.value = false;
    }
  }
}