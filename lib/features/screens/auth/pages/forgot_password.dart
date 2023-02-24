import 'package:dartfri/features/screens/auth/pages/reset_sent.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../services/auth_service.dart';


class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            padding: const EdgeInsets.all(20),
            child: SingleChildScrollView(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [

                    SizedBox(height: 50),
                    Text(
                      "Forgot Password!",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 25,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 10,
                    ),

                          Text(
                              "Please enter your e-mail address to get a link to "
                                  "reset your password",
                              style: TextStyle(fontSize: 12.5)),

                    SizedBox(height: 40),
                    TextFormField(
                      keyboardType: TextInputType.text,
                      controller: _emailController,
                      decoration: InputDecoration(
                        labelText: 'Email Address',
                        hintText: 'johndoe@gmail.com',
                        border: OutlineInputBorder(),
                        // Here is key idea
                        suffixIcon: IconButton(
                          icon: Icon(Icons.email_outlined),
                          color: Colors.grey,
                          onPressed: () {},
                        ),
                      ),
                    ),
                    SizedBox(height: 60),
                    SizedBox(
                      height: 42,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            minimumSize: Size.fromHeight(
                                55), // fromHeight use double.infinity as width and 40 is the height
                          ),
                          onPressed: () {
                            Navigator.push(
                                context, MaterialPageRoute(builder: (context) => ResetPage(email:_emailController.text)));
                            onPressed(_emailController.text, context);
                          },
                          child: const Text(
                            'Reset your Password',
                            style: TextStyle(color: Colors.black),
                          )),
                    ),
                  ]),
            )));
  }

  void onPressed(email, context) {
    Auth auth = Auth();
    auth.passwordReset(email, context);
  }
}
