
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quran_web/auth/database/auth.dart';
import 'package:quran_web/providers/circularprogressindicatorvalue.dart';
import 'package:quran_web/widgets/customdialog.dart';
import 'package:quran_web/widgets/text_form_field.dart';

class Login_Screen extends StatefulWidget {
  const Login_Screen({Key? key}) : super(key: key);

  @override
  State<Login_Screen> createState() => _Login_ScreenState();
}

class _Login_ScreenState extends State<Login_Screen> {
  
  @override
  Widget build(BuildContext context) {
     TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
      bool _isLoading = false;
       @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailController.clear();
    passController.clear();
  }
    return Scaffold(
      body:SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
            children: [
               Container(
                margin: EdgeInsets.only(top: 20,left: 20,right: 20),
                 child: TextFormInputField(
                    hintText: 'Enter your Email',
                    textInputType: TextInputType.emailAddress,
                    controller: emailController,
                  ),
               ),
                SizedBox(
                  height: 10,
                ),
                Container(
                                  margin: EdgeInsets.only(left: 20,right: 20),

                  child: TextFormInputField(
                    
                    hintText: 'Enter your Password',
                    textInputType: TextInputType.visiblePassword,
                    controller: passController,
                    isPass: true,
                  ),
                ),
                   SizedBox(
                  height: 23,
                ),
                Container(
          margin: EdgeInsets.symmetric(horizontal: 20, vertical: 40),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12.0),
            child: Builder(builder: (context) {
              return ElevatedButton(
                onPressed: () async {
                  if (emailController.text.isEmpty &&
                      passController.text.isEmpty) {
                    Customdialog()
                        .showInSnackBar("Both Fields are Required", context);
                  }
                  else if(emailController.text.isEmpty) {
                    Customdialog()
                        .showInSnackBar("Email Field are Required", context);
                  }
                  else if (passController.text.isEmpty) {
                    Customdialog()
                        .showInSnackBar("Password Field are Required", context);
                  }
                  else if (passController.text.length<5) {
                    Customdialog()
                        .showInSnackBar("Password minimum 5 charaters", context);
                  }
                 else if (emailController.text !='rafi@gmail.com' &&
                      passController.text!='123456') {
                    Customdialog()
                        .showInSnackBar("Email and password is wrong", context);
                  }
                  else if(emailController.text=='rafi@gmail.com' &&
                      passController.text=='123456'){
                  Customdialog.showDialogBox(context);
                    Provider.of<CircularProgressProvider>(context,listen: false).setValue(true);
                    Future.delayed(Duration(seconds: 0)).then((value) {
                      AuthUtils().login(emailController.text,
                          passController.text, context);
                    });

                  }
                  else if (emailController.text !='rafi@gmail.com' ) {
                    Customdialog()
                        .showInSnackBar("Email is wrong", context);
                  }
                  else if (
                      passController!='123456') {
                    Customdialog()
                        .showInSnackBar("Password is wrong", context);
                  }
                },
                style: ElevatedButton.styleFrom(
                    shape: StadiumBorder(),
                  
                  primary:  Color.fromARGB(255, 233, 222, 71),
                             fixedSize: Size(300, 60)
                ),
                child:Provider.of<CircularProgressProvider>(context).getValue==true?Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    CircularProgressIndicator(
                      color: Colors.black,
                    ),
                    SizedBox(width: 10,),
                    Text(
                      "Please wait...",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ):
                Text(
                  "Login",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
              );
            }),
          ),
        ),
         Provider.of<CircularProgressProvider>(context,listen: true).getValue==false? Center(
            child: Text(
          '',
          style: TextStyle(fontSize: 18),
        )):Text("jkjjh")
            ],
          
        ),
      ),
    );
  }
}