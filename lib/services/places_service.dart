import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

import '../features/screens/auth/models/user.dart';
import '../features/screens/nearby_places/models/offer.dart';
import '../features/screens/nearby_places/models/place.dart';
import 'auth_service.dart';


class PlaceService{
  Future<List<Place>> getAllPlaces() async {
    //returns all therapist from firestore collection
    List<Place> doc = [];
    try {
      FirebaseFirestore mFirebaseFirestore = FirebaseFirestore.instance;

      await mFirebaseFirestore.collection('places')
          .get()
          .then((snapshot) {
        snapshot.docs.forEach((element) {
          Place therapist = Place.fromJson(
              Map<String, dynamic>.from(element.data()));
          doc.add(therapist);
        });
      });
      // print('hiiiiiiii ${doc.length}');
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
    // navigatorKey.currentState!.popUntil((route)=>route.);
    // print(doc['nin']);
    return doc;
  }
  Future<List<Offer>> getAllOffers() async {
    //returns all therapist from firestore collection
    List<Offer> doc = [];
    try {
      FirebaseFirestore mFirebaseFirestore = FirebaseFirestore.instance;

      await mFirebaseFirestore.collection('offers')
          .get()
          .then((snapshot) {
        snapshot.docs.forEach((element) {
          Offer offer = Offer.fromJson(
              Map<String, dynamic>.from(element.data()));
          doc.add(offer);
        });
      });
      // print('hiiiiiiii ${doc.length}');
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
    // navigatorKey.currentState!.popUntil((route)=>route.);
    // print(doc['nin']);
    return doc;
  }

  addToFav(String? uid) async {
    User? user = FirebaseAuth.instance.currentUser;
    Auth auth = Auth();
    Users userDetails = await auth.getUserDetails();
    List? favs = [];
    userDetails.fav_placesId?.forEach((element) {
      favs.add(element);
    });
    favs.add(uid);
    Map<String,dynamic> fav ={
      'fav_placesId': favs
    };
    try{
      FirebaseFirestore mFirebaseFirestore = FirebaseFirestore.instance;

      await mFirebaseFirestore.collection('users')
          .doc(user?.uid)
          .update(fav)
          .then((snapshot)  async {
        // doc =  Users.fromJson(snapshot.docs[0].data()) ;
      });

    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
    // navigatorKey.currentState!.popUntil((route)=>route.);
    // print(doc['nin']);
  }
  removeFromFav(String? uid) async {
    User? user = FirebaseAuth.instance.currentUser;
    Auth auth = Auth();
    Users userDetails = await auth.getUserDetails();
    List? favs = [];
    userDetails.fav_placesId?.forEach((element) {
      if(element == uid){

      }else{
        favs.add(element);
      }
    });
    Map<String,dynamic> fav ={
      'fav_placesId': favs
    };
    try{
      FirebaseFirestore mFirebaseFirestore = FirebaseFirestore.instance;

      await mFirebaseFirestore.collection('users')
          .doc(user?.uid)
          .update(fav)
          .then((snapshot)  async {
        // doc =  Users.fromJson(snapshot.docs[0].data()) ;
      });

    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
    // navigatorKey.currentState!.popUntil((route)=>route.);
    // print(doc['nin']);
  }

}
