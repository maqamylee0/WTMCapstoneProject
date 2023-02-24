import 'package:dartfri/features/pageImports.dart';
import 'package:dartfri/features/screens/auth/pages/signup_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChoosePage extends StatelessWidget {
  const ChoosePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          body: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.all(20),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children:[
                  SizedBox(
                    height: 128,
                      width: 120,
                      child: Image.asset('assets/logo_noback.png')),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.3,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              minimumSize: Size.fromHeight(
                                  45), // fromHeight use double.infinity as width and 40 is the height
                            ),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (
                                          context) => const SignUpPage()));
                            },
                            child: const Text(
                              'Find a Service Provider',
                              style: TextStyle(color: Colors.black),
                            )),
                        Column(
                          children: [
                            OutlinedButton(
                                style: OutlinedButton.styleFrom(
                                  side: BorderSide(color: Palette.primaryDartfri,width: 2),

                                  minimumSize: Size.fromHeight(
                                      45), // fromHeight use double.infinity as width and 40 is the height
                                ),

                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (
                                              context) => const SignUpPageProvider()));
                                },
                                child: const Text(
                                  'Become a Service Provider',
                                  style: TextStyle(color: Colors.black),
                                )),
                            Row(
                              children: [
                                Text('Already have an account?'),
                                TextButton(onPressed: (){
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (
                                              context) => const LoginPage()));

                                }, child: Text('Sign In'))
                              ],
                            )
                          ],
                        ),


                      ],
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height*0.1,
                  )

                ]
              ),
            ),
          ),
        )
    );
  }
}
