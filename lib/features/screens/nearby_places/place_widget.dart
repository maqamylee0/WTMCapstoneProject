

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dartfri/features/pageImports.dart';
import 'package:dartfri/features/screens/appointment/pages/appointment_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

import '../../../providers/places_provider.dart';
import '../../../providers/user_provider.dart';
import 'models/place.dart';

class PlaceWidget extends StatelessWidget {
  const PlaceWidget({
    Key? key,
    required this.place,
  }) : super(key: key);
  final Place place;

  @override
  Widget build(BuildContext context) {
    final places = Provider.of<PlacesProvider>(context);
    final user = Provider.of<UserProvider>(context);

    return GestureDetector(
      onTap: (){
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) {
            return AppointmentFormPage(place: place);
          }),
        );
      },
      child: Container(
        padding: EdgeInsets.all(5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          // border: Border.all(width: 1,color: Palette.primaryDartfri)
        ),
        // padding: EdgeInsets.all(10),
        child: Row(
          children: [

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Row(
                  children: [
                    // Container(
                    //   height: 170,
                    //   width: 110,
                    //   //       width: 110,
                    //   child: CachedNetworkImage(
                    //   imageUrl: '${blog.imageUrl}',
                    //   ),
                    // ),
                    Container(
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: CachedNetworkImageProvider(
                                '${place.imgUrl}',
                              ),
                              fit: BoxFit.cover),
                          borderRadius: BorderRadius.circular(10)),
                      height: 100,
                      width: 110,
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 180,
                          child: Text("${place.name}",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold)),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text("${place.address}",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                            )),
                        // RatingBarIndicator(
                        //   rating: 2.75,
                        //   itemBuilder: (context, index) => Icon(
                        //     Icons.star,
                        //     color: Colors.amber,
                        //   ),
                        //   itemCount: 5,
                        //   itemSize: 30.0,
                        //   direction: Axis.horizontal,
                        // ),
                        SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width *0.5 ,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              // IconButton(
                              //   iconSize: 20,
                              //   icon: Icon(Icons.share),
                              //   color: Colors.black,
                              //   onPressed: () async {
                              //     // final url = await Uri.parse('${blog.imageUrl}');
                              //     // final response = await http.get(url);
                              //     // final bytes = await response.bodyBytes;
                              //     // final temp = await getTemporaryDirectory();
                              //     // final path = '${temp.path}/brest5.jpeg';
                              //     // // File imgFile =  File(path);
                              //     //
                              //     // XFile? file = await XFile(path);
                              //     // // file.writeAsBytesSync(response.bodyBytes);
                              //     //
                              //     // print('path $path');
                              //     // // File(path).writeAsBytesSync(bytes);
                              //     // // Share.share('${blog.title}', subject: '${blog.content}');
                              //     // await Share.shareXFiles([file],text: '${blog.title}');
                              //     // // Files(, text: '${blog.title}');
                              //     // Share.share('${blog.title} \n ${blog.content}  ',subject: '${blog.content}');
                              //   },
                              // ),
                              RatingBarIndicator(
                                rating: double.parse(place.rating!),
                                itemBuilder: (context, index) => Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                ),
                                itemCount: 5,
                                itemSize: 20.0,
                                direction: Axis.horizontal,
                              ),
                              places.fav.contains(place.uid) ? IconButton(
                                iconSize: 20,
                                icon: Icon(Icons.favorite),
                                color: Colors.lightBlueAccent,
                                onPressed: () {
                                  places.removeFromFav(place);

                                },
                              ):IconButton(
                                iconSize: 20,
                                icon: Icon(Icons.favorite_outline),
                                color: Colors.lightBlueAccent,
                                onPressed: () {
                                  places.addToFav(place);
                                },
                              ),
                            ],
                          ),
                        )
                      ],
                    )
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
