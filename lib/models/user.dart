class FCUser {

  String id;      /// documentID
  String name;
  //String? imageUrl;
  String? status;
  String loginType;         /// 'google', 'facebook'
  String? googleId;
  String? facebookId;

  FCUser({required this.loginType, required this.name, required this.id, this.googleId, this.facebookId, this.status/*, this.imageUrl*/});

  static fromMap(Map<String,dynamic> userMap, String documentId) {
    return FCUser(loginType: userMap['loginType'], name: userMap['name'], id: documentId, googleId: userMap['googleId'], facebookId: userMap['facebookId'], status: userMap['status']/*, imageUrl: userMap['imageUrl']*/);
  }

  @override
  toString() {
    return 'User ->  Name : $name   Login Type : $loginType     Google ID : $googleId      Facebook ID : $facebookId        Status : $status';
  }

}
