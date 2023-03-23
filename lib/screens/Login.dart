import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:simple_app_dev/screens/SignUp.dart';
import 'package:simple_app_dev/screens/MainHome.dart';
import '../widgets/reusable_widget.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _passwordTextController = TextEditingController();
  final TextEditingController _emailTextController = TextEditingController();

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
                20, MediaQuery.of(context).size.height * 0.2, 20, 280),
            child: Column(
              children: <Widget>[
                GestureDetector(
                  onTap: () {}, // Image tapped
                  child: Image.asset(
                    'assets/images/Remind_Logo2.png',
                    fit: BoxFit.cover, // Fixes border issues
                    height: 100,
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                reusableTextField('Email', Icons.person_outline, false,
                    _emailTextController),
                const SizedBox(
                    height: 30,
                ),
                reusableTextField('Password', Icons.lock_outline, true,
                    _passwordTextController),
                const SizedBox(
                  height: 20,
                ),
                signRegisterButton(context, true, () async {
                  await FirebaseAuth.instance.signInWithEmailAndPassword(
                      email: _emailTextController.text,
                      password: _passwordTextController.text).then((value) {
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
      children: [
        GestureDetector(
          onTap: () {},
          child: const Text(
            "Don't have an account?",
            style: TextStyle(color: Colors.white70, fontWeight: FontWeight.bold),
          ),
        ),
        GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SignUp()
                )
            );
          },
          child: const Text(
            ' Sign Up',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}