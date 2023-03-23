import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:simple_app_dev/constants/colors.dart';
import 'package:simple_app_dev/main.dart';
import 'package:simple_app_dev/screens/Photo.dart';
import '../constants/utils.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}
class _ProfileState extends State<Profile> {
  final user = FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context) {
    double baseWidth = 360;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    return SizedBox(
      width: double.infinity,
      child: SizedBox(
        width: double.infinity,
        height: 800*fem,
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration (
            color: Color(0xff19191c),
          ),
          child: Stack(
            children: [
              Positioned(
                left: 0*fem,
                top: 0*fem,
                child: Container(
                  width: 360*fem,
                  height: 795.69*fem,
                  decoration: const BoxDecoration (
                    color: Color(0xffffffff),
                  ),
                  child: Container(
                    width: double.infinity,
                    height: 803*fem,
                    decoration: const BoxDecoration (
                      color: Color(0xffffffff),
                    ),
                    child: Stack(
                      children: [
                        Positioned(
                          left: 0*fem,
                          top: 26.9984436035*fem,
                          child: Align(
                            child: SizedBox(
                              width: 360*fem,
                              height: 360*fem,
                              child: Image.asset(
                                'assets/images/cover.png',
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          left: 0.0015258789*fem,
                          top: 310*fem,
                          child: SizedBox(
                            width: 360*fem,
                            height: 450.62*fem,
                            child: Stack(
                              children: [
                                Positioned(
                                  left: 0*fem,
                                  top: 41.6922912598*fem,
                                  child: Align(
                                    child: SizedBox(
                                      width: 360*fem,
                                      height: 408.92*fem,
                                      child: Container(
                                        decoration: BoxDecoration (
                                          borderRadius: BorderRadius.circular(30),
                                          color: tdWhite,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  left: 44*fem,
                                  top: 97.0000019073*fem,
                                  child: SizedBox(
                                    width: 271*fem,
                                    height: 127*fem,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Container(
                                          padding: EdgeInsets.fromLTRB(26*fem, 0*fem, 26*fem, 16*fem),
                                          width: double.infinity,
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              Container(
                                                margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 0*fem, 5*fem),
                                                child: Text(
                                                  user.displayName ?? user.email!,
                                                  textAlign: TextAlign.center,
                                                  style: SafeGoogleFont (
                                                    decoration: TextDecoration.none,
                                                    'Poppins',
                                                    fontSize: 15*ffem,
                                                    fontWeight: FontWeight.w700,
                                                    height: 1.5*ffem/fem,
                                                    color: const Color(0xff000000),
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                constraints: BoxConstraints (
                                                  maxWidth: 219*fem,
                                                ),
                                                child: Text(
                                                  'My name is Lloyd , I like Photography and Films. Im a Student from USTP',
                                                  textAlign: TextAlign.center,
                                                  style: SafeGoogleFont (
                                                    decoration: TextDecoration.none,
                                                    'Poppins',
                                                    fontSize: 11*ffem,
                                                    fontWeight: FontWeight.w400,
                                                    height: 1.5*ffem/fem,
                                                    color: const Color(0xff6c7a9c),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          width: double.infinity,
                                          height: 40*fem,
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Container(
                                                margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 20*fem, 0*fem),
                                                child: TextButton(
                                                  onPressed: () {
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(builder: (context) => const PicturePage()
                                                        )
                                                    );
                                                  },
                                                  style: TextButton.styleFrom (
                                                    padding: EdgeInsets.zero,
                                                  ),
                                                  child: Container(
                                                    width: 146*fem,
                                                    height: double.infinity,
                                                    decoration: BoxDecoration (
                                                      color: tdRed,
                                                      borderRadius: BorderRadius.circular(50*fem),
                                                      boxShadow: [
                                                        BoxShadow(
                                                          color: const Color(0x7f5790df),
                                                          offset: Offset(0*fem, 10*fem),
                                                          blurRadius: 10*fem,
                                                        ),
                                                      ],
                                                    ),
                                                    child: Center(
                                                      child: Text(
                                                        'Photos',
                                                        textAlign: TextAlign.center,
                                                        style: SafeGoogleFont (
                                                          'Poppins',
                                                          fontSize: 13*ffem,
                                                          fontWeight: FontWeight.w500,
                                                          height: 1.5*ffem/fem,
                                                          color: const Color(0xffffffff),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              TextButton(
                                                onPressed: () {
                                                  FirebaseAuth.instance.signOut().then((value){
                                                      print("Signed Out");
                                                    }
                                                  );
                                                  Navigator.push(context,
                                                      MaterialPageRoute(builder: (context) => const SplashScreen()
                                                      )
                                                  );
                                                },
                                                style: TextButton.styleFrom (
                                                  padding: EdgeInsets.zero,
                                                ),
                                                child: Container(
                                                  width: 105*fem,
                                                  height: double.infinity,
                                                  decoration: BoxDecoration (
                                                    color: const Color(0xffffffff),
                                                    borderRadius: BorderRadius.circular(50*fem),
                                                    boxShadow: [
                                                      BoxShadow(
                                                        color: const Color(0x3f000000),
                                                        offset: Offset(0*fem, 10*fem),
                                                        blurRadius: 10*fem,
                                                      ),
                                                    ],
                                                  ),
                                                  child: Center(
                                                    child: Text(
                                                      'Sign Out',
                                                      textAlign: TextAlign.center,
                                                      style: SafeGoogleFont (
                                                        'Poppins',
                                                        fontSize: 13*ffem,
                                                        fontWeight: FontWeight.w500,
                                                        height: 1.5*ffem/fem,
                                                        color: const Color(0xff000000),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Positioned(
                                  left: 137.9999980927*fem,
                                  top: 0*fem,
                                  child: Align(
                                    child: SizedBox(
                                      width: 84*fem,
                                      height: 84*fem,
                                      child: Container(
                                        decoration: BoxDecoration (
                                          borderRadius: BorderRadius.circular(30),
                                          border: Border.all(color: const Color(0xffffffff)),
                                          image: const DecorationImage (
                                            fit: BoxFit.cover,
                                            image: AssetImage (
                                              'assets/images/avatar.jpg',
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Positioned(
                          // rectangle8EwU (136:110)
                          left: 0.0015258789*fem,
                          top: 750*fem,
                          child: Align(
                            child: SizedBox(
                              width: 360*fem,
                              height: 46*fem,
                              child: Container(
                                decoration: BoxDecoration (
                                  color: const Color(0xffffffff),
                                  borderRadius: BorderRadius.only (
                                    bottomRight: Radius.circular(31.3846111298*fem),
                                    bottomLeft: Radius.circular(31.3846111298*fem),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 0*fem,
                top: 0*fem,
                child: SizedBox(
                  width: 360*fem,
                  height: 45*fem,
                  child: Stack(
                    children: [
                      Positioned(
                        left: 0*fem,
                        top: 0*fem,
                        child: SizedBox(
                          width: 360*fem,
                          height: 45*fem,
                          child: Center(
                            child: SizedBox(
                              width: double.infinity,
                              height: 45*fem,
                              child: Container(
                                decoration: const BoxDecoration (
                                  color: tdRed,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                left: 0*fem,
                top: 27*fem,
                child: SizedBox(
                  width: 360*fem,
                  height: 45*fem,
                  child: Stack(
                    children: [
                      Positioned(
                        left: 0*fem,
                        top: 0*fem,
                        child: SizedBox(
                          width: 360*fem,
                          height: 45*fem,
                          child: Center(
                            child: SizedBox(
                              width: double.infinity,
                              height: 45*fem,
                              child: Container(
                                decoration: const BoxDecoration (
                                  color: tdRed,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                left: 0*fem,
                top: 0*fem,
                child: Align(
                  child: SizedBox(
                    width: 38*fem,
                    height: 100*fem,
                    child: TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      style: TextButton.styleFrom (
                        padding: EdgeInsets.zero,
                      ),
                      child: const Icon(
                        Icons.arrow_back_ios_new,
                        size: 25,
                        color: tdWhite,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}