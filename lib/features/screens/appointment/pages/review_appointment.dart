import 'package:dartfri/features/screens/appointment/models/appointment.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../nearby_places/models/place.dart';
import '../../payment/pages/payment.dart';

class ReviewAppointment extends StatelessWidget {
   ReviewAppointment( {Key? key, required this.appointment,required this.place}) : super(key: key);
final Appointment appointment;
final Place place;

  @override
  Widget build(BuildContext context) {
    DateTime date = DateTime.parse(appointment.date!);

    return SafeArea(child: Scaffold(
      appBar: AppBar(
        title: Text('Review Booking'),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [


            Text('Date & Time :'),
            SizedBox(height: 5,),

            Text('${date.day} / ${date.month}/ ${date.year}',style: TextStyle(fontSize: 15,color: Colors.black,fontWeight: FontWeight.w600)),
            SizedBox(height: 5,),

            Text('${appointment.time}',style: TextStyle(fontSize: 15,color:Colors.black,fontWeight: FontWeight.w400)),

            SizedBox(height: 20,),
            Text('Washing Bay :'),
            SizedBox(height: 5,),
            Text('${place.name}',style: TextStyle(fontSize: 15,color: Colors.black,fontWeight: FontWeight.w600)),
            SizedBox(height: 5,),
            Text('${place.address}',style: TextStyle(fontSize: 15,color:Colors.black,fontWeight: FontWeight.w400)),

            SizedBox(height: 20,),
            Text('Car Selected :'),
            SizedBox(height: 5,),
            Text('${appointment.cartype}',style: TextStyle(fontSize: 15,color: Colors.black,fontWeight: FontWeight.w600)),
            SizedBox(height: 5,),
            SizedBox(height: 20,),
            Text('Car Wash :'),
            SizedBox(height: 5,),
            Text('${appointment.kind}',style: TextStyle(fontSize: 15,color: Colors.black,fontWeight: FontWeight.w600)),
            SizedBox(height: 5,),
            // Text('${appointment.kind}',style: TextStyle(fontSize: 15,color:Colors.black,fontWeight: FontWeight.w400)),

            SizedBox(height: 20,),
            Text('Payment Method :'),

            Container(
                margin: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black,
                      blurRadius: 2.0,
                      spreadRadius: 0.0,
                      offset: Offset(2.0, 2.0), // shadow direction: bottom right
                    )
                  ],
                ),
                child:  Row(
            children: [
            SizedBox(height:50,width: 50,

                child: Image.asset('assets/wallet.png')),
            // Icon(Icons.wallet,size: 30,),
            Text('Wallet')
          ],
        )
            ),
            SizedBox(height: 20,),
            Text('Services Selected'),
            SizedBox(height: 20,),

            Text('Washing Services',style: TextStyle(fontSize: 15,color: Colors.black,fontWeight: FontWeight.w600)),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('${appointment.kind}',style: TextStyle(fontSize: 15,color: Colors.black,fontWeight: FontWeight.w600)),
                Text('${appointment.amount}')

              ],
            ),
            SizedBox(height: 5,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Total',style: TextStyle(fontSize: 15,color: Colors.black,fontWeight: FontWeight.w600)),
                Text('${appointment.amount}'),

              ],
            ),
            SizedBox(height: 20,),
            SizedBox(
              height: 50,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size.fromHeight(
                        55), // fromHeight use double.infinity as width and 40 is the height
                  ),
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>PaymentPage()));
                  },
                  child: const Text(
                    'Proceed to Payment',
                    style: TextStyle(color: Colors.white),
                  )),
            ),
          ],
        ),
      ),
    ));
  }
}