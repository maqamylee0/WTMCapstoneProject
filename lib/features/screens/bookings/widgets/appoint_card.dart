import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../appointment/models/appointment.dart';
import 'appoint_button.dart';

class AppointmentCard extends StatefulWidget {
  const AppointmentCard({Key? key, required this.appointment, required this.action,}) : super(key: key);
  final Appointment appointment;
  final String action;


  @override
  State<AppointmentCard> createState() => _AppointmentCardState();
}



class _AppointmentCardState extends State<AppointmentCard> {
  @override
  void initState() {

    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    var totalWidth = MediaQuery.of(context).size.width;
    var datetime = DateTime.parse(widget.appointment.date!);

    return Card(
      child: Container(
        padding: EdgeInsets.all(5),
        width: totalWidth*0.6,
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                      image: DecorationImage(image: AssetImage("assets/offer.png"), fit: BoxFit.contain),
                      borderRadius: BorderRadius.circular(10)
                  ),
                  height: 120,
                  width: 100,

                ),
                SizedBox(width: 10,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Text('${widget.appointment.placeName}'),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Text('Amount : ${widget.appointment.amount}',style: TextStyle(color: Colors.grey),),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            Icon(Icons.calendar_month_rounded),
                            Text("${datetime.year}/${datetime.month}/${datetime.day}")
                          ],
                        ),

                        SizedBox(width: 20,),
                        Column(
                          children: [
                            Icon(Icons.timer),
                            Text('${widget.appointment.time}')

                          ],
                        )
                      ],
                    )
                  ],
                )
              ],
            ),
            SizedBox(height: 5,),
            Container(
              // width: totalWidth * 0.6,
              child: Row(
               mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [

                  (widget.action == 'cancel') ? Appointment_button(title:"Reschedule",appointment:widget.appointment):Container(),
                  (widget.action == 'active') ? Appointment_button(title:"Cancel Appointment",appointment:widget.appointment):Container(),
                  (widget.appointment.paid == false && widget.action == 'active') ? Appointment_button(title:"PAY",appointment:widget.appointment):Container(),

                ],
              ),
            )
          ],
        ),

      ),
    );
  }
}


