import 'dart:async';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:is_first_run/is_first_run.dart';
import 'package:khadamat_behesht_zahra/bloc/database_bloc/bloc.dart';
import 'package:khadamat_behesht_zahra/bloc/network_bloc/bloc.dart';
import 'package:khadamat_behesht_zahra/bloc/network_bloc/state.dart';
import 'package:khadamat_behesht_zahra/component/top_carousel.dart';
import 'package:khadamat_behesht_zahra/model/save_to_database_model.dart';
import 'package:khadamat_behesht_zahra/presentation/google_icons.dart';
import 'package:khadamat_behesht_zahra/presentation/my_flutter_app_icons.dart';
import 'package:khadamat_behesht_zahra/view/service_details.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../bloc/database_bloc/event.dart';
import '../../../bloc/network_bloc/event.dart';

class ServicesFromNetwork extends StatefulWidget {
  const ServicesFromNetwork({Key? key}) : super(key: key);

  @override
  State<ServicesFromNetwork> createState() => _ServicesFromNetworkState();
}

class _ServicesFromNetworkState extends State<ServicesFromNetwork> {

  StreamSubscription? subscription;
  bool? _isFirstRun;
  final ScrollController _scrollController = ScrollController();
  List allNames = [];

  @override
  void initState() {
    // TODO: implement initState
    BlocProvider.of<NetworkBloc>(context).add(const GetAllServicesItemEvent());
    _checkFirstRun();
    Timer.periodic(const Duration(milliseconds: 1000), (Timer timer) {
      if (_scrollController.hasClients) {
        _scrollDown();
        timer.cancel();
      }
    });
    clearSharedPreferences();
    super.initState();
  }

  void clearSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('اکو');
    await prefs.remove('مداح');
    await prefs.remove('صندلی');
    await prefs.remove('میز');
    await prefs.remove('آب مبوه پاکتی');
    await prefs.remove('سایبان');
    await prefs.remove('چای');
    await prefs.remove('آب معدنی');
    await prefs.remove('نسکافه');
    await prefs.remove('چای نبات');
    await prefs.remove('هات چاکلت');
    await prefs.remove('سماور آب جوش');
    await prefs.remove('کافه میکس لیوانی هدکس');
    await prefs.remove('کاپو چینو');
    // await preferences.clear();
  }

  void _checkFirstRun() async {
    bool ifr = await IsFirstRun.isFirstRun();
    setState(() {
      _isFirstRun = ifr;
    });
  }

  void _scrollDown() {
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 2000),
      curve: Curves.fastOutSlowIn,
    );
  }

  saveToDatabase(ServicesDataBaseModel services){
    BlocProvider.of<DatabaseBloc>(context).add(SaveAllServiceEvent(services));
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white70,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white24,
        title: const Text("درخواست آنلاین خدمات بهشت زهرا(س)",
            style: TextStyle(fontSize: 14,
                fontWeight: FontWeight.w600,
            color: Colors.black)),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 10),
            child: Icon(MyFlutterApp.panorama_wide_angle, color: Colors.black54,),
          ),
        ],
        leading: IconButton(
          onPressed: (){},
          icon: const Icon(Google.basket, color: Colors.black54),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: (){

        },
        backgroundColor: Colors.green,
        label: const Text('رزرو مراسم'),
      ),
      body: Column(
        children: [
          const SizedBox(height: 10,),
          TopCarousel(),
          const SizedBox(height: 20,),
          BlocBuilder<NetworkBloc, NetworkState>(
              builder: (context, state) {
                if (state.status.isLoading) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (state.status.isSuccess) {
                  var item = state.allServicesFromNetwork;

                  return item.isNotEmpty ? Expanded(
                    child: GridView.builder(
                      controller: _scrollController,
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        gridDelegate:
                        const SliverGridDelegateWithMaxCrossAxisExtent(
                            maxCrossAxisExtent: 300,
                            childAspectRatio: 2 / 2.5,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10),
                        itemCount: item.length,
                        itemBuilder: (BuildContext ctx, index) {

                          late ServicesDataBaseModel service = ServicesDataBaseModel();

                          service.name = item[index].name;
                          service.id = item[index].serviceId;
                          service.description = item[index].description;
                          service.maxQty = item[index].maxQty;
                          service.minQty = item[index].minQty;
                          service.price = item[index].price;
                          service.serviceId = item[index].serviceId;

                          if(_isFirstRun == true ){
                            // Future.delayed(Duration(seconds: 3), (){
                              saveToDatabase(service);
                            // });
                          }
                          allNames.add(service.name);

                          if(allNames.length == item.length){
                            _isFirstRun = false;
                          }

                          CachedNetworkImage(
                            imageUrl: 'https://ebehesht.'
                            'tehran.ir:8080/api/v1/Service'
                                '/item/${item[index].serviceId}/image',
                            placeholder: (context, url) => const CircularProgressIndicator(),
                            errorWidget: (context, url, error) => const Icon(Icons.error),
                          );

                          return InkWell(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => ServiceDetails(
                                      id: item[index].id!,
                                      name: item[index].name!,
                                      description: item[index].description!,
                                      minQty: item[index].minQty!,
                                      maxQty: item[index].maxQty!,
                                      price: item[index].price!,
                                      serviceId: item[index].serviceId,
                                  )));
                            },
                            child: Column(
                              children: [
                                Expanded(
                                  child: Container(
                                    width: 200,
                                    height: 200,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        image: DecorationImage(
                                            image: CachedNetworkImageProvider(
                                              'https://ebehesht.tehran.ir:8080/'
                                                    'api/v1/Service/item/'
                                                    '${item[index].serviceId}/image'))),
                                  ),
                                ),
                                Expanded(child: Text('${item[index].name}',
                                style: const TextStyle(fontWeight: FontWeight.w600),)),
                              ],
                            ),
                          );
                        }),
                  )
                      : const Center(
                    child: Text('!!برتامه برای اجرا اول نیاز به اینترنت دارد',
                        style: TextStyle(color: Colors.grey,
                            fontWeight: FontWeight.w700,
                            fontSize: 19)),
                  );
                }
                if (state.status.isError){
                  return const Center(
                      child: Text('!!برتامه برای اجرا اول نیاز به اینترنت دارد',
                          style: TextStyle(color: Colors.grey,
                              fontWeight: FontWeight.w700,
                              fontSize: 19)));
                } else {
                  return const Center(
                      child: Text('',
                          style: TextStyle(color: Colors.grey,
                              fontWeight: FontWeight.w700,
                              fontSize: 19)));
                }
              }
          )
        ],)
    );
  }
}