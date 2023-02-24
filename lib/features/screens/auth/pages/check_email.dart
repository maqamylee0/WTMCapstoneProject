import 'dart:async';

import 'package:bot_toast/bot_toast.dart';
import 'package:dartfri/features/screens/dashboard/dashboard_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:status_alert/status_alert.dart';

import 'login.dart';

class CheckMail extends StatefulWidget {
  const CheckMail({Key? key,required this.email}) : super(key: key);
final String? email;
  @override
  State<CheckMail> createState() => _CheckMailState();
}

class _CheckMailState extends State<CheckMail> {
  bool isVerified = false;
  bool canResend = false;
  Timer? timer;
  @override
  void initState() {
    super.initState();
    isVerified = FirebaseAuth.instance.currentUser!.emailVerified;

    if (!isVerified) {
      sendVerifyEmail();

      timer = Timer.periodic(
          Duration(seconds: 3),
              (_) => {
            checkEmailVerified(),
          });
    }
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(

      body:  isVerified
          ? const LoginPage():
      Container(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 100,),
            SizedBox(
                height: 200,
                width: 200,
                child: Image.asset('assets/romano.png')),
            Container(
              height: 200,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text('Email sent',style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500),),

                  Text('A '
                      ' link has been sent \n '
                      'to Blessinganyebe@gmail.com',style: TextStyle(fontSize: 16),),

                  SizedBox(
                    height: 42,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          minimumSize: Size.fromHeight(
                              55), // fromHeight use double.infinity as width and 40 is the height
                        ),
                        onPressed: () {
                          Navigator.push(
                              context, MaterialPageRoute(builder: (context) => const LoginPage()));
                        },
                        child: const Text(
                          'Resend',
                          style: TextStyle(color: Colors.black),
                        )),
                  ),
                ],
              ),
            ),
            SizedBox(height: 100,)
          ],
        ),
      ),
    ));
  }
  void onPressed2() {
    // if(currentText.toString() == widget.code.toString()){
    sendVerifyEmail();

    Navigator.push(context,
        MaterialPageRoute(builder: (context) => const DashboardPage()));
  }

  Future sendVerifyEmail() async {
    try {
      final user = FirebaseAuth.instance.currentUser!;
      await user.sendEmailVerification();
      setState(() {
        canResend = false;
      });
      await Future.delayed(Duration(seconds: 5));
      setState(() {
        canResend = true;
      });
    } on FirebaseAuthException catch (e) {
      print(e);
      BotToast.showText(text: '${e.message}');

      // Utils.showSnackBar(e.message);
    }
  }

  Future checkEmailVerified() async {
    await FirebaseAuth.instance.currentUser!.reload();
    setState(() {
      isVerified = FirebaseAuth.instance.currentUser!.emailVerified;
    });
    if (isVerified) timer?.cancel();
  }
}
