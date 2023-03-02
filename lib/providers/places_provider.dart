import 'package:dartfri/features/screens/nearby_places/models/place.dart';
import 'package:flutter/cupertino.dart';

import '../features/screens/auth/models/user.dart';
import '../features/screens/nearby_places/models/offer.dart';
import '../services/auth_service.dart';
import '../services/places_service.dart';


class PlacesProvider extends ChangeNotifier {
  late PlaceService _placeService;
  late Auth _auth;
  List<Place> places = [];
  List<Offer> offers = [];

  List<Place> newPlaces = [];
  List<Offer> newOffers = [];

  List fav = [];
  bool search = false;
  String city = 'Entebbe, Uganda';

  PlacesProvider(){
    _placeService = PlaceService();
    _auth = Auth();
    getAllPlaces();
    getUserDetails();
    getAllOffers();
  }
  void setCity(String place){
    city = place;
    notifyListeners();
  }
  Future<void> getAllPlaces() async {
    places = await _placeService.getAllPlaces();
    newPlaces = places;
    notifyListeners();
  }
  Future<void> getAllOffers() async {
    offers = await _placeService.getAllOffers();
    newOffers = offers;
    notifyListeners();
  }
  void setSearch(bool bool){
    search = bool;
    if(!search){
      places = newPlaces;
    }
    notifyListeners();
  }

  void runFilter(String value)  {
    places = places.where((element) => element.name!.toLowerCase().contains(value.toLowerCase())).toList();
    notifyListeners();
  }


  Future<void> addToFav(Place place) async {
    await _placeService.addToFav(place.uid);
    await getUserDetails();
    notifyListeners();
  }
  Future<void> removeFromFav(Place blog) async {
    await _placeService.removeFromFav(blog.uid);
    await getUserDetails();
    notifyListeners();
  }



  Future<void> getUserDetails() async {
    Users user = await _auth.getUserDetails();
    List<String> favs = [];
    user.fav_placesId?.forEach((element) {
      favs.add(element);
    });
    fav = favs;
    notifyListeners();
  }
}
