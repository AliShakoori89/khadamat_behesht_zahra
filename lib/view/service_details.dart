import 'dart:async';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:persian_number_utility/persian_number_utility.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ServiceDetails extends StatefulWidget {
  
  String? id;
  String? name;
  String? description;
  int? minQty;
  int? maxQty;
  int? price;


  ServiceDetails({Key? key,
    this.id,
    this.name,
    this.description,
    this.minQty,
    this.maxQty,
    this.price}) : super(key: key);

  @override
  State<ServiceDetails> createState() => _ServiceDetailsState(
      id,name,description,minQty,maxQty,price);
}

class _ServiceDetailsState extends State<ServiceDetails> {

  String? id;
  String? name;
  String? description;
  int? minQty;
  int? maxQty;
  int? price;

  final int _currentIndex=0;
  List cardList = [1,2,3,4,5];

  final TextEditingController textFieldController = TextEditingController();

  @override
  void initState() {
    super.initState();
    loadPrice();
  }

  void loadPrice() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? action = prefs.getString(name!);
    setState(() {
      if(action == null){
        TextEditingController textFieldController = TextEditingController();
      }else{
        textFieldController.text = action.toString();
      }
    });
  }

  void writePrice(String content) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(name!, content);
  }

  void deletePrice() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(name!);
  }


  List<T> map<T>(List list, Function handler) {
    List<T> result = [];
    for (var i = 0; i < list.length; i++) {
      result.add(handler(i, list[i]));
    }
    return result;
  }

  _ServiceDetailsState(this.id, this.name, this.description, this.minQty, this.maxQty, this.price);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        centerTitle: true,
        title: Text(name!),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            imagesCarouselSlider(context, id),
            const SizedBox(height: 10,),
            serviceDescription(),
            choiceServicePrice(),
            minOrder(),
            maxOrder()
          ],
        ),
      ),
    );
  }

  Stack imagesCarouselSlider(BuildContext context, String? id) {
    return Stack(
            children: [
              CarouselSlider(
                options: CarouselOptions(
                    height: MediaQuery.of(context).size.height / 4),
                items: cardList.map((i) {
                  return Builder(
                    builder: (BuildContext context) {
                      return Container(
                          width: MediaQuery.of(context).size.width,
                          margin: const EdgeInsets.symmetric(horizontal: 1.0),
                          decoration: BoxDecoration(
                              color: Colors.black54,
                            image: DecorationImage(
                                image: NetworkImage(
                                    'https://ebehesht.tehran.ir:8080/'
                                        'api/v1/Service/item/'
                                        '$id/image/$i'
                                )
                            )
                          ),
                      );
                    },
                  );
                }).toList(),
              ),
              Positioned(
                left: MediaQuery.of(context).size.width / 2.4,
                height: MediaQuery.of(context).size.height / 2.2,
                child: Opacity(
                  opacity: 0.5,
                  child: Row(
                    children: map<Widget>(cardList, (index, url) {
                      return Container(
                        width: 5.0,
                        height: 5.0,
                        margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: _currentIndex == index
                              ? Colors.blueAccent
                              : Colors.grey,
                        ),
                      );
                    }),
                  ),
                ),
              )

            ],
          );
  }

  Html serviceDescription() {
    return Html(
            data: description,
            style: {
              '#': Style(
                fontSize: const FontSize(18),
                textAlign: TextAlign.justify,
                maxLines: 10,
                padding: const EdgeInsets.all(5),
                textOverflow: TextOverflow.ellipsis,
                direction: TextDirection.rtl,
              ),
            },
          );
  }

  Padding choiceServicePrice() {
    return Padding(
            padding: const EdgeInsets.only(right: 20, top: 50),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const Text('(هر ۶۰ دقیقه)'),
                const SizedBox(width: 10,),
                const Text('ریال'),
                const SizedBox(width: 10,),
                SizedBox(
                  width: 100,
                  height: 40,
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter(RegExp('[0-9۰-۹.]'), allow: true)
                    ],
                    onChanged: (content){
                      print(content);
                      writePrice(content);
                    },
                    controller: textFieldController,
                    decoration: const InputDecoration(
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(width: 1, color: Colors.grey)
                        ),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(width: 1, color: Colors.grey)
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 20,),
                const Text('هزینه خدمات :',
                  textDirection: TextDirection.rtl,
                style: TextStyle(
                  fontWeight: FontWeight.w700
                ),
                textAlign: TextAlign.right),
              ],
            ),
          );
  }

  Padding minOrder() {
    return Padding(
            padding: const EdgeInsets.only(right: 20, top: 50),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(minQty.toString().toPersianDigit(),
                    textDirection: TextDirection.rtl,
                    style: const TextStyle(
                      fontSize: 20,
                        color: Colors.grey,
                        fontWeight: FontWeight.w700
                    ),
                    textAlign: TextAlign.right),
                const SizedBox(width: 10,),
                const Text('حذاقل تعداد قابل سفارش :',
                    textDirection: TextDirection.rtl,
                    style: TextStyle(
                      color: Colors.grey,
                        fontWeight: FontWeight.w700
                    ),
                    textAlign: TextAlign.right),
              ],
            ),
          );
  }

  Padding maxOrder() {
    return Padding(
            padding: const EdgeInsets.only(right: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(maxQty.toString().toPersianDigit(),
                    textDirection: TextDirection.rtl,
                    style: const TextStyle(
                        fontSize: 20,
                        color: Colors.grey,
                        fontWeight: FontWeight.w700
                    ),
                    textAlign: TextAlign.right),
                const SizedBox(width: 10,),
                const Text('حذاکثر تعداد قابل سفارش :',
                    textDirection: TextDirection.rtl,
                    style: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.w700
                    ),
                    textAlign: TextAlign.right),
              ],
            ),
          );
  }
}
