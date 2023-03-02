import 'dart:ui';

class HomeData{
    Color boxColor;
    String boxIcon;
    String text;

    HomeData(this.text,this.boxColor,this.boxIcon);
    static List<HomeData> datas = [
       HomeData('Car Wash', Color(0xFFCBE11E), 'assets/Car wash.png'),


        HomeData('Car Polish', Color(0xFFE11ECB), 'assets/polish.png'),
        HomeData('Engine Wash', Color(0xFF90D161), 'assets/Car engine.png'),


        HomeData('Car Service', Color(0xFFE1341E), 'assets/service.png'),
    ];
}

