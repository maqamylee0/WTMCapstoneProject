import 'package:dartfri/features/screens/appointment/models/appointment.dart';
import 'package:dartfri/features/screens/dashboard/dashboard_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:status_alert/status_alert.dart';

import '../../../../providers/appointment_provider.dart';
import '../../../../providers/user_provider.dart';
import '../../notifications/models/notifications.dart';
class PhoneInput extends StatelessWidget {
  PhoneInput ({Key? key, required this.appointment}) : super(key: key);
  final Appointment appointment;
TextEditingController _textFieldController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final appointmentProvider = Provider.of<AppointmentProvider>(context);
    final user = Provider.of<UserProvider>(context);

    return AlertDialog(
    title: Text('Enter PIN'),
content: TextField(
controller: _textFieldController,
decoration: InputDecoration(hintText: "22222"),
),
actions: [
new TextButton(
child: new Text('SUBMIT'),
onPressed: () {
  Notifications notification = Notifications();
  TimeOfDay _currentTime = TimeOfDay.now();
  String time = '${_currentTime.hour.toString().padLeft(2, '0')}:${_currentTime.minute.toString().padLeft(2, '0')} ${_currentTime.period.toString().split('.')[1].toUpperCase()}';

  notification.time = time;
  notification.title = 'Payment of ${appointment.amount}' ;
  notification.userId = user.user.uid;
  notification.from = appointment.placeName!;
  try{
    appointmentProvider.makeAppointment(appointment,context);

      user.sendNotification(notification);
  }catch(e){
    print('e');
  }
  StatusAlert.show(

    context,
    duration: Duration(seconds: 3),
    backgroundColor:Color(0xFFB0E3E8),
    title: 'Successful',
    subtitle: 'Payment Made',
    configuration: IconConfiguration(icon: Icons.done,size: 20),
    maxWidth: 200,



  );
  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>DashboardPage()));
},
)
],
);
  }
}

