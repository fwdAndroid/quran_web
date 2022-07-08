

import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:quran_web/auth/database/database.dart';
import 'package:quran_web/memberspage.dart';
import 'package:quran_web/utils/utils.dart';
import 'package:quran_web/widgets/text_form_field.dart';

class AddMemebrs extends StatefulWidget {
  const AddMemebrs({Key? key}) : super(key: key);

  @override
  _AddMemebrsState createState() => _AddMemebrsState();
}

class _AddMemebrsState extends State<AddMemebrs> {
  TextEditingController nameController = TextEditingController();
  TextEditingController bioController = TextEditingController();
  Uint8List ? _image;

  //Looding Variable
  bool _isLoading = false;
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    nameController.clear();
    bioController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          padding: EdgeInsets.symmetric(horizontal: 32),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              
              Stack(
                children: [
                  _image != null
                      ? CircleAvatar(
                          radius: 59, backgroundImage: MemoryImage(_image!))
                      : CircleAvatar(
                          radius: 59,
                          backgroundImage: NetworkImage(
                              'https://static.remove.bg/remove-bg-web/a6eefcd21dff1bbc2448264c32f7b48d7380cb17/assets/start_remove-c851bdf8d3127a24e2d137a55b1b427378cd17385b01aec6e59d5d4b5f39d2ec.png'),
                        ),
                  Positioned(
                      bottom: -10,
                      left: 70,
                      child: IconButton(
                          onPressed: () => selectImage(),
                          icon: Icon(
                            Icons.add_a_photo,
                            color: Colors.white,
                          )))
                ],
              ),
              SizedBox(
                height: 23,
              ),
              TextFormInputField(
                hintText: 'Enter member name',
                textInputType: TextInputType.text,
                controller: nameController,
              ),
              SizedBox(
                height: 23,
              ),
              TextFormInputField(
                hintText: 'Enter member bio',
                textInputType: TextInputType.emailAddress,
                controller: bioController,
              ),
              SizedBox(
                height: 23,
              ),
              
              InkWell(
                onTap: addMemebrs,
                child: _isLoading
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : Container(
                        height: 60,
                        child: Text('Add Member'),
                        width: double.infinity,
                        alignment: Alignment.center,
                        padding: EdgeInsets.symmetric(horizontal: 22),
                        decoration: ShapeDecoration(
                            color: Color.fromARGB(255, 233, 222, 71),
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(4)))),
                      ),
              ),
              SizedBox(
                height: 13,
              ),
             
            ],
          ),
        ),
      )),
    );
  }

  ////Functions///////

  /// Select Image From Gallery
  selectImage() async {
    Uint8List ui = await pickImage(ImageSource.gallery);
    setState(() {
      _image = ui;
    });
  }


addMemebrs()async {
  setState(() {
     _isLoading = true;
  });
  String res = await Database().addMemebrsUser(file: _image!, bio: bioController.text, name: nameController.text,);
 print(res);
 setState(() {
        _isLoading = false;

 });
 if (res != 'sucess') {
  showSnakBar(res, context);
 }else{
  
 }
}
  ///Register Users
  // addMemebrs() async {
  //   setState(() {
  //     _isLoading = true;
  //   });
  //   String rse = await Database().addMemebrsUser(     
  //       bio: bioController.text,
  //       name: nameController.text,
  //       file: _image!);

  //   print(rse);
  //   setState(() {
  //     _isLoading = false;
  //   });
  //   if (rse != 'sucess') {
  //     showSnakBar(rse, context);
  //   } else {
  //    Navigator.push(context, MaterialPageRoute(
  //         builder: (builder) =>
  //             MemebersPage()));
  //   }
  // }
}
