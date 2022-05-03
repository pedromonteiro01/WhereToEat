import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({ Key? key }) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController idController = TextEditingController();
  TextEditingController passController = TextEditingController();
  double screenHeight = 0;
  double screenWidth = 0;

  Color primary = const Color(0xFF3D82AE);

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
                  usernameField("Enter your username", idController, false),
                  fieldTitle("Email"),
                  emailField("Enter your email", idController, false),
                  fieldTitle("Password"),
                  phoneField("Enter your phone", passController, false),
                  fieldTitle("Confirm your phone"),
                  passwordField("Enter your password", passController, true),
                  fieldTitle("Confirm Password"),
                  confirmPasswordField("Confirm your password", passController, true),
                  TextButton(
                    onPressed: (){
                      //Navigator.push(context, MaterialPageRoute(builder: (context) => const HomeScreen()));
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

Widget usernameField(String hint, TextEditingController controller, bool obscure){
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
                          child: TextField(
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
                          child: TextField(
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
                          child: TextField(
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

Widget passwordField(String hint, TextEditingController controller, bool obscure){
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
                          child: TextField(
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

Widget confirmPasswordField(String hint, TextEditingController controller, bool obscure){
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
                          child: TextField(
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