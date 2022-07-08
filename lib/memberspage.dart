import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:quran_web/add_memebers.dart';
import 'package:quran_web/showmemebers.dart';

class MemebersPage extends StatefulWidget {
  const MemebersPage({Key? key}) : super(key: key);

  @override
  State<MemebersPage> createState() => _MemebersPageState();
}

class _MemebersPageState extends State<MemebersPage> {
    var isbool= false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(onPressed: (){
        Navigator.push(context, MaterialPageRoute(builder: (builder) => AddMemebrs()));
      }, child: Icon(Icons.add),),
      body: SingleChildScrollView(
     child:
            Container(
              height: 680,
              child:   StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection("members")                         
                          .snapshots(),
                      builder: (BuildContext context,
                          AsyncSnapshot<QuerySnapshot> snapshot) {
                         



                        if (snapshot.hasError) {
                          return Text('Some Thing Missing');
                        }
                        if (snapshot.hasData){
                                return ListView.builder(
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, index) {
                          
                            return isbool ? CircularProgressIndicator(): ShowMemebers(snap: snapshot.data!.docs[index]);
                          },
                        );
                        }

                        return Center(child: CircularProgressIndicator());
                       
                     
                       
                        
                      },
                   
                    ),
          
          
        ),
      ),
    
    
    );
    
  }
}

