import 'package:dartfri/features/pageImports.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:status_alert/status_alert.dart';

import '../../../../services/local_auth_fingerprint.dart';

class WalletPage extends StatefulWidget {
   WalletPage({Key? key}) : super(key: key);

  @override
  State<WalletPage> createState() => _WalletPageState();
}

class _WalletPageState extends State<WalletPage> {
   bool isVisible = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(children: [
                  // IconButton(onPressed: (){
                  //   Navigator.pop(context);
                  // }, icon:  Icon(Icons.arrow_back,size: 30,color: Palette.primaryDartfri,),),


                  SizedBox(width: 20,),
                  Text('Wallet',style: TextStyle(fontSize: 20),)
                ],),
                Row(children: [
                  Icon(CupertinoIcons.add_circled,color: Palette.primaryDartfri,),
                  SizedBox(width: 20,),

                  Text('Add Money',style: TextStyle(color: Palette.primaryDartfri),)
                ],),
              ],
            ),
            SizedBox(height: 30,),
            Container(
              padding: EdgeInsets.all(15),
              width: MediaQuery.of(context).size.width,
              height: 130,
              decoration: BoxDecoration(
                  color: Palette.primaryDartfri,
                  borderRadius: BorderRadius.circular(20)
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Available Balance',style: TextStyle(fontSize: 15,color: Palette.secondaryDartfri),),
                      isVisible ? IconButton(onPressed: () async {

      setState(() {
        isVisible = !isVisible;
      });
    } , icon: Icon(Icons.visibility,size: 50,color: Palette.secondaryDartfri,)):
                     IconButton(onPressed: () async {
                       final isAuthenticated = await LocalAuthApi.authenticate();

                       if (isAuthenticated) {

                         setState(() {
                           isVisible = !isVisible;
                         });
                       }
                     }, icon: Icon(Icons.visibility_off_outlined,size: 40,color: Palette.secondaryDartfri,))
                    ],
                  ),
                  SizedBox(height: 20,),
                  isVisible? Text('60000',style: TextStyle(fontSize: 20,color: Palette.secondaryDartfri),):Container()
                ],
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
