import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nb_utils/nb_utils.dart';
import '../../view/screens/home_screen.dart';
import '../../view/screens/sign_up_screen.dart';
import '../../view_model.dart/cubit/auth_cubit/auth_cubit.dart';
import '../../view_model.dart/cubit/maps_cubit/maps_cubit.dart';

class AppRoutes {
  static const String initialRoute = "/";
  static const String signUp = "/signUp";
  static const String mapScreen = "/mapScreen";
}

class Routes {
  static Route? onGenerateRoute(RouteSettings routeSettings) {
    var args = routeSettings.arguments;
    switch (routeSettings.name) {
      case AppRoutes.initialRoute:
        return _animateRouteBuilder(BlocProvider(
          create: (context) => MapsCubit()..getAddress(),
          // child:const LoginScreen(),
          child: const MapScreen(),
        ));

      case AppRoutes.signUp:
        return _animateRouteBuilder(BlocProvider(
          create: (context) => AuthCubit(),
          child: const SignUpScreen(),
        ));
      case AppRoutes.mapScreen:
        return _animateRouteBuilder(
          const MapScreen(),
        );

      default:
        return _animateRouteBuilder(const Scaffold(
          body: Center(
            child: Text('No Route Found'),
          ),
        ));
    }
  }

  static _animateRouteBuilder(
    Widget widget, {
    PageRouteAnimation? pageRouteAnimation,
    Duration? duration,
  }) =>
      buildPageRoute(
          widget,
          pageRouteAnimation ?? PageRouteAnimation.SlideBottomTop,
          duration ?? 50.milliseconds);
}
