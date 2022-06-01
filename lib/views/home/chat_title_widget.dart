import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:get/get.dart';
import 'package:voice_to_text_chat/avatar.dart';

import '../misc/hex_color.dart';
import '../../controllers/home_state_controller.dart';

class ChatTitleWidget extends StatelessWidget {
  const ChatTitleWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetX<HomeStateController>(
        init: Get.put(HomeStateController()),
        builder: (controller) {
          return Neumorphic(
            style: NeumorphicStyle(depth: controller.sender.value == null ? 0 :  5, shape: NeumorphicShape.flat),
            child: SizedBox(
              height: 80,
              width: double.infinity,
              child: controller.sender.value != null ? Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Row(
                    children: [
                      controller.sender.value != null ? FCAvatar() : const SizedBox(),
                      const SizedBox(width: 20),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(controller.sender.value?.name ?? '', style: TextStyle(fontWeight: FontWeight.w600, color: NeumorphicTheme.defaultTextColor(context))),
                          const SizedBox(height: 5),
                          Text(controller.sender.value?.status ?? 'No Status', style: TextStyle(fontWeight: FontWeight.w600, color: NeumorphicTheme.defaultTextColor(context).withOpacity(0.45), overflow: TextOverflow.ellipsis))
                        ],
                      ),
                      const Expanded(child: SizedBox())
                    ],
                  )
              ) : const SizedBox(),
            ),
          );
        }
    );
  }
}
