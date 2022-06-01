import 'dart:convert';

import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../api/firestore_api_collection.dart';
import '../../controllers/home_state_controller.dart';

class ChatInputWidget extends StatelessWidget {
  const ChatInputWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    TextEditingController postMessageController = TextEditingController();

    return Row(
      children: [
        NeumorphicButton(
          onPressed: () {
            ImagePicker().pickImage(source: ImageSource.gallery).then((image) async {
                if(image != null) {
                  print('Hi');
                  await FirestoreAPICollection().postImage(image: base64Encode(await image.readAsBytes()), receiver: Get.put(HomeStateController()).sender.value!.id);
                }
            });
          },
          style: const NeumorphicStyle(depth: 10, shape: NeumorphicShape.concave, boxShape: NeumorphicBoxShape.circle()),
          child: Container(padding: const EdgeInsets.all(10),child: Icon(Icons.camera_alt_rounded, color: NeumorphicTheme.defaultTextColor(context))),
        ),
        const SizedBox(width: 20),
        Expanded(
          child: Neumorphic(
            style: const NeumorphicStyle(depth: -20, shape: NeumorphicShape.concave, boxShape: NeumorphicBoxShape.stadium()),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: TextField(controller: postMessageController,decoration: const InputDecoration(border: UnderlineInputBorder(borderSide: BorderSide.none), hintText: 'Type a message')),
            ),
          ),
        ),
        const SizedBox(width: 20),
        NeumorphicButton(
          onPressed: () {
            if(postMessageController.text != '' && Get.put(HomeStateController()).sender.value != null) {
              print('Hi : ${postMessageController.text}');
              FirestoreAPICollection().postMessage(receiver: Get.put(HomeStateController()).sender.value!.id, message: postMessageController.text);
              postMessageController.text = '';
            }
          },
          style: const NeumorphicStyle(depth: 10, shape: NeumorphicShape.concave, boxShape: NeumorphicBoxShape.circle()),
          child: Container(padding: const EdgeInsets.all(10),child: Icon(Icons.send_rounded, color: NeumorphicTheme.defaultTextColor(context))),
        ),
      ],
    );
  }
}
