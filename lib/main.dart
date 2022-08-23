import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_no_internet_widget/flutter_no_internet_widget.dart';
import 'package:khadamat_behesht_zahra/bloc/all_services_bloc/bloc.dart';
import 'package:khadamat_behesht_zahra/bloc/save_services_bloc/bloc.dart';
import 'package:khadamat_behesht_zahra/repository/all_services_repository.dart';
import 'package:khadamat_behesht_zahra/repository/save_data_repository.dart';
import 'package:khadamat_behesht_zahra/view/home_page.dart';

void main() {
  // Bloc.observer = AppBlocObserver();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (BuildContext context) =>
                AllServicesBloc(ServicesRepository())),
        BlocProvider(
            create: (BuildContext context) =>
                SaveServicesBloc(ServicesRepository())),
      ],
      child:
      // InternetWidget(
        // offline: MaterialApp(
        //   home: Container(
        //   ),
        // ),
        // online:
        const MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          home: HomePage(),
        ),
      // ),
    );
  }
}

