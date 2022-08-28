import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:is_first_run/is_first_run.dart';
import 'package:khadamat_behesht_zahra/bloc/details_bloc/bloc.dart';
import 'package:khadamat_behesht_zahra/bloc/details_bloc/event.dart';
import 'package:khadamat_behesht_zahra/bloc/details_bloc/state.dart';
import 'package:khadamat_behesht_zahra/model/images_of_service_model.dart';
import 'package:persian_number_utility/persian_number_utility.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ServiceDetails extends StatefulWidget {
  
  String? id;
  String? name;
  String? description;
  int? minQty;
  int? maxQty;
  int? price;
  int? serviceId;

  ServiceDetails({Key? key,
    this.id,
    this.name,
    this.description,
    this.minQty,
    this.maxQty,
    this.price,
    this.serviceId}) : super(key: key);

  @override
  State<ServiceDetails> createState() => _ServiceDetailsState(
      id,name,description,minQty,maxQty,price,serviceId);
}

class _ServiceDetailsState extends State<ServiceDetails> {

  String? id;
  String? name;
  String? description;
  int? minQty;
  int? maxQty;
  int? price;
  int? serviceId;

  final int _currentIndex=0;

  bool? isApply;

  late TextEditingController textFieldController = TextEditingController();

  @override
  void initState() {
    super.initState();
    loadApplyPrice();
    BlocProvider.of<ServiceDetailsBloc>(context).add(GetServiceAllImagesEvent(serviceId!));
    loadPrice();
  }

  void loadPrice() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? action = prefs.getString(name!);
    setState(() {
      if(action == null){
      }else{
        textFieldController.text = action.toString();
      }
    });
  }

  void loadApplyPrice() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? action = prefs.getString('${name!}apply');
    setState(() {
      if(action == null){
        textFieldController.text = price.toString();
      }else{
        textFieldController.text = action.toString();
      }
    });
  }

  void writePrice(String content) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(name!, content);
  }

  void writeApplyPrice(String price) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('${name!}apply', price);
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

  _ServiceDetailsState(this.id, this.name, this.description,
      this.minQty, this.maxQty, this.price, this.serviceId);
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
            carouselBlocBuilder(),
            const SizedBox(height: 10,),
            serviceDescription(),
            choiceServicePrice(),
            minOrder(),
            maxOrder(),
          ],
        ),
      ),
      bottomSheet: SizedBox(
        height: 50,
        width: MediaQuery.of(context).size.width,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: Colors.green
          ),
            onPressed: (){
            isApply = true;
              // if(_isFirstRun == false){
              //   loadApplyPrice();
              // }
              writeApplyPrice(textFieldController.text);
              // _isFirstRun = false;
              Navigator.of(context).pop();
            },
            child: const Text(
                'ثبت',style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20),
            )),
      ),
    );
  }

  BlocBuilder<ServiceDetailsBloc, ServiceDetailsState> carouselBlocBuilder() {
    return BlocBuilder<ServiceDetailsBloc, ServiceDetailsState>(
          builder: (context, state) {
            if (state.status.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state.status.isSuccess) {
              var service = state.allServiceImages;
              return imagesCarouselSlider(context, service);
            }
            if (state.status.isError) {
              return const Center(
                  child: Text('!!برتامه برای اجرا اول نیاز به اینترنت دارد',
                      style: TextStyle(color: Colors.grey,
                          fontWeight: FontWeight.w700,
                          fontSize: 19)));
            }
            return const Center(
                child: Text('',
                    style: TextStyle(color: Colors.grey,
                        fontWeight: FontWeight.w700,
                        fontSize: 19)));
          });
  }

  Stack imagesCarouselSlider(BuildContext context, List<DataListOfImagesModel> service) {
    return Stack(
            children: [
              CarouselSlider(
                options: CarouselOptions(
                    height: MediaQuery.of(context).size.height / 4),
                items: service.map((i) {
                  return Builder(
                    builder: (BuildContext context){
                      return Container(
                          width: MediaQuery.of(context).size.width,
                          margin: const EdgeInsets.symmetric(horizontal: 1.0),
                          decoration: BoxDecoration(
                              color: Colors.black54,
                            image: DecorationImage(
                                image: AssetImage(
                                  'assets/image/${i.serviceId}/${i.imageId}.jpg'
                                )
                                // CachedNetworkImageProvider(
                                //     'https://ebehesht.tehran.ir:8080/'
                                //         'api/v1/Service/item/'
                                //         '${i.serviceId}/image/${i.imageId}'
                                // )
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
                    children: map<Widget>(service, (index, url) {
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
