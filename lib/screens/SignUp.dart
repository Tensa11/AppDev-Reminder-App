import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:simple_app_dev/screens/MainHome.dart';
import 'package:simple_app_dev/screens/Login.dart';
import '../widgets/reusable_widget.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final TextEditingController _passwordTextController = TextEditingController();
  final TextEditingController _userNameTextController = TextEditingController();
  final TextEditingController _emailTextController = TextEditingController();

  Future addUser(String email, String username) async {
    final user = FirebaseAuth.instance.currentUser!;
    await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
      'uid': user.uid,
      'email': email,
      'username': username,
      // add other fields if needed
      }
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
              colors: [
                Color(0xFFDC1C13),
                Color(0xFFB21B45),
                Color(0xFF771A66),
                Color(0xFF3B1988),
              ], begin: Alignment.topCenter,end: Alignment.bottomCenter
          ),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(
                20, MediaQuery.of(context).size.height * 0.1, 20, 150),
            child: Column(
                children: <Widget>[
                  logoWidget('assets/images/Remind_Logo2.png'),
                  const SizedBox(
                    height: 10,
                  ),
                  reusableTextField('Enter Username', Icons.person_outline, false,
                      _userNameTextController),
                  const SizedBox(
                    height: 30,
                  ),
                  reusableTextField('Enter Email', Icons.mail_outline, false,
                      _emailTextController),
                  const SizedBox(
                    height: 30,
                  ),
                  reusableTextField('Enter Password', Icons.lock_outline, true,
                      _passwordTextController),
                  const SizedBox(
                    height: 20,
                  ),
                  signRegisterButton(context, false, () async {
                    await FirebaseAuth.instance.createUserWithEmailAndPassword(
                        email: _emailTextController.text,
                        password: _passwordTextController.text).then((value) {
                        addUser(
                            _emailTextController.text.trim(),
                            _userNameTextController.text.trim(),
                        );
                          print("New Account Created");
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context)=> const MainHome()
                              )
                          );
                        }
                      ).onError((error, stackTrace) {
                        print("Error ${error.toString()}");
                        }
                      );
                    }
                  ),
                  signUpOption()
                ]
            ),
          ),
        ),
      ),
    );
  }
  Row signUpOption(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [const
      Text("Already have an account?",
        style: TextStyle(color: Colors.white70),
      ),
        GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Login()
                )
            );
          },
          child: const Text(
            ' Login',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}
