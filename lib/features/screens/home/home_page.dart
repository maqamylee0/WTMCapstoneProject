import 'package:dartfri/features/pageImports.dart';
import 'package:dartfri/features/screens/home/data.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:provider/provider.dart';

import '../../../keys.dart';
import '../../../providers/places_provider.dart';
import '../../../providers/user_provider.dart';
import '../nearby_places/pages/nearby_places.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final places = Provider.of<PlacesProvider>(context);
    final users = Provider.of<UserProvider>(context);

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
                CircleAvatar()

              ],
            ),
          ),
        SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
            child: Column(
              children: [
                SizedBox(
                  height: 50,
                ),

                Container(
                  padding: EdgeInsets.fromLTRB(5, 0, 5, 0),

                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(

                          children: [
                           Icon(CupertinoIcons.map_pin_ellipse),
                            SizedBox(width: 20,),
                            Text("${places.city}",style: TextStyle(height: 0.6),),
                          ],
                        ),

                        TextButton(onPressed:(){}, child:
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          //   crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            TextButton(onPressed: () async {
                              Prediction? p = await PlacesAutocomplete.show(
                                  offset: 0,
                                  radius: 1000,
                                  strictbounds: false,
                                  region: "ug",
                                  language: "en",
                                  context: context,
                                  mode: Mode.overlay,
                                  apiKey: Keys.kGoogleApiKey,
                                  sessionToken: Keys.sessionToken,
                                  components: [new Component(Component.country, "ug")],
                                  types: ["(cities)"],
                                  hint: "Search City",
                                  startText: places.city == null || places.city == "" ? "" : places.city
                              );
                              _getLatLng(p!,places);

                            }, child: Text("Change",style: TextStyle(height:0.6,fontSize: 12),))
                            ,
                            Icon(Icons.arrow_drop_down,size: 25,)
                          ],

                        )
                        )
                      ]
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(15),
                  width: MediaQuery.of(context).size.width,
                  height: 150,
                  decoration: BoxDecoration(
                    color: Palette.primaryDartfri,
                    borderRadius: BorderRadius.circular(20)
                  ),

                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Welcome Back , ${users.user.name}!',style: TextStyle(fontSize: 22,color: Colors.white),),

                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 15,),
                                Text('40 % off full car wash ',style: TextStyle(fontSize: 15),),
                                SizedBox(height: 7,),
                                ElevatedButton(

                                     style: ElevatedButton.styleFrom(
                                       backgroundColor: Colors.green,
                                       shape: RoundedRectangleBorder(
                                         borderRadius: BorderRadius.circular(10)
                                       )
                                     ),
                                    onPressed: (){}, child: Text('Get Offer',)
                                )
                              ],
                            ),
                            SizedBox(
                              height: 80,
                                width: 120,
                                child: Image.asset('assets/offer.png',)),
                          ],
                        ),
                      )

                    ],
                  ),
                ),
                SizedBox(height: 20,),
                Container(
                  height: 300,
                  width: MediaQuery.of(context).size.width,
                  child:Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Our Packages',style: TextStyle(fontSize: 15),),
                      SizedBox(height: 20,),
                      Expanded(child:
                      GridView.builder(
                        itemCount: 6,
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          mainAxisSpacing: 5,
                          crossAxisSpacing: 5,
                        ),
                        itemBuilder: (BuildContext context, int index) {
                          return (index == 3 || index == 5 ) ? Container():GestureDetector(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>NearbyPlaces()));
                            },
                            child: Container(
                              width: 150,
                              padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  // color: Color(0xFFD3FBFF),
                                  // color: Palette.primaryDartfri,
                                    border: Border.all(color: Palette.primaryDartfri,width: 1.5),
                                    borderRadius: BorderRadius.circular(20),

                                ),
                                child: Center(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Container(
                                          height:60,

                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(100),
                                            // color: Color(0xFFD3FBFF),

                                            color: HomeData.datas[index].boxColor,
                                          ),
                                          child: Image.asset(HomeData.datas[index].boxIcon),
                                        ),
                                        Text(HomeData.datas[index].text,style: TextStyle(fontSize: 12),)
                                      ],
                                    ))),
                          );
                        },

                      ),)
                    ],
                  ),
                )
              ],
            ),

          ),
        ),
        ]

      ),
    ));
  }
  void _getLatLng(Prediction prediction,places) async {
    GoogleMapsPlaces _places = new
    GoogleMapsPlaces(apiKey:  Keys.kGoogleApiKey);  //Same API_KEY as above
    PlacesDetailsResponse detail =
    await _places.getDetailsByPlaceId(prediction.placeId!);
    double latitude = detail.result.geometry!.location.lat;
    double longitude = detail.result.geometry!.location.lng;
    String? address = prediction.description;
    places.setCity(address);
  }
}
