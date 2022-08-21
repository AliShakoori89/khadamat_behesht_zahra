import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class TopCarousel extends StatefulWidget {
  final List item;

  const TopCarousel({super.key, required this.item});


  @override
  _TopCarouselState createState() => _TopCarouselState(item);
}

class _TopCarouselState extends State<TopCarousel> {
  final List item;
  int _currentIndex=0;

  _TopCarouselState(this.item);

  List<T> map<T>(List list, Function handler) {
    List<T> result = [];
    for (var i = 0; i < list.length; i++) {
      result.add(handler(i, list[i]));
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          child: CarouselSlider(
            options: CarouselOptions(
              height: 150.0,
              autoPlay: true,
              autoPlayInterval: Duration(seconds: 5),
              autoPlayAnimationDuration: Duration(milliseconds: 800),
              autoPlayCurve: Curves.fastOutSlowIn,
              pauseAutoPlayOnTouch: true,
              aspectRatio: 2.0,
              onPageChanged: (index, reason) {
                setState(() {
                  _currentIndex = index;
                });
              },
            ),
            items: item.map((card) {
              return Builder(builder: (BuildContext context) {
                return Container(
                  height: MediaQuery.of(context).size.height * 0.30,
                  width: MediaQuery.of(context).size.width,
                  child: Card(
                    elevation: 0,
                    child: card,
                    shadowColor: Colors.white,
                  ),
                );
              });
            }).toList(),
          ),
        ),
        Positioned(
            height: 280,
            left: 70,
            child: Container(
                child: Opacity(
                  opacity: 0.5,
                  child: Row(
                    children: map<Widget>(item, (index, url) {
                      return Container(
                        width: 5.0,
                        height: 5.0,
                        margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: _currentIndex == index
                              ? Colors.blueAccent
                              : Colors.grey,
                        ),
                      );
                    }),
                  ),
                )
            )
        )
      ],
    );
  }
}