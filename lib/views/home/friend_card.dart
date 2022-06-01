import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:get/get.dart';
import 'package:voice_to_text_chat/avatar.dart';
import 'package:voice_to_text_chat/models/user.dart';
import 'package:voice_to_text_chat/controllers/home_state_controller.dart';

import '../misc/hex_color.dart';

class FriendCard extends StatelessWidget {

  final int index;
  final FCUser user;

  const FriendCard({required this.index, required this.user, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetX<HomeStateController>(
      init: Get.put(HomeStateController()),
      builder: (controller) {
        return Padding(
          padding: const EdgeInsets.only(top: 30, left: 40, right: 40),
          child: InkWell(
            onTap: () {
              controller.sender.value = user;
              controller.index.value = index;
            },
            child: Neumorphic(
              style: NeumorphicStyle(depth: controller.index.value == index ? -10 : 5),
              child: SizedBox(
                height: 80,
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Row(
                    children: [
                      FCAvatar(),
                      const SizedBox(width: 20),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(user.name, style: TextStyle(fontWeight: FontWeight.w600, color: NeumorphicTheme.defaultTextColor(context))),
                          const SizedBox(height: 5),
                          Text(user.status ?? 'No Status', style: TextStyle(fontWeight: FontWeight.w600, color: NeumorphicTheme.defaultTextColor(context).withOpacity(0.45), overflow: TextOverflow.ellipsis))
                        ],
                      ),
                      const Expanded(child: SizedBox())
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      }
    );
  }
}
