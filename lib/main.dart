import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_no_internet_widget/flutter_no_internet_widget.dart';
import 'package:khadamat_behesht_zahra/bloc/all_services_bloc/bloc.dart';
import 'package:khadamat_behesht_zahra/bloc/save_services_bloc/bloc.dart';
import 'package:khadamat_behesht_zahra/repository/all_services_repository.dart';
import 'package:khadamat_behesht_zahra/view/home_page/database/home_page_database.dart';
import 'package:khadamat_behesht_zahra/view/home_page/network/home_page_network.dart';

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
      const InternetWidget(
        offline: MaterialApp(
          debugShowCheckedModeBanner: false,
          home: HomePageDatabase(),
        ),
        online:
        MaterialApp(
          debugShowCheckedModeBanner: false,
          home: HomePageNetwork(),
        ),
      ),
    );
  }
}

