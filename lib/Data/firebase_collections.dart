import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseCollections {
  static CollectionReference PROFILECOLLECTION = FirebaseFirestore.instance.collection("PROFILELIST");
  static CollectionReference POSTCOLLECTION = FirebaseFirestore.instance.collection("POSTLIST");
}
