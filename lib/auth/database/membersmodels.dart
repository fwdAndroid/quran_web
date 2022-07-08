import 'package:cloud_firestore/cloud_firestore.dart';

class MembersModel{
  String bio;
  String uid;
  String name;

  String photoURL;
  MembersModel(
      {required this.bio,
      required this.uid,
      required this.name,
      required this.photoURL,
      });

  ///Converting OBject into Json Object
  Map<String, dynamic> toJson() => {
        'bio': bio,
        'uid': uid,
        'name': name,
        'photoURL': photoURL ,
        
      };

  ///
  static MembersModel fromSnap(DocumentSnapshot snaps) {
    var snapshot = snaps.data() as Map<String, dynamic>;

    return MembersModel(
      name: snapshot['name'],
      uid: snapshot['uid'],
      bio: snapshot['bio'],     
      photoURL: snapshot['photoURL'],
    );
  }
}