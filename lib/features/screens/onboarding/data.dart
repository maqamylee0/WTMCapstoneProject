// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';
import 'package:intro_slider/intro_slider.dart';



Color sliderColor =  Color(0xFF16E4E4);
List<ContentConfig> sliderData = [
  ContentConfig(
    title: "Discover Services ",
    styleTitle: TextStyle(
      color: Colors.black,
      fontSize: 30,

      fontWeight: FontWeight.bold,
      fontFamily: 'RobotoSlab',
    ),
    description:
    "Get  access to remarkable \nservices  at the comfort of \n your homes.",
    styleDescription: TextStyle(color: Colors.black, fontSize: 17,letterSpacing: 0.2),
    pathImage: "assets/rafiki.png",
  ),
  ContentConfig(
    title: "Elegant Wash ",
    styleTitle: TextStyle(
      color: Colors.black,
      fontSize: 30,
      fontWeight: FontWeight.bold,
      fontFamily: 'RobotoSlab',
    ),
    description:
    "Revive your rides with a sparkling clean wash and make your car look new always",
    styleDescription: TextStyle(color: Colors.black, fontSize: 17),
    pathImage: "assets/amico.png",
  ),
  ContentConfig(
    title: "Cashless Policy ",
    styleTitle: TextStyle(
      color: Colors.black,
      fontSize: 30,
      fontWeight: FontWeight.bold,
      fontFamily: 'RobotoSlab',
    ),
    description:
    "Make and receive payment \n on our e-wallets and \n earn a reward",
    styleDescription: TextStyle(color: Colors.black, fontSize: 18),
    pathImage: "assets/pana.png",
  ),
];
