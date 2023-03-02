import 'package:dartfri/features/pageImports.dart';
import 'package:dartfri/features/screens/appointment/pages/review_appointment.dart';
import 'package:dartfri/features/screens/bookings/bookings_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../../providers/appointment_provider.dart';
import '../../../../providers/user_provider.dart';
import '../../nearby_places/models/place.dart';
import '../models/appointment.dart';





class AppointmentFormPage extends StatefulWidget {
  const AppointmentFormPage({Key? key,  this.place}) : super(key: key);
  final Place? place;

  @override
  State<AppointmentFormPage> createState() => _AppointmentFormPageState();
}

class _AppointmentFormPageState extends State<AppointmentFormPage> {
  late int selectedRadioTile;
  late int selectedRadio;
  late int selectedRadioTile2;
  late int selectedRadio2;
  Appointment appointment = Appointment();

  TimeOfDay time = TimeOfDay(hour: 8, minute: 00);
  DateTime date = DateTime(2023);

  List<String> kind = ['Motocycle','Car(Small)','PickUp/Van','Bus/Truck','BigTrucks'];
  List<String> type = ['Interior','Exterior'];
  int _currentStep = 0;


  @override
  void initState() {
    super.initState();
    selectedRadio = 1;
    selectedRadioTile = 1;
    selectedRadio2 = 1;
    selectedRadioTile2 = 1;
    appointment.date = date.toString();
    appointment.time = time.toString();
  }
  setSelectedRadioTile2(int val) {
    setState(() {
      selectedRadioTile2 = val;

    });
  }
  setSelectedRadioTile(int val) {
    setState(() {
      selectedRadioTile = val;

    });
  }
  confirmAppointment(appointmentProvider){
    appointment.cartype = kind[selectedRadioTile-1];
    appointment.kind = type[selectedRadioTile2-1];
    // appointment.userId =
    appointment.placeName = widget.place?.name;
    appointment.status = 'pending';
    appointment.placeId = widget.place?.uid;
    // showAlertDialog(context, appointmentProvider);
    Navigator.push(context, MaterialPageRoute(builder: (context)=>ReviewAppointment(appointment:appointment,place:widget.place!)));
  }

  makeAppointment(appointmentProvider){
    appointment.kind = kind[selectedRadioTile-1];
    appointment.cartype = type[selectedRadioTile2-1];
    // appointment.userId =
    appointment.placeName = widget.place?.name;
    appointment.status = 'pending';
    appointment.placeId = widget.place?.uid;

    try{
      appointmentProvider.makeAppointment(appointment,context);
      // print('hiiiiiiiiiiiiiiiii ${appointment.kind}');
      // print('hiiiiiiiiiiiiiiiii ${appointment.type}');
      // print('hiiiiiiiiiiiiiiiii ${appointment.date}');
      // print('hiiiiiiiiiiiiiiiii ${appointment.time}');

    }catch(e){
      print('e');
    }
  }



