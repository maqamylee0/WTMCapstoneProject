import 'package:dartfri/providers/user_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:uuid/uuid.dart';
import '../features/screens/appointment/models/appointment.dart';
import '../features/screens/auth/models/user.dart';
import '../features/screens/nearby_places/models/place.dart';
import '../services/appointment_service.dart';
import '../services/auth_service.dart';
import '../services/places_service.dart';




class AppointmentProvider extends ChangeNotifier{
  List<Place> places = [];
  // List<Review> reviews = [] ;
  // late List<dynamic> reviewIds;
  late String? message ='' ;
  late Users user;
  String username ='';
  var _placeService;
  var _appointmentService = AppointmentService();
  UserProvider userProvider = UserProvider();
  late String appointmentId ;
  List appointments = [];
  Auth auth = Auth();


  AppointmentProvider(){
    _placeService = PlaceService();
    _appointmentService = AppointmentService();

    getAllPlaces();
    getUserDetails();
    // getAppointments();
  }

  // Future<void> setreviewid(List <dynamic> reviewIdss) async {
  //   reviewIds = reviewIdss;
  //   // await getTherapistReviews(reviewIds);
  //   notifyListeners();
  //
  // }

  String getAppointmentId(){
    return appointmentId;
  }
  // void setReview(List review){
  //   reviews = reviews;
  //   notifyListeners();
  // }
  void setMessage(String message){
    message = message;
    notifyListeners();
  }
  void setUsername(String username){
    username = username;
    notifyListeners();
  }

  Future<void> getAllPlaces() async {
    places = await _placeService.getAllPlaces();
    notifyListeners();
  }
  // Future<void> getTherapistReviews(List<dynamic> reviewIds) async {
  //   reviews = await _therapistService.getTherapistReviews(reviewIds);
  //
  //   // notifyListeners();
  //   message =  reviews[0].message;
  //   await getUser(reviews[0].userId);
  //   notifyListeners();
  // }
  Future<void> getPlace(String? uid) async {
    user = await _placeService.getUserDetails(uid);
    username = user.name!;
    // print('uuuuuuuuuuuuuuuuuuuuuuuuuuu ${user.uid}');

    // await getAppointments(user.uid);
    notifyListeners();
  }
  Future<Users> getUserDetails() async {
    user = await auth.getUserDetails();
    username = user.name!;
   return await user;
  }
  Future<void> makeAppointment(Appointment appointment,context) async {
    appointment.userName = user.name;
    appointment.userPhone = user.phone;

    appointmentId = await _appointmentService.makeAppointment(appointment,context);
    // username = user.name!;
    notifyListeners();
  }
  Future<void> cancelAppointment(Appointment appointment,context) async {

    await _appointmentService.cancelAppointment(appointment,context);
    // username = user.name!;
    notifyListeners();
  }
  Future<void> makePayment(payment) async {
    await _appointmentService.makePayment(payment);
    // username = user.name!;
    notifyListeners();
  }
  // List getAppointmentss()=> appointments;

  Future<List> getAppointments(String uid) async {

    appointments = await _appointmentService.getAppointments(uid);
    // username = user.name!;
    notifyListeners();
    // print('apppppppppppppppppppppppp ${appointments.length}');
    return appointments;
  }
}