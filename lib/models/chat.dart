class Chat {

  String id;
  String sender;
  String receiver;
  String? message;
  String? image;
  DateTime timeStamp;

  Chat({required this.id, required this.sender, required this.receiver, required this.message, required this.timeStamp, this.image});

  static fromMap(Map<String, dynamic> chatMap, String documentId) {
    return Chat(id: documentId, sender: chatMap['sender'], receiver: chatMap['receiver'], message: chatMap['message'], timeStamp: DateTime.tryParse(chatMap['timestamp']!) ?? DateTime.fromMillisecondsSinceEpoch(10), image: chatMap['image']);
  }

  @override
  String toString() {
    return 'Chat ->   ID : $id,   Sender : $sender,   Receiver : $receiver,   Message : $message,    Timestamp : ${timeStamp.toString()}';
  }

}