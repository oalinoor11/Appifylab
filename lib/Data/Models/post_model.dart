import 'package:Appifylab/Controllers/profile_controller.dart';

import '../firebase_collections.dart';

class PostModel {
  String? id;
  late String caption;
  late String image;
  late String posterID;
  late String posterName;
  late String posterImage;
  late String posterVerified;
  late String privacy;
  late String timeStamps;
  late List comments;
  late List reactions;
  late List shares;
  late List hideto;
  late List reports;
  PostModel({
    this.id,
    required this.caption,
    required this.image,
    required this.posterID,
    required this.posterName,
    required this.posterImage,
    required this.posterVerified,
    required this.privacy,
    required this.timeStamps,
    required this.comments,
    required this.reactions,
    required this.shares,
    required this.hideto,
    required this.reports,
  });

  factory PostModel.fromJson(Map<String, dynamic> json) => PostModel(
    id: json["id"],
    caption: json["caption"],
    image: json["image"],
    posterID: json["posterID"],
    posterName: json["posterName"],
    posterImage: json["posterImage"],
    posterVerified: json["posterVerified"],
    privacy: json["privacy"],
    timeStamps: json["timeStamps"],
    comments: json["comments"],
    reactions: json["reactions"],
    shares: json["shares"],
    hideto: json["hideto"],
    reports: json["reports"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "caption": caption,
    "image": image,
    "posterID": posterID,
    "posterName": posterName,
    "posterImage": posterImage,
    "posterVerified": posterVerified,
    "privacy": privacy,
    "timeStamps": timeStamps,
    "comments": comments,
    "reactions": reactions,
    "shares": shares,
    "hideto": hideto,
    "reports": reports,
  };

  @override
  String toString() {
    return 'PostModel{id: $id, caption: $caption, image: $image, posterID: $posterID, posterName: $posterName, posterImage: $posterImage, posterVerified: $posterVerified, privacy: $privacy, timeStamps: $timeStamps, comments: $comments, reactions: $reactions, shares: $shares, hideto: $hideto, reports: $reports}';
  }

  save() {
    FirebaseCollections.POSTCOLLECTION.doc(id).set(toJson());
  }



  static Stream<List<PostModel>> getPosts() {
    try {
      return FirebaseCollections.POSTCOLLECTION
          .orderBy("timeStamps", descending: true)
          .snapshots().map((snapshot) {
        return snapshot.docs.map((doc) {
          return PostModel.fromJson(doc.data() as Map<String, dynamic>)
            ..id = doc.id;
        }).toList();
      });
    } on Exception catch (e) {
      rethrow;
    }
  }

  static Stream<List<PostModel>> getMyPosts() {
    try {
      return FirebaseCollections.POSTCOLLECTION
          .orderBy("timeStamps", descending: true)
      .where("posterID", isEqualTo: ProfileController.to.profile.value!.id)
          .snapshots().map((snapshot) {
        return snapshot.docs.map((doc) {
          return PostModel.fromJson(doc.data() as Map<String, dynamic>)
            ..id = doc.id;
        }).toList();
      });
    } on Exception catch (e) {
      rethrow;
    }
  }

  update() {
    FirebaseCollections.POSTCOLLECTION.doc(id).update(toJson());
  }

  delete() {
    FirebaseCollections.POSTCOLLECTION.doc(id).delete();
  }
}
