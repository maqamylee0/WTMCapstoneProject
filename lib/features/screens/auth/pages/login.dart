import 'package:dartfri/features/screens/auth/pages/enable_fingerprint.dart';
import 'package:dartfri/features/screens/auth/pages/signup.dart';
import 'package:dartfri/features/screens/dashboard/dashboard_page.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:status_alert/status_alert.dart';

import '../../../../services/auth_service.dart';
import '../../../../services/local_auth_fingerprint.dart';
import 'forgot_password.dart';



class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var _passwordVisible;
  TextEditingController _userPasswordController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  Auth auth = Auth();
  final formKey = GlobalKey<FormState>();
  bool showSpinner = false;
   late var isSinedUp ;

  @override
  void initState() {
    super.initState();
    _passwordVisible = false;
    isSinedUp = FirebaseAuth.instance.currentUser;
    print('hhhhhhhhhhhhhhhhhhhh $isSinedUp');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            padding: const EdgeInsets.all(20),
            child: SingleChildScrollView(
                child: Form(
                  key: formKey,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 30),
                        Row(
                          children: [
                            SizedBox(
                              height: 120,
                                width: 120,
                                child: Image.asset('assets/logo_noback.png')),

                          ],
                        ),
                        Text(
                          "Welcome Back!",
                          style: Theme.of(context).textTheme.headline6,
                        ),
                        SizedBox(
                          height: 10,
                        ),

                        SizedBox(height: 70),
                        TextFormField(
                          keyboardType: TextInputType.text,
                          controller: _emailController,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (email) =>
                          email != null && EmailValidator.validate(email)
                              ? null
                              : "Enter valid Email",
                          decoration: InputDecoration(
                            labelText: 'Email Address',
                            hintText: 'johndoe@gmail.com',
                            border: OutlineInputBorder(),
                            // Here is key idea
                            suffixIcon: IconButton(
                              icon: Icon(Icons.person_outline),
                              color: Colors.grey,
                              onPressed: () {},
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          keyboardType: TextInputType.text,
                          controller: _userPasswordController,
                          obscureText: !_passwordVisible, //
                          // This will obscure text dynamically
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (password) =>
                          password != null && password.length > 6
                              ? null
                              : "Enter a minimum of 6 characters",
                          decoration: InputDecoration(
                            labelText: 'Password',
                            hintText: 'Enter your password',
                            border: OutlineInputBorder(),

                            // Here is key idea
                            suffixIcon: IconButton(
                              icon: Icon(
                                // Based on passwordVisible state choose the icon
                                _passwordVisible
                                    ? Icons.visibility
                                    : Icons.visibility_off_outlined,
                                color: Colors.grey,
                              ),
                              onPressed: () {
                                // Update the state i.e. toogle the state of passwordVisible variable
                                setState(() {
                                  _passwordVisible = !_passwordVisible;
                                });
                              },
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: 100,
                            ),
                            TextButton(
                                onPressed: () {
                                  onPressed2();
                                },
                                child: Text("Forgot your password?",
                                    style: TextStyle(color: Colors.red)))
                          ],
                        ),
                        SizedBox(height: 60),
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              minimumSize: Size.fromHeight(
                                  55), // fromHeight use double.infinity as width and 40 is the height
                            ),
                            onPressed: () {
                              onPressed(_emailController.text,
                                  _userPasswordController.text);
                            },
                            child: const Text(
                              'Login',
                              style: TextStyle(color: Colors.white),
                            )),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Don't have an Account?"),
                            TextButton(
                                onPressed: onPressed3, child: Text("Sign Up"))
                          ],
                        ),
                        (isSinedUp != null) ? Align(
                          alignment: Alignment.center,
                          child: TextButton(onPressed: () async {
    final isAuthenticated = await LocalAuthApi.authenticate();
    if (isAuthenticated){
    StatusAlert.show(
    context,
    duration: Duration(seconds: 2),
    title: 'Successful',
    subtitle: 'Successfully logged in',
    configuration: IconConfiguration(icon: Icons.done),
    maxWidth: 260,
    );
    Navigator.push(context,
        MaterialPageRoute(builder: (context) =>  DashboardPage()));
    }

                          }, child: Text('Use Fingerprint')),
                        ):Container()
                      ]),
                ))));
  }

  void onPressed(email, password) {
    final isValid = formKey.currentState!.validate();
    if (isValid) {
      auth.signIn(context, email, password);
    } else {
      return;
    }
  }

  void onPressed2() {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => const ForgotPasswordPage()));
  }

  void onPressed3() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const SignUpPage()));
  }
}
