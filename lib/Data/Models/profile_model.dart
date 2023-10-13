import '../firebase_collections.dart';

class ProfileModel {
  String? id;
  String? timeStamps;
  late String name;
  late String phone;
  late String email;
  late String verified;
  late List posts;
  String? address;
  String? msg;
  String? profilePicture;

  ProfileModel({
    this.id,
    this.timeStamps,
    required this.name,
    required this.phone,
    required this.email,
    required this.verified,
    required this.posts,
    this.address,
    this.msg,
    this.profilePicture,
  });

  ProfileModel copyWith({
    String? id,
    String? timeStamps,
    String? name,
    String? phone,
    String? email,
    String? verified,
    List? posts,
    String? address,
    String? msg,
    String? profilePicture,
  }) {
    return ProfileModel(
      id: id ?? this.id,
      timeStamps: timeStamps ?? this.timeStamps,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      verified: verified ?? this.verified,
      posts: posts ?? this.posts,
      address: address ?? this.address,
      msg: msg ?? this.msg,
      profilePicture: profilePicture ?? this.profilePicture,
    );
  }

  Map<String, dynamic> toMap() {
    return {
          "id": id,
          "timeStamps": timeStamps,
          "name": name,
          "phone": phone,
          "email": email,
          "verified": verified,
          "posts": posts,
          "address": address,
          "msg": msg,
          "profilePicture": profilePicture,
        };
      }

  factory ProfileModel.fromMap(Map<String, dynamic> map) {
       return ProfileModel(
        id: map["id"],
        timeStamps: map["timeStamps"],
        name: map["name"],
        phone: map["phone"],
        email: map["email"],
        verified: map["verified"],
         posts: map["posts"],
        address: map["address"],
        msg: map["msg"],
        profilePicture: map["profilePicture"],
      );
  }

  factory ProfileModel.fromJson(Map<String, dynamic> json) => ProfileModel(
    id: json["id"],
    timeStamps: json["timeStamps"],
    name: json["name"],
    phone: json["phone"],
    email: json["email"],
    verified: json["verified"],
    posts: json["posts"],
    address: json["address"],
    msg: json["msg"],
    profilePicture: json["profilePicture"],
  );

  @override
  String toString() {
    return 'ProfileModel{id: $id, timeStamps: $timeStamps, name: $name, phone: $phone, email: $email, posts: $posts, verified: $verified, address: $address, profilePicture: $profilePicture, msg: $msg}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ProfileModel &&
        other.id == id &&
        other.timeStamps == timeStamps &&
        other.name == name &&
        other.email == email &&
        other.verified == verified &&
        other.posts == posts &&
        other.address == address &&
        other.msg == msg &&
        other.profilePicture == profilePicture &&
        other.phone == phone;
  }

  @override
  int get hashCode {
    return id.hashCode ^
    timeStamps.hashCode ^
    name.hashCode ^
    email.hashCode ^
    verified.hashCode ^
    posts.hashCode ^
    address.hashCode ^
    msg.hashCode ^
    profilePicture.hashCode ^
    phone.hashCode;
  }

  save() {
    FirebaseCollections.PROFILECOLLECTION.doc(id).set(toMap());
  }

  update() {
  FirebaseCollections.PROFILECOLLECTION.doc(id).update(toMap());
  }

  static Stream<List<ProfileModel>> getProfiles() {
    try {
      return FirebaseCollections.PROFILECOLLECTION.snapshots().map((snapshot) {
        return snapshot.docs.map((doc) {
          return ProfileModel.fromMap(doc.data() as Map<String, dynamic>)
            ..id = doc.id;
        }).toList();
      });
    } on Exception catch (e) {
      rethrow;
    }
  }

  delete() {
    FirebaseCollections.PROFILECOLLECTION.doc(id).delete();
  }

  static getProfileByUserId({required String uId}) async {
    try {
      return ProfileModel.fromMap(
          (await FirebaseCollections.PROFILECOLLECTION.doc(uId).get()).data()
              as Map<String, dynamic>);
    } on Exception {
      rethrow;
    }
  }
}
