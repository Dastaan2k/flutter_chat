import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:voice_to_text_chat/controllers/app_state_controller.dart';
import 'package:voice_to_text_chat/models/api_response.dart';
import 'package:voice_to_text_chat/models/chat.dart';

import '../models/user.dart';

class FirestoreAPICollection {

  FirebaseFirestore fireStore = FirebaseFirestore.instance;


  Future<APIResponse<FCUser?>> createUser({required String name, required String loginType, String? googleId, String? facebookId, String? imageUrl}) async {

    try {
      DocumentReference createUserResult = await fireStore.collection('users').add({'name' : name, 'loginType' : loginType, 'googleId' : googleId, 'facebookId' : facebookId, 'imageUrl' : imageUrl});
      DocumentSnapshot getUserResult = await createUserResult.get();
      return APIResponse(data: FCUser.fromMap(getUserResult.data() as Map<String, dynamic>, getUserResult.id));
    }
    catch(e) {
      return APIResponse(error: true, reason: e.toString());
    }

  }


  Future<APIResponse>updateStatus({required String id, required String status}) async {

    try {
      await fireStore.collection('users').doc(id).update({'status' : status});
      return APIResponse(data: null);
    }
    catch(e) {
      return APIResponse(error: true, reason: e.toString());
    }

  }


  Future<APIResponse<FCUser?>> getGoogleUser({required String googleId}) async {

    try {
      QuerySnapshot getUserResult = await fireStore.collection('users').where('googleId', isEqualTo: googleId).get();
      if(getUserResult.docs.isEmpty) {
        return APIResponse(error: true, reason: 'User not found');
      }
      else {
        return APIResponse(data: FCUser.fromMap(getUserResult.docs.first.data() as Map<String, dynamic>, getUserResult.docs.first.id));
      }
    }
    catch(e) {
      return APIResponse(error: true, reason: e.toString());
    }

  }


  Future<APIResponse<FCUser?>> getFacebookUser({required String facebookId}) async {

    try {
      QuerySnapshot getUserResult = await fireStore.collection('users').where('facebookId', isEqualTo: facebookId).get();
      if(getUserResult.docs.isEmpty) {
        return APIResponse(error: true, reason: 'User not found');
      }
      else {
        return APIResponse(data: FCUser.fromMap(getUserResult.docs.first.data() as Map<String, dynamic>, getUserResult.docs.first.id));
      }
    }
    catch(e) {
      return APIResponse(error: true, reason: e.toString());
    }

  }


  Future<APIResponse<void>> postMessage({required String receiver, required String message}) async {

    try {
      await fireStore.collection('chats').add({'sender' : Get.put(AppStateController()).user!.id, 'receiver' : receiver, 'message' : message, 'timestamp' : DateTime.now().toString()});
      return APIResponse();
    }
    catch(e) {
      return APIResponse(error: true, reason: e.toString());
    }

  }


  Future<APIResponse<void>> postImage({required String image, required String receiver}) async {

    try {
      await fireStore.collection('chats').add({'sender' : Get.put(AppStateController()).user!.id, 'receiver' : receiver, 'image' : image, 'timestamp' : DateTime.now().toString(), 'message' : ''});
      return APIResponse();
    }
    catch(e) {
      return APIResponse(error: true, reason: e.toString());
    }

  }



}