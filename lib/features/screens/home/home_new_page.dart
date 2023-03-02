import 'package:cached_network_image/cached_network_image.dart';
import 'package:dartfri/features/pageImports.dart';
import 'package:dartfri/features/screens/home/data.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:provider/provider.dart';

import '../../../keys.dart';
import '../../../providers/places_provider.dart';
import '../../../providers/user_provider.dart';
import '../appointment/pages/appointment_page.dart';
import '../nearby_places/pages/nearby_places.dart';
import '../wallet/pages/wallet_page.dart';

class HomeNewPage extends StatelessWidget {
   HomeNewPage({Key? key}) : super(key: key);
  TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    final places = Provider.of<PlacesProvider>(context);
    final users = Provider.of<UserProvider>(context);

    return SafeArea(
        child: Scaffold(
          body: Container(
            child:SingleChildScrollView(
                    child: Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,

                        children: [

                          Container(
                            padding: EdgeInsets.fromLTRB(16, 20, 10, 10),
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height*0.23,
                            color: Palette.primaryDartfri,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                (users.username) != '' ? Text('Hello , ${users.user.name}!',style: TextStyle(fontSize: 15,color: Colors.black,fontWeight: FontWeight.w600),):
                                Text('Welcome Back , !',style: TextStyle(fontSize: 22,color: Colors.white),),
                                 SizedBox(height: 20,),
                                Text('Your location',style: TextStyle(fontSize: 13,color: Colors.black),),
                                SizedBox(
                                  height: 30,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Icon(Icons.location_on_outlined,size: 16,),
                                          Text("${users.currentAddress}",style: TextStyle(fontWeight: FontWeight.w600),),

                                        ],
                                      ),
                                      TextButton(onPressed: () async {
                                        Prediction? p = await PlacesAutocomplete.show(
                                            offset: 0,
                                            radius: 1000,
                                            strictbounds: false,
                                            region: "ng",
                                            language: "en",
                                            context: context,
                                            mode: Mode.overlay,
                                            apiKey: Keys.kGoogleApiKey,
                                            sessionToken: Keys.sessionToken,
                                            components: [new Component(Component.country, "ng")],
                                            types: ["(cities)"],
                                            hint: "Search City",
                                            startText: places.city == null || places.city == "" ? "" : places.city
                                        );
                                        _getLatLng(p!,places);

                                      }, child: Row(
                                        children: [
                                          Text("Change",style: TextStyle(height:0.6,fontSize: 12,color: Colors.black),),
                                          Icon(Icons.arrow_drop_down,size: 25,color: Colors.black,)

                                        ],
                                      ))
                                    ],
                                  ),
                                ),
                                SizedBox(height: 10,),
                                Row(
                                  children: [
                                    Container(
                                      width: MediaQuery.of(context).size.width * 0.75,
                                      height: 42,
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(10)),
                                      child: Row(
                                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          IconButton(
                                            iconSize: 30,
                                            icon: Icon(Icons.search,size: 20,),
                                            color: Colors.black,
                                            onPressed: () {},
                                          ),
                                          SizedBox(
                                            width: 200,
                                            child: TextFormField(
                                              onChanged:(value) {
                                                if(value.isEmpty){
                                                  places.setSearch(false);
                                                }else{
                                                  places.setSearch(true);
                                                  places.runFilter(value);
                                                }

                                              },
                                              keyboardType: TextInputType.text,
                                              controller: _searchController,
                                              decoration: InputDecoration.collapsed(

                                                hintText: 'Search for services', ),
                                            ),
                                          ),
                                          // IconButton(
                                          //   iconSize: 20,
                                          //   icon: Icon(Icons.settings),
                                          //   color: Colors.black,
                                          //   onPressed: () {},
                                          // ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(width: 10,),
                                    SizedBox(
                                      height: 40,width: 50,
                                      child: ElevatedButton(

                                          style: ElevatedButton.styleFrom(
                                              backgroundColor: Color(0xFF61C8D1),
                                              shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(10)
                                              )
                                          ),
                                          onPressed: (){}, child: FaIcon(FontAwesomeIcons.sliders,color: Colors.black,size: 18)
                                      ),
                                    )
                                    // Container(
                                    //   padding: EdgeInsets.all(10),
                                    //   height: 30,width: 30,
                                    //   decoration:  BoxDecoration(
                                    //       color: Color(0xFF61C8D1),
                                    //       borderRadius: BorderRadius.circular(10)),
                                    //   child:
                                    // )
                                  ],
                                ),

                              ],
                            ),
                          ),
                          SizedBox(height: 10,),
                          Container(
                            padding: EdgeInsets.fromLTRB(15, 0, 0, 5),

                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Our Services',style: TextStyle(fontWeight: FontWeight.w600),),
                                Container(

                                  height: 120,
                                  width: MediaQuery.of(context).size.width,
                                  child:

                                  ListView.builder(
                                    itemCount: 4,
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: (BuildContext context, int index) {
                                      return GestureDetector(
                                        onTap: (){
                                          Navigator.push(context, MaterialPageRoute(builder: (context)=>NearbyPlaces()));
                                        },
                                        child: Container(
                                            width: 100,
                                            padding: EdgeInsets.all(10),
                                            decoration: BoxDecoration(
                                              // color: Color(0xFFD3FBFF),
                                              // color: Palette.primaryDartfri,
                                              // border: Border.all(color: Palette.primaryDartfri,width: 1.5),
                                              borderRadius: BorderRadius.circular(20),

                                            ),
                                            child: Center(
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                  children: [
                                                    Card(
                                                      shape: RoundedRectangleBorder(
                                                        borderRadius: BorderRadius.circular(100.0),
                                                      ),
                                                      child: Container(
                                                        height:60,

                                                        decoration: BoxDecoration(
                                                          borderRadius: BorderRadius.circular(100),
                                                          // color: Color(0xFFD3FBFF),

                                                          // color: HomeData.datas[index].boxColor,
                                                        ),
                                                        child: Image.asset(HomeData.datas[index].boxIcon),
                                                      ),
                                                    ),
                                                    Text(HomeData.datas[index].text,style: TextStyle(fontSize: 12),)
                                                  ],
                                                ))),
                                      );
                                    },

                                  ),),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('Popular Car Wash Nearby',style: TextStyle(fontWeight: FontWeight.w600),),
                                    Row(
                                      children: [
                                        TextButton(onPressed: (){
                                          Navigator.push(context, MaterialPageRoute(builder: (context)=>NearbyPlaces()));

                                        }, child:  Text('see all',style: TextStyle(fontWeight: FontWeight.w600),),
                                        ),
                                        Icon(Icons.arrow_forward_ios,size: 15,)
                                      ],
                                    ),

                                  ],
                                ),
                                SizedBox(height: 10,),
                                Container(
                                  height: 180,
                                  child:

                                  ListView.builder(
                                    itemCount: places.places.length,
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: (BuildContext context, int index) {
                                      return GestureDetector(
                                        onTap: (){
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(builder: (context) {
                                              return AppointmentFormPage(place: places.places[index]);
                                            }),
                                          );
                                          // Navigator.push(context, MaterialPageRoute(builder: (context)=>NearbyPlaces()));
                                        },
                                        child: Container(
                                          padding: EdgeInsets.all(5),
                                          width: 160,
                                            height: 190,
                                            decoration: BoxDecoration(
                                              // color: Color(0xFFD3FBFF),
                                              // color: Palette.primaryDartfri,
                                              // border: Border.all(color: Palette.primaryDartfri,width: 1.5),
                                              borderRadius: BorderRadius.circular(20),

                                            ),
                                            child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Container(

                                                      decoration: BoxDecoration(
                                                          image: DecorationImage(
                                                              image: CachedNetworkImageProvider(
                                                                '${places.places[index].imgUrl}',
                                                              ),
                                                              fit: BoxFit.cover),
                                                          borderRadius: BorderRadius.circular(10)),
                                                      height: 90,
                                                      width: 150,
                                                    ),
                                                    SizedBox(height: 5,),

                                                    Text(places.places[index].name!,style: TextStyle(fontSize: 12,fontWeight: FontWeight.w600),),
                                                    SizedBox(height: 5,),
                                                    Row(
                                                      children: [
                                                        Icon(Icons.location_on_outlined),
                                                        Text(places.places[index].address!,style: TextStyle(fontSize: 12),),
                                                      ],
                                                    ),
                                                    SizedBox(height: 5,),



                                                    RatingBarIndicator(
                                                      rating: double.parse(places.places[index].rating!),
                                                      itemBuilder: (context, index) => Icon(
                                                        Icons.star,
                                                        color: Colors.amber,
                                                      ),
                                                      itemCount: 5,
                                                      itemSize: 20.0,
                                                      direction: Axis.horizontal,
                                                    )
                                                  ],
                                                ))
                                      );
                                    },

                                  ),),
                                Text('Special Packages and Offers',style: TextStyle(fontWeight: FontWeight.w600),),
                                SizedBox(height: 10,),
                                Container(
                                  height: 170,
                                  child:

                                  ListView.builder(
                                    itemCount: places.offers.length,
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: (BuildContext context, int index) {
                                      return GestureDetector(
                                          onTap: (){
                                            // Navigator.push(context, MaterialPageRoute(builder: (context)=>NearbyPlaces()));
                                          },
                                          child: Stack(
                                            children: [


                                              Container(
                                                padding: EdgeInsets.all(5),
                                                width: 250,
                                                height: 120,
                                                decoration: BoxDecoration(
                                                  // color: Color(0xFFD3FBFF),
                                                  // color: Palette.primaryDartfri,
                                                  // border: Border.all(color: Palette.primaryDartfri,width: 1.5),
                                                  borderRadius: BorderRadius.circular(20),

                                                ),
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Container(

                                                      decoration: BoxDecoration(
                                                          image: DecorationImage(
                                                              image: CachedNetworkImageProvider(
                                                                '${places.offers[index].imgUrl}',
                                                              ),
                                                              fit: BoxFit.cover),
                                                          borderRadius: BorderRadius.circular(10)),
                                                      height: 110,
                                                      width: 250,
                                                    ),

                                                  ],
                                                )),
                                              Container(
                                                padding: EdgeInsets.all(10),
                                                height:90,

                                                child: Column(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                  children: [Container(
                                                    child: Text('${places.offers[index].title}',style: TextStyle(color: Colors.white),),

                                                  ),
                                                    Container(
                                                      child: Text('${places.offers[index].place}',style: TextStyle(color: Colors.white),),

                                                    ),
                                                    Container(
                                                      child: Text('${places.offers[index].off} off',style: TextStyle(color: Colors.white),),

                                                    ),
                                                  ]
                                                ),
                                              ),
                                            ]
                                          )
                                      );
                                    },

                                  ),),


                              ],
                            ),
                          ),






                          // Container(
                          //   child: Row(
                          //     children: [
                          //       GestureDetector(
                          //         onTap: (){
                          //           Navigator.push(context, MaterialPageRoute(builder: (context)=>WalletPage()));
                          //         },
                          //         child: Container(
                          //             width: 120,
                          //             height: 80,
                          //             padding: EdgeInsets.all(10),
                          //             decoration: BoxDecoration(
                          //               // color: Color(0xFFD3FBFF),
                          //               // color: Palette.primaryDartfri,
                          //               border: Border.all(color: Palette.primaryDartfri,width: 1.5),
                          //               borderRadius: BorderRadius.circular(20),
                          //
                          //             ),
                          //             child: Center(
                          //                 child: Column(
                          //                   crossAxisAlignment: CrossAxisAlignment.center,
                          //                   children: [
                          //                     Container(
                          //                       height:30,
                          //
                          //                       decoration: BoxDecoration(
                          //                         borderRadius: BorderRadius.circular(100),
                          //                         // color: Color(0xFFD3FBFF),
                          //
                          //                         // color: ,
                          //                       ),
                          //                       child: Image.asset('assets/wallet.png'),
                          //                     ),
                          //                     Text('Top Up Wallet',style: TextStyle(fontSize: 12),)
                          //                   ],
                          //                 ))),
                          //       ),
                          //
                          //
                          //     ],
                          //   ),
                          // ),

                        ],
                      ),

                    ),
                  ),


            ),
          ),
        );
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
