import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mapbox_navigation/constants/restaurants.dart';
import 'package:mapbox_navigation/ui/splash.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({ Key? key }) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController idController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController confirmPassController = TextEditingController();
  double screenHeight = 0;
  double screenWidth = 0;

  Color primary = const Color(0xFF3D82AE);

  Future<void> function(username, password, email, phone)async{
    String uid = users.length.toString();
    var _collectionRef =FirebaseFirestore.instance.collection('users').doc('map').update({uid:{
      'username': username,
      'password': password,
      'email': email,
      'phone': phone,
    }});
    return;
  }

  @override
  Widget build(BuildContext context) {
    //final bool isKeyboardVisible = KeyboardVisibilityProvider.isKeyboardVisible(context);
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      body: Column(
        children: [
          Container(
            ),// Container
            Container(
              alignment: Alignment.centerLeft,
              margin: EdgeInsets.symmetric(
                vertical: screenHeight / 20,
                horizontal: screenWidth / 12
                ), // EdgeInsets
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  fieldTitle("Username"),
                  userField("Enter your username", idController, false),
                  fieldTitle("Email"),
                  emailField("Enter your email", emailController, false),
                  fieldTitle("Phone"),
                  phoneField("Enter your phone", phoneController, false),
                  fieldTitle("Password"),
                  passField("Enter your password", passController, true),
                  fieldTitle("Confirm Password"),
                  confirmPassField("Confirm your password", confirmPassController, true),
                  TextButton(
                    onPressed: (){
                      if(idController.text.length !=0 && passController.text.length!=0 && emailController.text.length!=0 && phoneController.text.length!=0){
                        function(idController.text, passController.text, emailController.text, phoneController.text);
                        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const Splash()), (Route<dynamic> route) => false);
                      }
                    },
                    child: Container(
                      height: 60,
                      width: screenWidth,
                      margin: EdgeInsets.only(top: screenHeight / 40),
                      decoration: BoxDecoration(
                        color: primary,
                        borderRadius:  const BorderRadius.all(Radius.circular(30)),
                      ), //BoxDec
                      child: Center(
                        child: Text(
                          "Register",
                          style: TextStyle(
                            fontSize: screenWidth / 22,
                            color: Colors.white,
                            letterSpacing: 2
                          ), //TextStyle
                        ), //Text
                      ), //Center
                    ),
                  ), //Container
                ],
              ), //Column
            ), //Container
        ],
      ),
      
    );
  }

Widget fieldTitle(String title){
  return Container(
    margin: const EdgeInsets.only(
      bottom: 12
    ),
    child: Text(
      title,
      style: TextStyle(
        fontSize: screenWidth / 26,
      ),//TextStyle
      ), //Text,
  ); //Container
}

Widget userField(String hint, TextEditingController controller, bool obscure){
  bool flag = false;
  return Container(
                  width: screenWidth,
                  margin: EdgeInsets.only(bottom: 12),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 10,
                        offset: Offset(2, 2),
                      ) //BoxShadow
                    ]
                  ),//BoxDecoration
                  child: Row(
                    children: [
                      Container(
                        width: screenWidth / 6,
                        child: Icon(Icons.person,
                          color: primary,
                          size: screenWidth / 15,
                        ),//Icon
                      ), //Container
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(right: screenWidth / 12),
                          child: TextFormField(
                              validator: (value) {
                              if (value == null || value.isEmpty) {
                                flag = true;
                                return 'Please enter some text';
                              }
                              return null;
                            },
                          controller: controller,
                          enableSuggestions: false,
                          autocorrect: false,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                              vertical: screenHeight / 35,
                            ),
                            border: InputBorder.none,
                            hintText: hint,
                            hintStyle: TextStyle(color: Colors.black),
                          ), //inputDecoration
                          maxLines: 1,
                          obscureText: obscure,
                      ),//TextFormField), //Expanded
                        ), //Padding
                      )
                    ],
                  ), //ROW
                ); //Container
}

