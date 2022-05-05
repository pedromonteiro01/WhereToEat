import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:mapbox_navigation/screens/home_management.dart';
import 'package:mapbox_navigation/screens/register.dart';
import 'package:mapbox_navigation/ui/splash.dart';
import 'package:mapbox_navigation/constants/restaurants.dart';
import 'dart:io';

class LoginScreen extends StatefulWidget {
  const LoginScreen({ Key? key }) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController idController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController _controller = TextEditingController();
  double screenHeight = 0;
  double screenWidth = 0;

  Color primary = const Color(0xFF3D82AE);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    function();
  }

  void function(){
    getUsers();
    sleep(Duration(seconds: 1));
  }

  @override
  Widget build(BuildContext context) {
    //final bool isKeyboardVisible = KeyboardVisibilityProvider.isKeyboardVisible(context);
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height-48;
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      body: Column(
        children: [Container(
            height: screenHeight / 3,
            width: screenWidth,
            decoration: BoxDecoration(
              color: primary,
              borderRadius: const BorderRadius.only(
                bottomRight: Radius.circular(70),
              ), // BorderRadius
            ), // BoxDecoration
            child: Center(
              child: Image.asset('assets/image/logo_png.png'), //Image
              ), // Center
            ),// Container
            Container(
              alignment: Alignment.centerLeft,
              margin: EdgeInsets.symmetric(
                vertical: screenHeight / 15,
                horizontal: screenWidth / 12
                ), // EdgeInsets
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  fieldTitle("Username"),
                  userField("Enter your username", idController, false),
                  fieldTitle("Password"),
                  passField("Enter your password", passController, true),
                  TextField(readOnly: true, controller: _controller,style: TextStyle(color: Colors.red, fontSize: 15), textAlign: TextAlign.center,),
                  TextButton(
                    onPressed: (){
                      for (int i=0; i<users.length; i++){
                        if(idController.text == users[i]['username'] && passController.text == users[i]['password']){
                          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const Splash()), (Route<dynamic> route) => false);
                        }
                      }
                      _controller.text="Wrong credentials!";
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
                          "Login",
                          style: TextStyle(
                            fontSize: screenWidth / 22,
                            color: Colors.white,
                            letterSpacing: 2
                          ), //TextStyle
                        ), //Text
                      ), //Center
                    ),
                  ), //Container
                  Container(
                    padding: EdgeInsets.only(top: 2,),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Not registered?",  style: TextStyle(
                                color: Colors.black,
                              ),),
                              TextButton(onPressed: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context) => const RegisterPage()));
                              }, 
                              child: Text("Register Here"))
                            ],
                  ),
                  )
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
                          style: TextStyle(
                            color: Colors.black
                          ),
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
                          style: TextStyle(
                            color: Colors.black
                          ),
                      ),//TextFormField), //Expanded
                        ), //Padding
                      )
                    ],
                  ), //ROW
                ); //Container
}
}