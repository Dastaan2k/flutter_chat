import 'dart:convert';

import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:get/get.dart';
import 'package:voice_to_text_chat/controllers/app_state_controller.dart';

import '../../models/chat.dart';

class ChatCard extends StatefulWidget {

  final Chat chat;

  const ChatCard({required this.chat, Key? key}) : super(key: key);

  @override
  State<ChatCard> createState() => _ChatCardState();
}

class _ChatCardState extends State<ChatCard> {

  bool initToggle = false;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      setState(() {initToggle = true;});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0, bottom: 20, left: 40, right: 40),
      child: Row(
        children: [
          widget.chat.sender == Get.put(AppStateController()).user!.id ? const Expanded(child: SizedBox()) : const SizedBox(),
          Neumorphic(
            duration: const Duration(milliseconds: 500),
            style: NeumorphicStyle(depth: initToggle ? 5 :0, shape: NeumorphicShape.flat),
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
              child: Column(
                crossAxisAlignment: widget.chat.sender == Get.put(AppStateController()).user!.id ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                children: [
                  widget.chat.image != null ? Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Image.memory(base64Decode(widget.chat.image!), width: Get.width * 0.2, height: Get.height * 0.2),
                  ) : const SizedBox(),
                  widget.chat.message != null ? Text(widget.chat.message!, style: TextStyle(fontWeight: FontWeight.w600, color: NeumorphicTheme.defaultTextColor(context))) : const SizedBox(),
                  const SizedBox(height: 10),
                  Text(widget.chat.timeStamp.day.toString() + '/' + widget.chat.timeStamp.month.toString() + '/' + widget.chat.timeStamp.year.toString() + '    |    ' + widget.chat.timeStamp.hour.toString() + ':' + widget.chat.timeStamp.minute.toString(), style: TextStyle(color: NeumorphicTheme.defaultTextColor(context).withOpacity(0.65), fontSize: 12))
                ],
              ),
            ),
          ),
          widget.chat.sender == Get.put(AppStateController()).user!.id ? const SizedBox() : const Expanded(child: SizedBox()),
        ],
      ),
    );
  }
}