Widget emailField(String hint, TextEditingController controller, bool obscure){
  bool flag = false;
  return Container(
                  width: screenWidth,
                  margin: EdgeInsets.only(bottom: 12),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 10,
                        offset: Offset(2, 2),
                      ) //BoxShadow
                    ]
                  ),//BoxDecoration
                  child: Row(
                    children: [
                      Container(
                        width: screenWidth / 6,
                        child: Icon(Icons.email,
                          color: primary,
                          size: screenWidth / 15,
                        ),//Icon
                      ), //Container
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(right: screenWidth / 12),
                          child: TextFormField(
                              validator: (value) {
                              if (value == null || value.isEmpty) {
                                flag = true;
                                return 'Please enter some text';
                              }
                              return null;
                            },
                          controller: controller,
                          enableSuggestions: false,
                          autocorrect: false,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                              vertical: screenHeight / 35,
                            ),
                            border: InputBorder.none,
                            hintText: hint,
                            hintStyle: TextStyle(color: Colors.black),
                          ), //inputDecoration
                          maxLines: 1,
                          obscureText: obscure,
                      ),//TextFormField), //Expanded
                        ), //Padding
                      )
                    ],
                  ), //ROW
                ); //Container
}

Widget phoneField(String hint, TextEditingController controller, bool obscure){
  bool flag = false;
  return Container(
                  width: screenWidth,
                  margin: EdgeInsets.only(bottom: 12),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 10,
                        offset: Offset(2, 2),
                      ) //BoxShadow
                    ]
                  ),//BoxDecoration
                  child: Row(
                    children: [
                      Container(
                        width: screenWidth / 6,
                        child: Icon(Icons.phone,
                          color: primary,
                          size: screenWidth / 15,
                        ),//Icon
                      ), //Container
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(right: screenWidth / 12),
                          child: TextFormField(
                              validator: (value) {
                              if (value == null || value.isEmpty) {
                                flag = true;
                                return 'Please enter some text';
                              }
                              return null;
                            },
                          controller: controller,
                          enableSuggestions: false,
                          autocorrect: false,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                              vertical: screenHeight / 35,
                            ),
                            border: InputBorder.none,
                            hintText: hint,
                            hintStyle: TextStyle(color: Colors.black),
                          ), //inputDecoration
                          maxLines: 1,
                          obscureText: obscure,
                      ),//TextFormField), //Expanded
                        ), //Padding
                      )
                    ],
                  ), //ROW
                ); //Container
}

Widget passField(String hint, TextEditingController controller, bool obscure){
  bool flag = false;
  return Container(
                  width: screenWidth,
                  margin: EdgeInsets.only(bottom: 12),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 10,
                        offset: Offset(2, 2),
                      ) //BoxShadow
                    ]
                  ),//BoxDecoration
                  child: Row(
                    children: [
                      Container(
                        width: screenWidth / 6,
                        child: Icon(Icons.lock,
                          color: primary,
                          size: screenWidth / 15,
                        ),//Icon
                      ), //Container
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(right: screenWidth / 12),
                          child: TextFormField(
                              validator: (value) {
                              if (value == null || value.isEmpty) {
                                flag = true;
                                return 'Please enter some text';
                              }
                              return null;
                            },
                          controller: controller,
                          enableSuggestions: false,
                          autocorrect: false,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                              vertical: screenHeight / 35,
                            ),
                            border: InputBorder.none,
                            hintText: hint,
                            hintStyle: TextStyle(color: Colors.black),
                          ), //inputDecoration
                          maxLines: 1,
                          obscureText: obscure,
                      ),//TextFormField), //Expanded
                        ), //Padding
                      )
                    ],
                  ), //ROW
                ); //Container
}

Widget confirmPassField(String hint, TextEditingController controller, bool obscure){
  bool flag = false;
  return Container(
                  width: screenWidth,
                  margin: EdgeInsets.only(bottom: 12),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 10,
                        offset: Offset(2, 2),
                      ) //BoxShadow
                    ]
                  ),//BoxDecoration
                  child: Row(
                    children: [
                      Container(
                        width: screenWidth / 6,
                        child: Icon(Icons.lock,
                          color: primary,
                          size: screenWidth / 15,
                        ),//Icon
                      ), //Container
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(right: screenWidth / 12),
                          child: TextFormField(
                              validator: (value) {
                              if (value == null || value.isEmpty) {
                                flag = true;
                                return 'Please enter some text';
                              }
                              return null;
                            },
                          controller: controller,
                          enableSuggestions: false,
                          autocorrect: false,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                              vertical: screenHeight / 35,
                            ),
                            border: InputBorder.none,
                            hintText: hint,
                            hintStyle: TextStyle(color: Colors.black),
                          ), //inputDecoration
                          maxLines: 1,
                          obscureText: obscure,
                      ),//TextFormField), //Expanded
                        ), //Padding
                      )
                    ],
                  ), //ROW
                ); //Container
}
}