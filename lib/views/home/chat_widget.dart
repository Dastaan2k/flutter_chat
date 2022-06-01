import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:get/get.dart';

import '../../api/firestore_api_collection.dart';
import '../../controllers/app_state_controller.dart';
import '../../models/chat.dart';
import 'chat_card.dart';
import '../../controllers/home_state_controller.dart';

class ChatWidget extends StatelessWidget {
  const ChatWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 40.0),
      child: Neumorphic(
        style: const NeumorphicStyle(depth: -7),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20.0),
          child: GetX<HomeStateController>(
              init: Get.put(HomeStateController()),
              builder: (controller) {

                print('Chat Widget build');


                if(controller.sender.value == null) {
                  return const Center(child: Text('No contact selected'));
                }
                else {

                  StreamController<List<QueryDocumentSnapshot>> chatListController = StreamController();

                  FirestoreAPICollection().fireStore.collection('chats').where('receiver', whereIn: [controller.sender.value!.id, Get.put(AppStateController()).user!.id]).snapshots().listen((event) {

                    List<QueryDocumentSnapshot> filteredList = [];

                    event.docs.forEach((querySnap) {
                      Map x = querySnap.data();
                      if(((x['receiver'] == Get.put(AppStateController()).user!.id) && (x['sender'] == controller.sender.value!.id)) || ((x['sender'] == Get.put(AppStateController()).user!.id) && (x['receiver'] == controller.sender.value!.id))) {
                        filteredList.add(querySnap);
                      }
                    });

                    chatListController.sink.add(filteredList);
                  });

                  return StreamBuilder(
                    stream: chatListController.stream,
                    builder: (_, AsyncSnapshot snap) {

                      if(snap.connectionState == ConnectionState.waiting) {
                        return const Center(child: Text("Loading"));
                      }
                      else {

                        List<Chat> chatList = [];

                        snap.data.forEach((QueryDocumentSnapshot snap) {
                          chatList.add(Chat.fromMap(snap.data() as Map<String, dynamic>, snap.id));
                        });


                        ScrollController chatScrollController = ScrollController();

                        chatList.sort((a,b) => a.timeStamp.millisecondsSinceEpoch < b.timeStamp.millisecondsSinceEpoch ? -1 : 1);
                        Future.delayed(const Duration(milliseconds: 100), () {
                          chatScrollController.animateTo(chatScrollController.position.maxScrollExtent * 2, duration: const Duration(milliseconds: 300), curve: Curves.easeIn);
                        });

                        return chatList.isEmpty ? const Center(child: Text('No chats available')) : ListView.builder(
                          controller: chatScrollController,
                          itemCount: chatList.length,
                          itemBuilder: (_, index) {
                            return ChatCard(chat: chatList[index]);
                          },
                        );
                      }

                    },
                  );

                }
              }
          ),
        ),
      ),
    );
  }
}
