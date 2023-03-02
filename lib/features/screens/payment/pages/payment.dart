import 'package:dartfri/features/screens/appointment/models/appointment.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PaymentPage extends StatelessWidget {
  const PaymentPage({Key? key, required this.appointment}) : super(key: key);
 final Appointment appointment;
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      appBar: AppBar(
        title: Text('Make Payment'),
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
        children: [
               Text('Choose Payment Method',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w600),),
SizedBox(height: 20,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [

              Text('Amount :',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w600),),
              Text('(UGX)${appointment.amount}',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w600,color: Colors.green),),

            ],
          ),

          Container(
                 padding: EdgeInsets.all(20),
                 child: Row(
                   mainAxisAlignment: MainAxisAlignment.spaceAround,
                   children: [

                     SizedBox(
                       height: 150,
                       width: MediaQuery.of(context).size.width*0.4,
                       child: Card(
                         elevation: 5,
                         child: Column(
                           mainAxisAlignment: MainAxisAlignment.spaceAround,
                           children: [
                             Icon(Icons.money,size: 40,),
                             Text('Card')
                           ],
                         ),
                       ),
                     ),
                     SizedBox(
                       height: 150,
                       width: MediaQuery.of(context).size.width*0.4,
                       child: Card(
                         elevation: 5,
                         child: Column(
                           mainAxisAlignment: MainAxisAlignment.spaceAround,

                           children: [
                             Icon(Icons.wallet,size: 40,),
                             Text('Wallet')
                           ],
                         ),
                       ),
                     )
                   ],
                 ),
               )
        ],
      ),),
    ));
  }
}
