import 'package:flutter/foundation.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:get/get.dart';
import 'package:voice_to_text_chat/api/firestore_api_collection.dart';
import 'package:voice_to_text_chat/avatar.dart';
import 'package:voice_to_text_chat/models/user.dart';
import '../../controllers/app_state_controller.dart';
import '../../models/api_response.dart';
import '../misc/hex_color.dart';

class ProfileWidget extends StatefulWidget {
  const ProfileWidget({Key? key}) : super(key: key);

  @override
  State<ProfileWidget> createState() => _ProfileWidgetState();
}

class _ProfileWidgetState extends State<ProfileWidget> {

  final TextEditingController _statusController = TextEditingController();

  String oldStatus = '';
  bool isEditable = false;

  @override
  void initState() {
    _statusController.text = Get.put(AppStateController()).user!.status ?? 'No Status';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Neumorphic(
      child: SizedBox(
        width: double.infinity,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const FCAvatar(radius: 100),
                  const SizedBox(height: 20),
                  Text(Get.put(AppStateController()).user!.name, style: TextStyle(fontWeight: FontWeight.w600, color: NeumorphicTheme.defaultTextColor(context))),
                  const SizedBox(height: 10),
                  Neumorphic(
                      style: NeumorphicStyle(depth: isEditable ? -5 : 0, boxShape: const NeumorphicBoxShape.stadium()),
                      child: SizedBox(
                          width: 250,
                          height: 50,
                          child: TextField(
                              controller: _statusController,
                              textAlign: TextAlign.center,
                              enabled: isEditable,
                              decoration: const InputDecoration(
                                  contentPadding: EdgeInsets.zero,
                                  border: UnderlineInputBorder(borderSide: BorderSide.none)
                              ),
                              style: TextStyle(color: NeumorphicTheme.defaultTextColor(context).withOpacity(0.45))
                          )
                      )
                  ),
                ],
              ),
            ),
            Positioned(
              top: 20, left: 20,
              child: GestureDetector(
                  onTap: () async {
                    if(NeumorphicTheme.of(context)!.themeMode == ThemeMode.light) {
                      NeumorphicTheme.of(context)!.themeMode = ThemeMode.dark;
                    }
                    else {
                      NeumorphicTheme.of(context)!.themeMode = ThemeMode.light;
                    }
                  },
                  child: Icon(NeumorphicTheme.of(context)!.themeMode == ThemeMode.dark ? Icons.brightness_7 : Icons.brightness_2, color: NeumorphicTheme.defaultTextColor(context))
              ),
            ),
            Positioned(
              top: 20, right: 20,
              child: GestureDetector(
                  onTap: () async {
                    if(isEditable) {
                      APIResponse resp = await FirestoreAPICollection().updateStatus(id: Get.put(AppStateController()).user!.id, status: _statusController.text);
                      if(resp.error) {
                        print('Error : ${resp.error}');
                      }
                      else {
                        FCUser user = Get.put(AppStateController()).user!;
                        user.status = _statusController.text;
                        Get.put(AppStateController()).user = user;
                      }
                    }
                    setState(() {
                      isEditable = !isEditable;
                    });
                  },
                  child: Icon(Icons.edit, color: NeumorphicTheme.defaultTextColor(context))
              ),
            )
          ],
        ),
      ),
    );
  }
}
