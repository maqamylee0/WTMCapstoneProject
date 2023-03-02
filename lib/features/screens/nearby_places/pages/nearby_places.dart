import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:provider/provider.dart';

import '../../../../keys.dart';
import '../../../../providers/places_provider.dart';
import '../../../../providers/user_provider.dart';
import '../place_widget.dart';

class NearbyPlaces extends StatefulWidget {
   NearbyPlaces({Key? key}) : super(key: key);

  @override
  State<NearbyPlaces> createState() => _NearbyPlacesState();
}

class _NearbyPlacesState extends State<NearbyPlaces> {
  TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final places = Provider.of<PlacesProvider>(context);
    final user = Provider.of<UserProvider>(context);

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Nearby Places'),
          actions: [
            // Icon(Icons.arrow_back),

          ],
        ),
        body:
          Container(
            padding: EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [


                Container(
                  padding: EdgeInsets.fromLTRB(5, 0, 5, 0),

                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(

                          children: [
                            Icon(CupertinoIcons.map_pin_ellipse),
                            SizedBox(width: 20,),
                            Text("${user.currentAddress}",style: TextStyle(height: 0.6),),
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
                                Text("Change",style: TextStyle(height:0.6,fontSize: 12),),
                                Icon(Icons.arrow_drop_down,size: 25,)

                              ],
                            ))
                            ,
                          ],

                        )
                        )
                      ]
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 50,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)),
                  child: Row(
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        iconSize: 30,
                        icon: Icon(Icons.search),
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

                            hintText: 'Search', ),
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
                SizedBox(
                  height: 10,
                ),
                (places.places.isEmpty) ?
                Text("No Results Found",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 27,
                        fontWeight: FontWeight.bold))
                    :
                Expanded(
                  child: Container(
                    // blogs.search ? blogs.newBlogs.length :
                    // padding: EdgeInsets.all(6),
                    child: ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        // shrinkWrap: true,
                        itemCount:places.places.length,
                        scrollDirection: Axis.vertical,
                        itemBuilder: (context, index) {
                          return  PlaceWidget(place:  places.places[index]);
                        }),
                  ),
                ),
              ],
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
