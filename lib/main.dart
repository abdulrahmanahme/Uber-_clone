import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:uber/core/routes/network/dio/remote_data_source.dart';
import 'package:uber/firebase_options.dart';
import 'package:uber/view/screens/login_screen.dart';
import 'package:uber/view/screens/sign_up_screen.dart';
import 'package:uber/view_model.dart/cubit/bloc_observer/bloc_observer.dart';

import 'core/routes/app_routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await RemoteDataSource.init();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  Bloc.observer =MyBlocObserver();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (_, child) {
          return MaterialApp(
            title: 'Uber',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              useMaterial3: true,
            ),
            onGenerateRoute: Routes.onGenerateRoute,
          );
        });
  }
}
