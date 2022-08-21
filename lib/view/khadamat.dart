import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khadamat_behesht_zahra/bloc/all_services_bloc/bloc.dart';
import 'package:khadamat_behesht_zahra/bloc/all_services_bloc/event.dart';
import 'package:khadamat_behesht_zahra/bloc/all_services_bloc/state.dart';
import 'package:khadamat_behesht_zahra/component/top_carousel.dart';
import 'package:khadamat_behesht_zahra/presentation/google_icons.dart';
import 'package:khadamat_behesht_zahra/presentation/my_flutter_app_icons.dart';

class Khadamat extends StatelessWidget {
  const Khadamat({Key? key}) : super(key: key);

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
          print('111111111111111111111111111');
          if (state is GetAllServicesIsLoadingState){
            print('22222222222222222222222222');
            return const CircularProgressIndicator();
          }
          if(state is GetAllServicesIsLoadedState){

            print('3333333333333333333333333333333');

            var item = state.getAllServicesItem;

            return SingleChildScrollView(
              child: Column(
                children: [
                  TopCarousel(),
                ],
              ),
            );
          }
          if(State is GetAllServicesIsNotLoadedState){
            return Text(
              'ssssssssssssssss',
              style: TextStyle(fontSize: 25, color: Colors.white),
            );
          }
          print('444444444444444444444444444444444');
          return Container();
    }
    )
    );
  }
}