
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'login.dart';

class ResetPage extends StatelessWidget {
  const ResetPage({Key? key, required this.email}) : super(key: key);
final String email;
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      
      body: Container(
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
                  Text('Reset link sent',style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500),),

                  Text('A reset password link has been sent \n '
                      'to $email )',style: TextStyle(fontSize: 16),),

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
                          'Login',
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
}
