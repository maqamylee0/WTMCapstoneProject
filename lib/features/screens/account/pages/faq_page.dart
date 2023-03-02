import 'package:dartfri/features/pageImports.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:footer/footer.dart';
import 'package:footer/footer_view.dart';

import '../widgets/faq_expansion.dart';


class FaqPage extends StatefulWidget {
  const FaqPage({Key? key}) : super(key: key);

  @override
  State<FaqPage> createState() => _FaqPageState();
}

class _FaqPageState extends State<FaqPage> {
  final List<Stepe> _steps = getSteps();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          child:  Container(
            child: FooterView(
              children:<Widget>[
                Container(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [


                      // Center(
                      //   child: SizedBox(
                      //     height: 50,
                      //     width: 150,
                      //     child: Image.asset("assets/logo_black.png",
                      //         height: 200, width: 300),
                      //
                      //     //Image.asset("assets/img.png")
                      //   ),
                      // ),
                      SizedBox(height: 10,),
                      Row(
                        children: [
                          Container(


                            child: IconButton(onPressed:(){
                              Navigator.of(context).pop();
                            }, icon: Icon(Icons.arrow_back_ios, color: Colors.grey,size: 20,)),
                          ),
                          Text("The FAQs",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w600,color: Palette.primaryDartfri),),
                        ],
                      ),
                      SizedBox(height: 10,),

                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Align(
                            alignment: Alignment.center,
                            child: Text("Everything you need to know about DatFri",style: TextStyle(
                                // height:1.5,fontSize: 20
                              ),)

                        ),
                      ),

                      // Expanded(
                      //   child:
                        SingleChildScrollView(
                          child: Container(
                            height: MediaQuery.of(context).size.height!*0.6,
                            // padding: EdgeInsets.all(6),
                            child: ListView.builder(

                                physics: NeverScrollableScrollPhysics(),
                                // shrinkWrap: true,
                                itemCount:_steps.length,
                                scrollDirection: Axis.vertical,
                                itemBuilder: (context,index){

                                  return ExpansionWidget(step:_steps[index]);
                                }),
                          ),
                        ),
                     // ),                    ],
                  ]),

                )],
              footer: Footer(

                child: Padding(
                  padding: new EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text("2021 - 2022 DatFri® Inc."),
                        ],
                      ),
                      SizedBox(height: 20,),

                      Row(
                        children: [
                          Text(" All Rights Reserved."),
                          SizedBox(width: 10,),

                          Row(
                            children: [
                              TextButton(onPressed: (){}, child: Text("Privacy Policy",style: TextStyle(fontSize: 12),)),
                              SizedBox(width: 5,),
                              TextButton(onPressed: (){}, child: Text("Terms",style: TextStyle(fontSize: 12)))
                            ],
                          )

                        ],
                      )
                    ],
                  ),

                ),
              ),
              flex: 10, //default flex is 2
            ),
          ),
        )
    );
  }
}
class Stepe {
  Stepe(
      this.title,
      this.body,
      [this.isExpanded = false]
      );
  String title;
  String body;
  bool isExpanded;
}

List<Stepe> getSteps() {
  return [
    Stepe('How does it works?', 'Choose a car service you wish to have and move to make an appointment.Set the time and date and make a payment.'),
    Stepe('How much is the service?', 'All services have prices and will be recorded at the end of the booking'),
    Stepe('When can i pay?', 'You can choose to pay before or after the service`.'),
    Stepe('How do I make payment?', 'Payments are made only through the wallet`.'),
    Stepe('How do i top up my wallet?', 'You can top up using mobile money or bank account`.'),
    Stepe('Will i be charged for using the app?', 'No only service providers are charged`.'),

  ];
}

