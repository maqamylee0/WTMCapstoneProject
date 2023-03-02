import 'package:dartfri/features/pageImports.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../providers/user_provider.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context);

    return SafeArea(child: Scaffold(
      body: Container(
        child: Column(
          children: [
            Container(
              color: Color(0xFFB0E3E8),
              height: MediaQuery.of(context).size.height *0.12,
              padding: EdgeInsets.fromLTRB(10, 10, 10, 5),
              child: Column(
                children: [
                  SizedBox(height: 20,),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [

                      Text('Notifications',style: TextStyle(fontSize: 20,color: Colors.black),),

                      IconButton(onPressed: (){
                        Navigator.pop(context);
                      }, icon:  Icon(Icons.notifications,size: 30,color: Colors.black,),),




                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                // blogs.search ? blogs.newBlogs.length :
                padding: EdgeInsets.all(10),
                child: ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    // shrinkWrap: true,
                    itemCount:user.notifications.length,
                    scrollDirection: Axis.vertical,
                    itemBuilder: (context, index) {
                      return  Container(
                        child:  Row(
                          children: [

                            Container(
                              margin:EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                   color:Palette.primaryDartfri,
                                  borderRadius: BorderRadius.circular(10)),
                              height: 60,
                              width: 60,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Container(
                              padding:EdgeInsets.all(10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(

                                    child: Text("${user.notifications[index].from}",
                                        style: TextStyle(
                                            color: Colors.grey,
                                            fontSize: 12,
                                            )),
                                  ),

                                  SizedBox(
                                    height: 2,
                                  ),
                                  SizedBox(

                                    child: Text("${user.notifications[index].title}",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold)),
                                  ),
                                  SizedBox(
                                    height: 2,
                                  ),
                                  SizedBox(

                                    child: Text("${user.notifications[index].time}",
                                        style: TextStyle(
                                            color: Colors.grey,
                                            fontSize: 15,
                                            )),
                                  ),

                                ],
                              ),
                            )
                          ],
                        )
                      );
                    }),
              ),
            ),



          ],

        ),
      ),
    ));
  }
}
