import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

import '../../api/firestore_api_collection.dart';
import '../../models/user.dart';
import 'friend_card.dart';

class ContactsListWidget extends StatelessWidget {
  const ContactsListWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Neumorphic(
      child: LayoutBuilder(
          builder: (_, constraints) {
            return SizedBox(
                width: constraints.constrainWidth(),
                height: constraints.constrainHeight(),
                child: StreamBuilder<QuerySnapshot>(
                  stream: FirestoreAPICollection().fireStore.collection('users').snapshots(),
                  builder: (_, AsyncSnapshot snap) {

                    if(snap.connectionState == ConnectionState.waiting) {
                      return const SizedBox();
                    }
                    else {

                      List<QueryDocumentSnapshot> contactList = (snap.data as QuerySnapshot<Map<String, dynamic>>).docs;

                      if(contactList.isEmpty) {
                        return const Center(child: Text('No contacts available'));
                      }
                      else {
                        return ListView.builder(
                            itemCount: contactList.length,
                            itemBuilder: (_, index) {
                              return FriendCard(index: index, user: FCUser.fromMap(contactList[index].data() as Map<String, dynamic>, contactList[index].id));
                            }
                        );
                      }
                    }

                  },
                )
            );
          }
      ),
      style: const NeumorphicStyle(
        shape: NeumorphicShape.flat, depth: 0,
      ),
    );
  }
}
