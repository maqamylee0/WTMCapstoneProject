import 'dart:developer';

import 'package:dartfri/features/pageImports.dart';
import 'package:dartfri/features/screens/auth/pages/choose.dart';
import 'package:flutter/material.dart';
import 'package:intro_slider/intro_slider.dart';

import 'data.dart' as data;

class WelcomeSlider extends StatefulWidget {
  const WelcomeSlider({super.key});

  @override
  State<WelcomeSlider> createState() => _WelcomeSliderState();
}

class _WelcomeSliderState extends State<WelcomeSlider> {
  List<ContentConfig> sliderList = [];

  @override
  void initState() {
    super.initState();
    sliderList = data.sliderData;
  }

  void onFinishSlider() {
    log("slider finish");
    Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const ChoosePage())
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IntroSlider(
        key: UniqueKey(),
        listContentConfig: sliderList,
        onDonePress: onFinishSlider,
        onSkipPress: onFinishSlider,
      ),
    );
  }
}
