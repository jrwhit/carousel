import 'dart:developer';

import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,

        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _itemCount = 0;
  List lista = [1,2,3,4,5];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Carousel com page Indicator'),
      ),
      body: ListView.builder(
        padding: EdgeInsets.symmetric(vertical: 16.0),
        itemCount: 1,
        itemBuilder: (BuildContext context, int index) {
          return _buildCarousel(context, index);
        },
      ),
    );
  }

  Widget _buildCarousel(BuildContext context, int carouselIndex) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text('Carousel Teste'),
        SizedBox(
          // you may want to use an aspect ratio here for tablet support
          height: 200.0,
          child: PageView.builder(
            // store this controller in a State to save the carousel scroll position
            controller: PageController(viewportFraction: 0.8),
            allowImplicitScrolling: true,
            onPageChanged: (index){
              log("itemIndex: $index");
              setState(() {
                _itemCount = index;
              });
            },
            itemCount: lista.length,
            itemBuilder: (BuildContext context, int itemIndex) {
              return Transform.scale(
                  scale: _itemCount == itemIndex ? 1 : 0.9,
                  child: _buildCarouselItem(context, carouselIndex, itemIndex),
              );
            },
          ),
        ),
        _buildIndicator()
      ],
    );
  }

  Widget _buildCarouselItem(BuildContext context, int carouselIndex, int itemIndex) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 4.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey,
          borderRadius: BorderRadius.all(Radius.circular(4.0)),
        ),
      ),
    );
  }

  List<T> indicator<T>(List list, Function handler){
    List<T> result = [];
    for(int i=0; i<list.length;i++) result.add(handler(i, list[i]));
    return result;
  }

  Widget _buildIndicator(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: indicator<Widget>(lista, (index, url){
        return Container(
          width: 10.0,
          height: 10.0,
          margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: _itemCount == index ? Colors.redAccent : Colors.green,
          ),
        );
      }),
    );
  }
}
