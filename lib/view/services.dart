import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khadamat_behesht_zahra/bloc/all_services_bloc/bloc.dart';
import 'package:khadamat_behesht_zahra/bloc/all_services_bloc/event.dart';
import 'package:khadamat_behesht_zahra/bloc/all_services_bloc/state.dart';
import 'package:khadamat_behesht_zahra/bloc/save_services_bloc/bloc.dart';
import 'package:khadamat_behesht_zahra/bloc/save_services_bloc/event.dart';
import 'package:khadamat_behesht_zahra/bloc/save_services_bloc/state.dart';
import 'package:khadamat_behesht_zahra/component/top_carousel.dart';
import 'package:khadamat_behesht_zahra/model/get_all_services_Items_model.dart';
import 'package:khadamat_behesht_zahra/model/save_to_database_model.dart';
import 'package:khadamat_behesht_zahra/presentation/google_icons.dart';
import 'package:khadamat_behesht_zahra/presentation/my_flutter_app_icons.dart';
import 'package:khadamat_behesht_zahra/view/service_details.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Services extends StatefulWidget {
  const Services({Key? key}) : super(key: key);

  @override
  State<Services> createState() => _ServicesState();
}

class _ServicesState extends State<Services> {

  StreamSubscription? subscription;
  bool isOffline = false;
  // final List servicesItemNameList = [];
  // final List servicesItemImageList = [];

  @override
  void initState() {
    // TODO: implement initState

    clearSharedPreferences();
    // saveToDatabase();
    // for(int i = 0; i < servicesItemNameList.length; i++)
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

  saveToDatabase(SaveToDataBaseModel services){
    print('save data to database');
    print('save data to database'+ services.name.toString());
    final allServicesBloc = BlocProvider.of<SaveServicesBloc>(context);
    allServicesBloc.add(SaveAllServiceEvent(services));
  }

  @override
  Widget build(BuildContext context) {

    final allServicesBloc = BlocProvider.of<AllServicesBloc>(context);
    allServicesBloc.add(const GetAllServicesItemEvent());

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.green,
        title: const Text("درخواست آنلاین خدمات بهشت زهرا(س)",
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
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
      body: BlocBuilder<AllServicesBloc, AllServicesState>(
        builder: (context, state) {
          if (state.status.isLoading) {
            print('1111111111111');
            return const Center(child: CircularProgressIndicator());
          }
          if (state.status.isSuccess) {
              print('33333333333333');
              var item = state.allServices;
              late SaveToDataBaseModel service = SaveToDataBaseModel();

              return Column(
            children: [
              TopCarousel(),
              const SizedBox(height: 20,),
                Expanded(
                  child: GridView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      gridDelegate:
                          const SliverGridDelegateWithMaxCrossAxisExtent(
                              maxCrossAxisExtent: 300,
                              childAspectRatio: 2 / 2,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 10),
                      itemCount: item.length,
                      itemBuilder: (BuildContext ctx, index) {
                        service.name = item[index].name;
                        service.imagePath =
                            'https://ebehesht.tehran.ir:8080/api/v1/Service/item/${item[index].id}/image';
                        // var headerImage = await rootBundle.load('https://ebehesht.tehran.ir:8080/api/v1/Service/item/${item[index].id}/image');

                        // servicesItemNameList.add(service.name);
                        // servicesItemImageList.add(service.imagePath);

                        saveToDatabase(service);


                        return InkWell(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => ServiceDetails(
                                    id: item[index].id!,
                                    name: item[index].name!,
                                    description: item[index].description!,
                                    minQty: item[index].minQty!,
                                    maxQty: item[index].maxQty!,
                                    price: item[index].price!)));
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
                                          image: NetworkImage(
                                              'https://ebehesht.tehran.ir:8080/api/v1/Service/item/${item[index].id}/image'))),
                                ),
                              ),
                              Expanded(child: Text('${item[index].name}')),
                            ],
                          ),
                        );
                      }),
                )
              ],);
            }
          if (state.status.isError){
                print('5555555555555555');
                return const Text(
            '66666666666666666666',
            style: TextStyle(fontSize: 25, color: Colors.white),);
              } else {
                print('777777777777777777');
                return const Center(
                    child: Text('!!برتامه برای اجرا اول نیاز به اینترنت دارد',
                    style: TextStyle(color: Colors.grey,
                    fontWeight: FontWeight.w700,
                    fontSize: 19)));
              }

          // if (state is GetAllServicesIsLoadingState){
          //   return const Center(child: CircularProgressIndicator());
          // }
          // if(state is GetAllServicesIsLoadedState){
          //
          //   var item = state.getAllServicesItem;
          //
          //   return Column(
          //     children: [
          //       TopCarousel(),
          //       const SizedBox(height: 20,),
          //       allServicesItem(item, context),
          //     ],
          //   );
          // }
          // if(State is GetAllServicesIsNotLoadedState){
          //   return const Text(
          //     'ssssssssssssssss',
          //     style: TextStyle(fontSize: 25, color: Colors.white),
          //   );
          // }
          // return Container();
    }
    )
    );
  }
}