  @override
  Widget build(BuildContext context) {

    final appointmentProvider = Provider.of<AppointmentProvider>(context);
    final userProvider = Provider.of<UserProvider>(context);
    appointment.userId = userProvider.user.uid;

    tapped(int step){
      setState(() => _currentStep = step);
    }

    continued(){
      _currentStep == 2 ? confirmAppointment(appointmentProvider) : null;

      _currentStep < 2 ?
      setState(() => _currentStep += 1): null;
    }
    cancel(){
      _currentStep > 0 ?
      setState(() => _currentStep -= 1) : null;
    }


    return SafeArea(
      child:
      Scaffold(
        appBar: AppBar(
          title: Text('Book Appointment'),
        ),
        body:
        SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            padding: EdgeInsets.all(20),


                child:Form(
                  child: Stepper(

                        physics: ScrollPhysics(),
                        currentStep: _currentStep,
                        onStepTapped: (step) => tapped(step),
                        onStepContinue: continued,
                        onStepCancel: cancel,
                        type: StepperType.horizontal,

                        steps: <Step>[
                          Step(
                            title: new Text('Car'),

                            content: SizedBox(
                              height: MediaQuery.of(context).size.height * 0.5,
                              child: Column(
                                children: <Widget>[
                                  Text("1. Which type of car do you have ?",style:TextStyle(fontWeight: FontWeight.w600,fontSize:17 ),),

                                  Expanded(
                                    child: RadioListTile(
                                      value: 1,
                                      groupValue: selectedRadioTile,
                                      contentPadding: EdgeInsets.all(0),
                                      title: Container(
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text('Motocycle'),
                                            Icon(Icons.motorcycle)
                                          ],
                                        ),
                                      ),
                                      dense: true,

                                      // subtitle: Text("Radio 1 Subtitle"),
                                      onChanged: (val) {
                                        print("Radio Tile pressed $val");
                                        setSelectedRadioTile(val!);
                                      },
                                      activeColor: Palette.primaryDartfri,
                                      // secondary: OutlineButton(
                                      //   child: Text("Say Hi"),
                                      //   onPressed: () {
                                      //     print("Say Hello");
                                      //   },
                                      // ),
                                      selected: true,
                                    ),
                                  ),

                                  Expanded(
                                    child: RadioListTile(
                                      value: 2,
                                      groupValue: selectedRadioTile,
                                      title: Container(
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text('Car(Small Size)'),
                                            Icon(CupertinoIcons.car_detailed)
                                          ],
                                        ),
                                      ),
                                      contentPadding: EdgeInsets.all(0),
                                      dense: true,

                                      // subtitle: Text("Radio 2 Subtitle"),
                                      onChanged: (val) {
                                        print("Radio Tile pressed $val");
                                        setSelectedRadioTile(val!);
                                      },
                                      activeColor: Colors.cyanAccent,
                                      // secondary: OutlineButton(
                                      //   child: Text("Say Hi"),
                                      //   onPressed: () {
                                      //     print("Say Hello");
                                      //   },
                                      // ),
                                      selected: false,
                                    ),
                                  ),
                                  Expanded(
                                    child: RadioListTile(
                                      value: 3,
                                      groupValue: selectedRadioTile,
                                      title: Container(
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text('PickUp /Van'),

                                            Icon(CupertinoIcons.car)
                                          ],
                                        ),
                                      ),
                                      contentPadding: EdgeInsets.all(0),
                                      dense: true,
                                      // subtitle: Text("Radio 2 Subtitle"),
                                      onChanged: (val) {
                                        print("Radio Tile pressed $val");
                                        setSelectedRadioTile(val!);
                                      },
                                      activeColor: Palette.primaryDartfri,
                                      // secondary: OutlineButton(
                                      //   child: Text("Say Hi"),
                                      //   onPressed: () {
                                      //     print("Say Hello");
                                      //   },
                                      // ),
                                      selected: false,
                                    ),
                                  ),
                                  Expanded(
                                    child: RadioListTile(
                                      value: 4,
                                      groupValue: selectedRadioTile,
                                      title: Container(
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text('Bus / Truck'),
                                            Icon(CupertinoIcons.bus)
                                          ],
                                        ),
                                      ),
                                      contentPadding: EdgeInsets.all(0),
                                      dense: true,
                                      // subtitle: Text("Radio 2 Subtitle"),
                                      onChanged: (val) {
                                        print("Radio Tile pressed $val");
                                        setSelectedRadioTile(val!);
                                      },
                                      activeColor: Palette.primaryDartfri,
                                      // secondary: OutlineButton(
                                      //   child: Text("Say Hi"),
                                      //   onPressed: () {
                                      //     print("Say Hello");
                                      //   },
                                      // ),
                                      selected: false,
                                    ),
                                  ),
                                  Expanded(
                                    child: RadioListTile(
                                      value: 5,
                                      groupValue: selectedRadioTile,
                                      title: Container(
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text('Big Trucks'),
                                            Icon(Icons.fire_truck)
                                          ],
                                        ),
                                      ),
                                      contentPadding: EdgeInsets.all(0),
                                      dense: true,
                                      // subtitle: Text("Radio 2 Subtitle"),
                                      onChanged: (val) {
                                        print("Radio Tile pressed $val");
                                        setSelectedRadioTile(val!);
                                      },
                                      activeColor: Palette.primaryDartfri,
                                      // secondary: OutlineButton(
                                      //   child: Text("Say Hi"),
                                      //   onPressed: () {
                                      //     print("Say Hello");
                                      //   },
                                      // ),
                                      selected: false,
                                    ),
                                  )
                                ],
                              ),
                            ),
                            isActive: _currentStep >= 0,
                            state: _currentStep >= 0 ?
                            StepState.complete : StepState.disabled,
                          ),


                          Step(
                            title: new Text('Wash'),
                            content: SizedBox(
                              height: MediaQuery.of(context).size.height * 0.2,
                              child: Column(
                                children: [

                                  Text("2. Which king of wash Interior or Exterior ?",style:TextStyle(fontWeight: FontWeight.w600,fontSize:17 ),),
                                  Container(
                                    width: MediaQuery.of(context).size.width,
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: RadioListTile(
                                            value: 1,
                                            groupValue: selectedRadioTile2,
                                            contentPadding: EdgeInsets.all(0),
                                            title: Text("Interior"),
                                            dense: true,

                                            // subtitle: Text("Radio 1 Subtitle"),
                                            onChanged: (val) {
                                              print("Radio Tile pressed $val");
                                              setSelectedRadioTile2(val!);
                                            },
                                            activeColor: Palette.primaryDartfri,
                                            // secondary: OutlineButton(
                                            //   child: Text("Say Hi"),
                                            //   onPressed: () {
                                            //     print("Say Hello");
                                            //   },
                                            // ),
                                            selected: true,
                                          ),
                                        ),

                                        Expanded(
                                          child: RadioListTile(
                                            value: 2,
                                            groupValue: selectedRadioTile2,
                                            title: Text("Exterior"),
                                            contentPadding: EdgeInsets.all(0),
                                            dense: true,

                                            // subtitle: Text("Radio 2 Subtitle"),
                                            onChanged: (val) {
                                              print("Radio Tile pressed $val");
                                              setSelectedRadioTile2(val!);
                                            },
                                            activeColor: Palette.primaryDartfri,
                                            // secondary: OutlineButton(
                                            //   child: Text("Say Hi"),
                                            //   onPressed: () {
                                            //     print("Say Hello");
                                            //   },
                                            // ),
                                            selected: false,
                                          ),
                                        ),
                                ],
                              ),
                                  )]
                                  ),
                            ),
                            isActive: _currentStep >= 0,
                            state: _currentStep >= 1 ?
                            StepState.complete : StepState.disabled,
                          ),
                          Step(
                            title: new Text('Schedule'),
                            content: SizedBox(
                              height: MediaQuery.of(context).size.height * 0.5,
                              child: Column(
                                children: <Widget>[
                                  Text("3. Set the date and time for appointment",style:TextStyle(fontWeight: FontWeight.w600,fontSize:17 ),),

                                  SizedBox(height: 25,),

                                      Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Row(children:[
                                          GestureDetector(
                                            onTap: (){
                                              _showDatePicker();

                                            },
                                            child: SizedBox(
                                              height: MediaQuery.of(context).size.height*0.18,
                                              width: MediaQuery.of(context).size.width *0.5,
                                              child: Card(
                                                elevation: 5,
                                                child: Container(
                                                  padding: EdgeInsets.all(20),

                                                    child: Column(
                                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                      children: [
                                                        Text(" Date",style:TextStyle(fontWeight: FontWeight.w600,fontSize:15 ),),
                                                        Icon(CupertinoIcons.calendar,size: 40,),
                                                        Text("${date.day} / ${date.month} / ${date.year}")

                                                      ],
                                                    )),
                                              ),
                                            ),
                                          ),

                                ],
                                      ),),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(children:[
                                          GestureDetector(
                                            onTap: (){
                                              _showTimePicker();

                                            },
                                            child: SizedBox(
                                              height: MediaQuery.of(context).size.height*0.18,
                                              width: MediaQuery.of(context).size.width *0.5,
                                              child: Card(
                                                elevation: 5,
                                                child: Container(
                                                    padding: EdgeInsets.all(20),

                                                    child: Column(
                                                      mainAxisAlignment: MainAxisAlignment.spaceAround,

                                                      children: [
                                                        Text(" Time",style:TextStyle(fontWeight: FontWeight.w600,fontSize:15 ),),
                                                        Icon(CupertinoIcons.time,size: 40,),
                                                        Text("${time.format(context).toString()}")

                                                      ],
                                                    )),
                                              ),
                                            ),



                                      ),
                                    ],)
                                  ),

                                  // Row(
                                  //   children: [
                                  //     IconButton(
                                  //       icon: Icon(Icons.arrow_drop_down),
                                  //       color: Colors.grey,
                                  //       onPressed: () {
                                  //
                                  //       },
                                  //     ),
                                  //   ],
                                  // ),
                                  // Divider(
                                  //   indent: 10,
                                  //   endIndent: 10,
                                  //   color: Colors.grey,
                                  // ),

                                  // Row(
                                  //   children: [
                                  //     IconButton(
                                  //       icon: Icon(Icons.arrow_drop_down),
                                  //       color: Colors.grey,
                                  //       onPressed: () {
                                  //         _showTimePicker();
                                  //
                                  //       },
                                  //     ),
                                  //   ],
                                  // ),
                                  // Divider(
                                  //   indent: 10,
                                  //   endIndent: 10,
                                  //   color: Colors.grey,
                                  // ),

                                ],
                              ),
                            ),
                            isActive:_currentStep >= 0,
                            state: _currentStep >= 2 ?
                            StepState.complete : StepState.disabled,
                          ),

                        ],
                      ),
                ),


                ),
        ),
            ),
          );


   // );
  }

  _showDatePicker(){
    showDatePicker(context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2022),
        lastDate: DateTime(2025)
    ).then((value) =>
        setState((){
          date  = value!  ;
          appointment.date = value!.toString();

        }
        ));
  }
  _showTimePicker(){
    showTimePicker(context: context, initialTime: TimeOfDay.now()).then((value) =>
        setState((){
          time  = value! ;
          date = DateTime(value!.hour,value!.minute);
          String min;
          String hr;
          if(value!.hour < 10){
            hr = '0${value!.hour}';
          }else{
            hr = value!.hour.toString();
          }
          if(value!.minute < 10 ) {
            min = '0${value!.minute}';
          }
          else{
            min = value!.minute.toString();
          }
          appointment.time = "${hr}:${min} ${time.period.toString().split('.')[1].toUpperCase()}" ;
        }
        ));

  }
  showAlertDialog(BuildContext context,appointmentProvider) {

      DateTime date = DateTime.parse(appointment.date!);
      // var formatter = new DateFormat("yyyy-MM-dd'T'HH:mm:ss'Z'", 'en');

      // DateTime tempDate =Intl.withLocale('en', () => new DateFormat("yyyy-MM-dd hh:mm").parse(appointment.date!));
      // var formattedDate = DateFormat('EEEE, MMM d, yyyy').format(date);

      // DateFormat('MMMM d, y', 'en_US').parse(appointment.date!);
    // set up the button
    Widget okButton = TextButton(
      child: Text("OK"),
      onPressed: () {
        makeAppointment(appointmentProvider);
      },
    );
    Widget cancelButton = TextButton(
      child: Text("CANCEL"),
      onPressed: () {
        Navigator.pop(context);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Review Appointment"),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [





          Text('Date & Time :'),
          SizedBox(height: 5,),

          Text('${date.day} / ${date.month}/ ${date.year}',style: TextStyle(fontSize: 15,color: Colors.black,fontWeight: FontWeight.w600)),
          SizedBox(height: 5,),

          Text('${appointment.time}',style: TextStyle(fontSize: 15,color:Colors.black,fontWeight: FontWeight.w600)),

          SizedBox(height: 20,),
          Text('Washing Bay :'),
          SizedBox(height: 5,),

          Text('${widget.place?.name}',style: TextStyle(fontSize: 15,color: Colors.black,fontWeight: FontWeight.w600)),
          SizedBox(height: 5,),
         Text('${widget.place?.address}',style: TextStyle(fontSize: 15,color:Colors.black,fontWeight: FontWeight.w600)),






        SizedBox(height: 20,),

              Text('Car Selected :'),
          SizedBox(height: 5,),

          Text('${kind[selectedRadioTile-1]}',style: TextStyle(fontSize: 15,color:Colors.black,fontWeight: FontWeight.w600)),
          SizedBox(height: 20,),

          Text('Pick Up Address :'),
          SizedBox(height: 5,),

          Text('${'_'}',style: TextStyle(fontSize: 15,color:Colors.black,fontWeight: FontWeight.w600)),
          SizedBox(height: 20,),

          Text('Delivery Address :'),
          SizedBox(height: 5,),

          Text('${'_'}',style: TextStyle(fontSize: 15,color:Colors.black,fontWeight: FontWeight.w600)),
          SizedBox(height: 20,),

          Text('Total Cost :'),
          SizedBox(height: 5,),

          Text('${appointment.amount}',style: TextStyle(fontSize: 20,color:Palette.primaryDartfri,fontWeight: FontWeight.w600))


        ],
      ),
      actions: [

        cancelButton,
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
