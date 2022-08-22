import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khadamat_behesht_zahra/bloc/all_services_bloc/bloc.dart';
import 'package:khadamat_behesht_zahra/bloc/all_services_bloc/event.dart';
import 'package:khadamat_behesht_zahra/bloc/all_services_bloc/state.dart';
import 'package:khadamat_behesht_zahra/component/top_carousel.dart';
import 'package:khadamat_behesht_zahra/model/get_all_services_Items_model.dart';
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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    clearSharedPreferences();
  }

  void clearSharedPreferences() async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  await preferences.clear();
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
          if (state is GetAllServicesIsLoadingState){
            return const Center(child: CircularProgressIndicator());
          }
          if(state is GetAllServicesIsLoadedState){

            var item = state.getAllServicesItem;

            return Column(
              children: [
                TopCarousel(),
                const SizedBox(height: 20,),
                allServicesItem(item, context),
              ],
            );
          }
          if(State is GetAllServicesIsNotLoadedState){
            return const Text(
              'ssssssssssssssss',
              style: TextStyle(fontSize: 25, color: Colors.white),
            );
          }
          return Container();
    }
    )
    );
  }

  Expanded allServicesItem(List<DataListModel> item, BuildContext context) {
    return Expanded(
                child: GridView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: 300,
                        childAspectRatio: 2 / 2,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10),
                    itemCount: item.length,
                    itemBuilder: (BuildContext ctx, index) {
                      return InkWell(
                        onTap: (){
                          Navigator.of(context).push(
                              MaterialPageRoute(builder: (context) => ServiceDetails(
                                  id: item[index].id!,
                                  name: item[index].name!,
                                  description: item[index].description!,
                                  minQty: item[index].minQty!,
                                  maxQty: item[index].maxQty!,
                                  price: item[index].price!)
                              ));
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
                                        image: NetworkImage('https://ebehesht.tehran.ir:8080/api/v1/Service/item/${item[index].id}/image')
                                    )
                                ),
                              ),
                            ),
                            Expanded(child: Text('${item[index].name}')),
                          ],
                        ),
                      );
                    }),
              );
  }
}