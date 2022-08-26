import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khadamat_behesht_zahra/bloc/database_bloc/bloc.dart';
import 'package:khadamat_behesht_zahra/bloc/database_bloc/state.dart';
import 'package:khadamat_behesht_zahra/component/top_carousel.dart';
import 'package:khadamat_behesht_zahra/presentation/google_icons.dart';
import 'package:khadamat_behesht_zahra/presentation/my_flutter_app_icons.dart';
import 'package:khadamat_behesht_zahra/view/service_details.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../bloc/database_bloc/event.dart';

class ServicesFromDatabase extends StatefulWidget {
  const ServicesFromDatabase({Key? key}) : super(key: key);

  @override
  State<ServicesFromDatabase> createState() => _ServicesFromDatabaseState();
}

class _ServicesFromDatabaseState extends State<ServicesFromDatabase> {

  StreamSubscription? subscription;
  Uint8List? bytes;

  @override
  void initState() {
    // TODO: implement initState

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

  @override
  Widget build(BuildContext context) {

    final servicesBloc = BlocProvider.of<DatabaseBloc>(context);
    servicesBloc.add(FetchServicesItemFromDatabaseEvent());

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
        body: Column(
          children: [
            TopCarousel(),
            const SizedBox(height: 20,),
            BlocBuilder<DatabaseBloc, DatabaseState>(
                builder: (context, state) {
                  if (state.status.isLoading) {
                    print('1111111111111');
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (state.status.isSuccess) {
                    print('33333333333333');
                    print('@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@');
                    print(state.allServices.length);

                    // print(item);
                    // late ServicesDataBaseModel service = ServicesDataBaseModel();


                    return state.allServices.isNotEmpty
                        ? Expanded(
                      child: GridView.builder(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          gridDelegate:
                          const SliverGridDelegateWithMaxCrossAxisExtent(
                              maxCrossAxisExtent: 300,
                              childAspectRatio: 2 / 2,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 10),
                          itemCount: state.allServices.length,
                          itemBuilder: (BuildContext ctx, index) {
                            print('iddddddddddddddddddd:  '+ state.allServices[index].id.toString());

                            print('imageeeeeeee    :');
                            print('https://ebehesht.'
                                'tehran.ir:8080/api/v1/Service'
                                '/item/${state.allServices[index].id}/image');

                            return Column(
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
                                                    '${(state.allServices[index].id!)}/image'))),
                                  ),
                                ),
                                Expanded(child: Text('${state.allServices[index].name}')),
                              ],
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
                    print('5555555555555555');
                    return const Center(
                        child: Text('!!برتامه برای اجرا اول نیاز به اینترنت دارد',
                            style: TextStyle(color: Colors.grey,
                                fontWeight: FontWeight.w700,
                                fontSize: 19)));
                  } else {
                    print('777777777777777777');
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