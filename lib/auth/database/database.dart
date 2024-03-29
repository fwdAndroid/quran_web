

import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:quran_web/memebrs/member_model.dart';

class Database{
 final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String> uploadNews(
      {required String title,
      required String description,
      required String date,
      required Uint8List file}) async {
    String res = 'Some error occured.';
    try {
      if (title.isNotEmpty || file != null) {
        String photoUrl = await uploadImageToStorage(
          'Members',
          file,
        );

        MemberModel commit = MemberModel(
          title: title,
          description: description,
          date: date,
          photoUrl: photoUrl,
        );

        _firestore.collection('members').doc().set(
              commit.toJson(),
            );
        res = 'Success';
      }
    } catch (error) {
      res = error.toString();
    }
    return res;
  }

  Future<String> uploadImageToStorage(
    String childName,
    Uint8List file,
  ) async {
    Reference ref = _firebaseStorage
        .ref()
        .child(childName)
        .child(DateTime.now().toIso8601String());

    UploadTask uploadTask = ref.putData(file);

    TaskSnapshot taskSnapshot = await uploadTask;
    String downloadUrl = await taskSnapshot.ref.getDownloadURL();
    return downloadUrl;
  }
 

}