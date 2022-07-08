import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class MembersDetail extends StatefulWidget {
 var snap;
   MembersDetail({Key? key,required  this.snap}) : super(key: key);


  @override
  State<MembersDetail> createState() => _MembersDetailState();
}

class _MembersDetailState extends State<MembersDetail> {
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.blue
        ),
          elevation: 2,
          backgroundColor: Colors.white,
        
        centerTitle: true,
        title: Text('Memeber Detail',style: TextStyle(color: Colors.black),),
    
      ),
      body: SafeArea(
        child:  Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network(widget.snap['photoUrl'],),
                              
                            
              SizedBox(
                height: 10,
              ),
              Container(
                  margin: EdgeInsets.only(left: 20),
                  child: Text(
                    'Member Name',
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 17,
                                            fontWeight: FontWeight.w700

                    ),
                  )),
                   SizedBox(
                height: 10,
              ),
             Container(
                  margin: EdgeInsets.only(left: 20),
                  child:  Text(
                               widget.snap['name'] == null
                                ? 'No Data Found'
                                :widget.snap['name'],
                              style: TextStyle(color: Colors.black, fontSize: 15),
                              textAlign: TextAlign.start,
                            ),),
                SizedBox(height: 20,),
              Container(
                  margin: EdgeInsets.only(left: 20,top: 10),
                  child: Text(
                    'Member Bio',
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 17,
                      fontWeight: FontWeight.w700
                    ),
                  )),
                    SizedBox(
                height: 10,
              ),
            Container(
                  margin: EdgeInsets.only(left: 20),
                  child: Text(
                               widget.snap['bio'] == null
                                ? 'No Data Found'
                                :widget.snap['bio'],
                              style: TextStyle(color: Colors.black, fontSize: 15),
                              textAlign: TextAlign.start,
                            ),),
                SizedBox(height: 20,),
             
             
            ],
          ),
        ),
    );
  }
}