import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:quran_web/auth/database/membersmodels.dart';
import 'package:quran_web/auth/database/storage_methods.dart';
import 'package:uuid/uuid.dart';

class Database{
 
 //Upload PostImage to Firestore
  Future<String> addMemebrsUser(
    {required Uint8List file,required String bio,
     required String name}) async {
    String res = "Some Error";
    try {
      String photoUrl =
          await StorageMethods().uploadImageToStorage("profileImages", file, true);

      String uid = Uuid().v1();
      MembersModel postModel = MembersModel(
          bio: bio,
          uid: uid,
          name: name, 
          photoURL: photoUrl,);

      ///Uploading Post To Firebase
      FirebaseFirestore.instance
          .collection('members')
          .doc(uid)
          .set(postModel.toJson());
      res = 'Sucessfully Uploaded in Firebase';
    } catch (e) {
      res = e.toString();
    }

    return res;
  }

}