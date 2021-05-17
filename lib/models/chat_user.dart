import 'package:cloud_firestore/cloud_firestore.dart';

class ChatUser {
  bool isEmailVerified;
  Null updatedAt;
  Timestamp lastLoggedIn;
  Null phone;
  String uid;
  String bio;
  String avatar;
  bool isPublic;
  Meta meta;
  String loggedIn;
  String email;
  Timestamp createdAt;
  String name;

  ChatUser({
    this.isEmailVerified,
    this.updatedAt,
    this.lastLoggedIn,
    this.phone,
    this.uid,
    this.bio,
    this.avatar,
    this.isPublic,
    this.meta,
    this.loggedIn,
    this.email,
    this.createdAt,
    this.name,
  });

  ChatUser.fromJson(Map<String, dynamic> json) {
    isEmailVerified = json['isEmailVerified'];
    updatedAt = json['updatedAt'];
    lastLoggedIn = json['lastLoggedIn'];
    phone = json['phone'];
    uid = json['uid'];
    bio = json['bio'];
    avatar = json['avatar'];
    isPublic = json['isPublic'];
    meta = json['meta'] != null ? new Meta.fromJson(json['meta']) : null;
    loggedIn = json['loggedIn'];
    email = json['email'];
    createdAt = json['createdAt'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['isEmailVerified'] = this.isEmailVerified;
    data['updatedAt'] = this.updatedAt;
    data['lastLoggedIn'] = this.lastLoggedIn;
    data['phone'] = this.phone;
    data['uid'] = this.uid;
    data['bio'] = this.bio;
    data['avatar'] = this.avatar;
    data['isPublic'] = this.isPublic;
    if (this.meta != null) {
      data['meta'] = this.meta.toJson();
    }
    data['loggedIn'] = this.loggedIn;
    data['email'] = this.email;
    data['createdAt'] = this.createdAt;
    data['name'] = this.name;
    return data;
  }
}

class Meta {
  Timestamp creationTime;
  Timestamp lastSignInTime;

  Meta({
    this.creationTime,
    this.lastSignInTime,
  });

  Meta.fromJson(Map<String, dynamic> json) {
    creationTime = json['creationTime'];
    lastSignInTime = json['lastSignInTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['creationTime'] = this.creationTime;
    data['lastSignInTime'] = this.lastSignInTime;
    return data;
  }
}
