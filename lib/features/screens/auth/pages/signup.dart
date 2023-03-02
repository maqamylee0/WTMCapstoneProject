import 'package:bot_toast/bot_toast.dart';
import 'package:dartfri/features/pageImports.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

import '../../../../services/auth_service.dart';
import '../models/user.dart';
import 'login.dart';



class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  bool showSpinner = false;
  static late final User? user;
  final _auth = FirebaseAuth.instance;
  Auth auth = Auth();
  String? errorMessage;

  var _passwordVisible;
  var _checkboxValue;
  TextEditingController _userPasswordController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  final TextEditingController controller = TextEditingController();

  String initialCountry = 'NG';
  PhoneNumber number = PhoneNumber(isoCode: 'NG');
  String phone = "9900265566";
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _passwordVisible = false;
    _checkboxValue = false;
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
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(height: 50),

                            Align(
                              alignment: Alignment.center,
                              child: Text(
                                "Create a DatFri Account",
                                style: Theme.of(context).textTheme.headline6,
                              ),
                            ),

                        // SizedBox(
                        //   height: 2,
                        // ),
                        SizedBox(height: 50),

                        SizedBox(
                          height: 70,
                          child: TextFormField(
                            keyboardType: TextInputType.text,
                            controller: _nameController,
                            validator: (name) =>
                            name != null ? null : "Enter full name",
                            decoration: InputDecoration(
                              labelText: 'Full name',
                              hintText: 'John Doe',
                              border: OutlineInputBorder(),
                              // Here is key idea
                              suffixIcon: IconButton(
                                icon: Icon(Icons.person_outline),
                                color: Colors.grey,
                                onPressed: () {},
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        Stack(
                          children:[
                            Container(
                            padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                            decoration: BoxDecoration(
                              // border: Border.all(color: Colors.grey)
                            ),
                            child: InternationalPhoneNumberInput(


                              onInputChanged: (PhoneNumber number) {
                                print(number.phoneNumber);
                              },
                              // onInputValidated: (bool value) {
                              //   print(value);
                              // },
                              selectorConfig: const SelectorConfig(
                                selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
                              ),
                              hintText: "772024843",
                              ignoreBlank: false,
                              autoValidateMode: AutovalidateMode.disabled,
                              selectorTextStyle: TextStyle(color: Colors.black),
                              initialValue: number,
                              textFieldController: controller,
                              formatInput: false,
                              inputBorder: InputBorder.none,
                              keyboardType:
                              TextInputType.numberWithOptions(signed: true, decimal: true),
                              onSaved: (PhoneNumber number) {
                                print('On Saved: $number');
                              },
                            ),
                          ),
                            Positioned(
                              top: 17,
                              left: 90,
                              height: 30,
                              child: VerticalDivider(
                                color: Palette.primaryDartfri,
                                thickness: 0.8,
                              ),
                            )
                          ]
                        ),


                        SizedBox(height: 20),

                        SizedBox(
                          height: 70,
                          child: TextFormField(
                            keyboardType: TextInputType.text,
                            controller: _emailController,
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
                                icon: Icon(Icons.email_outlined),
                                color: Colors.grey,
                                onPressed: () {},
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 20),

                        SizedBox(
                          height: 70,
                          child: TextFormField(
                            keyboardType: TextInputType.text,
                            controller: _userPasswordController,
                            autovalidateMode: AutovalidateMode.onUserInteraction,
                            validator: (password) =>
                            password != null && password.length > 6
                                ? null
                                : "Enter a minimum of 6 characters",
                            obscureText:
                            !_passwordVisible, //This will obscure text dynamically
                            decoration: InputDecoration(
                              labelText: 'Password',
                              hintText: 'Min of 6 characters',
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
                        ),
                        SizedBox(height: 20),

                        // SizedBox(height:3,),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Checkbox(
                                  value: _checkboxValue,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      _checkboxValue = value;
                                    });
                                  }),
                              RichText(
                                text: TextSpan(
                                  // Here is the explicit parent TextStyle
                                  style: new TextStyle(
                                    fontSize: 16.0,
                                    color: Colors.black,
                                    fontFamily: 'Montserrat',
                                  ),
                                  children: <TextSpan>[
                                    new TextSpan(
                                        text: 'I agree to the ',
                                        style: TextStyle(fontSize: 12)),
                                    new TextSpan(
                                        text: ' terms and services',
                                        style: new TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 12)),
                                    new TextSpan(
                                        text: ' and',
                                        style: new TextStyle(
                                            fontSize: 10)),
                                    new TextSpan(
                                        text: ' \n privacy policy',
                                        style: new TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 12))
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 60),
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              minimumSize: Size.fromHeight(
                                  55), // fromHeight use double.infinity as width and 40 is the height
                            ),
                            onPressed: () {
                              onPressed();
                            },
                            child: const Text(
                              'Sign up',
                              style: TextStyle(color: Colors.white),
                            )),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Have an Account?"),
                            TextButton(
                                onPressed: () {
                                  onPressed2();
                                },
                                child: Text("Sign in"))
                          ],
                        )
                      ]),
                ))));
  }

  void onPressed2() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const LoginPage()));
  }

  void onPressed() {
    final isValid = formKey.currentState!.validate();

    if (isValid && _checkboxValue == true) {
      Users userModel = Users();
      // writing all the values

      userModel.name = _nameController.text;
      userModel.phone = controller.text;
      print(userModel);

      auth.signUp(_emailController.text, _userPasswordController.text,
          userModel, context);
      errorMessage = auth.errorMessage;
    } else {
      BotToast.showText(text: "Allow terms and conditions and fill all fields");

    }
   }
}
