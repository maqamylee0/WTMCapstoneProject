import 'package:dartfri/features/pageImports.dart';
import 'package:dartfri/features/screens/dashboard/dashboard_page.dart';
import 'package:dartfri/services/local_auth_fingerprint.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:status_alert/status_alert.dart';

import 'link_fingerprint.dart';
import 'login.dart';

class EnableFingerPrint extends StatelessWidget {
  const EnableFingerPrint({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SizedBox(
              height: 100,
                width: 100,
                child: Image.asset('assets/logo_white.png')),
            SizedBox(
              height: 180,
                width: 180,
                child: Image.asset('assets/Fingerprint.png')),
            Text('Use FingerPrint'),
            Text('Passwordless Login'),
            SizedBox(
              height: 42,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size.fromHeight(
                        55), // fromHeight use double.infinity as width and 40 is the height
                  ),
                  onPressed: () async {
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
                      Navigator.pushReplacement(
                          context, MaterialPageRoute(builder: (context) =>  DashboardPage()));
                    }

                  },
                  child:  Text(
                    'Continue',
                    style: TextStyle(color: Palette.secondaryDartfri),
                  )),
            ),
            TextButton(onPressed: (){
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => const LoginPage()));
            }, child: Text('Not now'))
          ],
        ),
      ),
    ));
  }
}
