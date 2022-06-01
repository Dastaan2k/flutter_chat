import 'package:get/get.dart';
import 'package:voice_to_text_chat/models/user.dart';

import '../models/chat.dart';

class HomeStateController extends GetxController {

  RxInt index = (-1).obs;

  Rxn<FCUser> sender = Rxn<FCUser>();

}
