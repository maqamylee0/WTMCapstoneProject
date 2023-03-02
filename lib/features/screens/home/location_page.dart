import 'package:bot_toast/bot_toast.dart';
import 'package:dartfri/features/pageImports.dart';
import 'package:dartfri/features/screens/dashboard/dashboard_page.dart';
import 'package:dartfri/features/screens/home/data.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:provider/provider.dart';

import '../../../keys.dart';
import '../../../providers/places_provider.dart';
import '../../../providers/user_provider.dart';
import '../nearby_places/pages/nearby_places.dart';
import '../wallet/pages/wallet_page.dart';

class LocationPage extends StatefulWidget {
   LocationPage({Key? key}) : super(key: key);

  @override
  State<LocationPage> createState() => _LocationPageState();
}

class _LocationPageState extends State<LocationPage> {
  String? _currentAddress;

  Position? _currentPosition;
  bool loading = false;
  @override
  Widget build(BuildContext context) {

    final places = Provider.of<PlacesProvider>(context);
    final users = Provider.of<UserProvider>(context);


    Future<bool> _handleLocationPermission() async {
      bool serviceEnabled;
      LocationPermission permission;

      serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('Location services are disabled. Please enable the services')));
        return false;
      }
      permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Location permissions are denied')));
          return false;
        }
      }
      if (permission == LocationPermission.deniedForever) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('Location permissions are permanently denied, we cannot request permissions.')));
        return false;
      }
      return true;
    }
    Future<void> _getAddressFromLatLng(Position position) async {
      await placemarkFromCoordinates(
          _currentPosition!.latitude, _currentPosition!.longitude)
          .then((List<Placemark> placemarks) {
        Placemark place = placemarks[0];
        setState(() {
          _currentAddress =
          ' ${place.subAdministrativeArea}';
          print('${_currentAddress},${_currentPosition}');
         users.setAddress(_currentAddress!);
        });
      }).catchError((e) {
        debugPrint(e.toString());
      });
    }

    Future<void> _getCurrentPosition() async {
      final hasPermission = await _handleLocationPermission();
      if (!hasPermission) return;
      await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high)
          .then((Position position) async {
        setState(() => _currentPosition = position);
         users.setPosition(position);
        await _getAddressFromLatLng(position);
      }).catchError((e) {
        debugPrint(e);
      });

    }


    return SafeArea(
        child: Scaffold(
          body: Stack(
              children: [
                Positioned(
                  left: -45,
                  top: -45,
                  child: Container(
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                        color: Palette.primaryDartfri,
                        borderRadius: BorderRadius.circular(100)
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(10, 0, 30, 0),
                  height: 100,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                          height: 130,width: 130,
                          child: Image.asset('assets/logo_noback.png')),
                      // Icon(CupertinoIcons.bell,size: 30,color: Palette.primaryDartfri,)

                    ],
                  ),
                ),
                SingleChildScrollView(
                  child: Container(
                    padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.2,
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                            child: Icon(Icons.location_pin,color: Palette.primaryDartfri,size: 50,)),
                        Row(
                          children: [
                            Text('Hello, Welcome to ',style: TextStyle(fontSize: 20),),
                            Text('DatFri' ,style: TextStyle(color: Palette.primaryDartfri,fontSize: 20),)
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text('Set your location to find wash bays around you',style: TextStyle(fontSize: 12,color: Color(0xFFB1B1B1)),),
                        SizedBox(
                          height: MediaQuery.of(context).size.height*0.15,
                        ),
                        loading ? Center(child: CircularProgressIndicator(color: Palette.primaryDartfri,)):ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)
                                ),
                              minimumSize: Size.fromHeight(
                                  45), // fromHeight use double.infinity as width and 40 is the height
                            ),
                            onPressed: () async {
                              setState(() {
                                loading = true;
                              });
                              try{
                                await _getCurrentPosition();

                                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>DashboardPage()));

                              }catch(e){
                                BotToast.showText(text:'$e');
                              }

                            },
                            child: const Text(
                              'Use Current Location',
                              style: TextStyle(color: Colors.black),
                            )),

                        SizedBox(
                          height: 20,
                        ),

                        Text('Location will be accesible while you are using the app',style: TextStyle(fontSize: 12,color: Color(0xFFB1B1B1)),)





                      ],
                    ),

                  ),
                ),
              ]

          ),
        ));
  }
}
