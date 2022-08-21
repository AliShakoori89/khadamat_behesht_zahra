import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:persian_number_utility/persian_number_utility.dart';

class ServiceDetails extends StatefulWidget {
  
  late String id;
  late String name;
  late String description;
  late int minQty;
  late int maxQty;
  late int price;


  ServiceDetails({Key? key,
    required this.id,
    required this.name,
    required this.description,
    required this.minQty,
    required this.maxQty,
    required this.price}) : super(key: key);

  @override
  State<ServiceDetails> createState() => _ServiceDetailsState(
      id,name,description,minQty,maxQty,price);
}

class _ServiceDetailsState extends State<ServiceDetails> {

  late String id;
  late String name;
  late String description;
  late int minQty;
  late int maxQty;
  late int price;

  final int _currentIndex=0;
  List cardList = [1,2,3,4,5];
  final TextEditingController textFieldController = TextEditingController();

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
        title: Text(name),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
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
                            decoration: const BoxDecoration(
                                color: Colors.amber
                            ),
                            child: Text('text $i', style: const TextStyle(fontSize: 16.0),)
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
            ),
            const SizedBox(height: 10,),
            Html(
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
            ),
            Padding(
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
                    height: 50,
                    child: TextFormField(
                      inputFormatters: [
                        FilteringTextInputFormatter(RegExp('[0-9۰-۹.]'), allow: true)
                      ],
                      controller: textFieldController,
                      decoration: const InputDecoration(
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(width: 1, color: Colors.grey)
                          )
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
            ),
            Padding(
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
            ),
            Padding(
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
            )
          ],
        ),
      ),
    );
  }
}
