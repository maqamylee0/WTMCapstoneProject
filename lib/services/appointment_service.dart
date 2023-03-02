
import 'package:bot_toast/bot_toast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartfri/features/screens/dashboard/dashboard_page.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../features/screens/appointment/models/appointment.dart';
import '../features/screens/bookings/bookings_page.dart';


class AppointmentService{
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  late String appointmentId;
  // List appointments = [];

  Future<String>  makeAppointment(appointment,context) async {
    showDialog(context: context,barrierDismissible: false,
        builder: (context) => const Center(child: CircularProgressIndicator()));
    try{
      await firebaseFirestore
          .collection("appointment")
          .add(appointment.toJson()).then(
              (value) => appointmentId = value.id )
          .catchError((e){
        BotToast.showText(text: e!.message);


      });
      postAppointment(appointment,appointmentId);

      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>DashboardPage()));

    }catch(e){
      BotToast.showText(text:"Failed to make appointment");

    }
    return appointmentId;
    // Fluttertoast.showToast(msg: "Account created successfully :) ");

  }
  Future<void>  cancelAppointment(Appointment appointment,context) async {
    showDialog(context: context,barrierDismissible: false,
        builder: (context) => const Center(child: CircularProgressIndicator()));
    try{
      await firebaseFirestore
          .collection("appointment")
          .doc(appointment.appointmentId)
          .update({ 'status' : "cancelled"});
      Navigator.pop(context);
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>DashboardPage()));


    } catch (e) {
      if (kDebugMode) {
        Navigator.pop(context);

        print(e);
        BotToast.showText(text:"Failed to cancel appointment");

      }
    };
    }
  Future<void>  reshedule(Appointment appointment,context,data) async {
    showDialog(context: context,barrierDismissible: false,
        builder: (context) => const Center(child: CircularProgressIndicator()));
    try{
      await firebaseFirestore
          .collection("appointment")
          .doc(appointment.appointmentId)
          .update(data);
      Navigator.pop(context);
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>DashboardPage()));


    } catch (e) {
      if (kDebugMode) {
        Navigator.pop(context);

        print(e);
        BotToast.showText(text:"Failed to reshedule appointment");

      }
    };
  }

  Future<void> postAppointment(appointment, String appointmentId) async {
    try{
      await firebaseFirestore
          .collection("appointment")
          .doc(appointmentId)
          .update({'appointmentId':appointmentId});

    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    };
  }
    // Fluttertoast.showToast(msg: "Account created successfully :) ");


  Future<void>  makePayment(payment) async {
    try{
      await firebaseFirestore
          .collection("payment")
          .add(payment.toJson())
          .catchError((e){
        BotToast.showText(text: e!.message);
        BotToast.showText(text: "Payment made successfully :) ");


      });
    }catch(e){
      BotToast.showText(text: "Failed to make payment");

    }

  }

  Future<List<Appointment>>  getAppointments(userId) async {
    List<Appointment>  appointments= [];
    try{
      await firebaseFirestore
          .collection("appointment").where("userId" ,isEqualTo: userId )
          .get()
          .then((snapshot) {
        snapshot.docs.forEach((doc) {
          Appointment appointment = Appointment.fromJson(
              Map<String, dynamic>.from(doc.data()));
          appointments.add(appointment);

        });
      })
          .catchError((e){
        BotToast.showText(text: e!.message);

      });
    }catch(e){
      BotToast.showText(text: "Failed to get appointments");

    }
    return appointments;
  }
}