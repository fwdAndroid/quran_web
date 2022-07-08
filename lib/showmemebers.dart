import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:quran_web/membersdetails.dart';
import 'package:uuid/uuid.dart';

class ShowMemebers extends StatefulWidget {
  var snap;
   ShowMemebers({Key? key,required  this.snap}) : super(key: key);

  @override
  State<ShowMemebers> createState() => _ShowMemebersState();
}

class _ShowMemebersState extends State<ShowMemebers> {
    bool _isShown = true;

  @override
  Widget build(BuildContext context) {
    return    
    Container(
        margin: EdgeInsets.only(left: 10,right: 10),
         child: Card(
          elevation: 10,
           shape: BeveledRectangleBorder(
         borderRadius: BorderRadius.circular(10.0),
       ),
           child: ListTile(
             onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (builder) => MembersDetail(snap: widget.snap,)));
             },
             leading: Image.network(widget.snap['photoUrl'],),
                              
                              title: Text(
                                 widget.snap['name'] == null
                                  ? 'No Data Found'
                                  :widget.snap['name'],
                                style: TextStyle(color: Colors.black, fontSize: 15),
                                textAlign: TextAlign.start,
                              ),
                             
                              trailing:  IconButton(onPressed: (){
                                 _delete(context);
                              }, icon: Icon(Icons.delete,color: Colors.red,))
                            ),
         
       ),
     );
  }
 void _delete(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext ctx) {
          return AlertDialog(
            title: const Text('Please Confirm'),
            content: const Text('Are you sure to remove the service',style: TextStyle(fontSize: 13,fontWeight: FontWeight.w700),),
            actions: [
              // The "Yes" button
              TextButton(
                  onPressed: () {
                    // Remove the box
                    setState(() {
                     
                       FirebaseFirestore.instance.collection("members").doc(widget.snap['uid'])
                                          
                                          .delete();
                    });

                    // Close the dialog
                    Navigator.of(context).pop();
                  },
                  child: const Text('Yes')),
              TextButton(
                  onPressed: () {
                    // Close the dialog
                    Navigator.of(context).pop();
                  },
                  child: const Text('No'))
            ],
          );
        });
  }
 
  
 
}