import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:quran_web/addmemberscreen.dart';
import 'package:quran_web/widgets/members_widget.dart';

class MemberPagers extends StatefulWidget {
  const MemberPagers({Key? key}) : super(key: key);

  @override
  State<MemberPagers> createState() => _MemberPagersState();
}

class _MemberPagersState extends State<MemberPagers> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Members'),
      ),
      body: FutureBuilder(
          future: FirebaseFirestore.instance.collection('members').get(),
          builder: (context,
              AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (!snapshot.hasData) {
              return const Center(
                child: Text('No Members Added yet!'),
              );
            }
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (BuildContext context, int index) {
                return index == null
                    ? const Text('Data is Not Loaded')
                    : MemberWidget(
                        snap: snapshot.data!.docs[index].data(),
                      );
              },
            );
          }),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        backgroundColor: Theme.of(context).primaryColor,
        onPressed: () => Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const AddMemberScreen(),
          ),
        ),
      ),
    );
  }
}