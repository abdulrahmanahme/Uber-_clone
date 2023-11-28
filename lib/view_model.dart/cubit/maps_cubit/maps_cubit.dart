import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:meta/meta.dart';
import 'package:uber/core/const/app_const.dart';
import 'package:flutter/material.dart';

import '../../../core/routes/network/dio/remote_data_source.dart';
import '../../../model/mpaps_model.dart';
part 'maps_cubit_state.dart';

class MapsCubit extends Cubit<MapsCubitState> {
  MapsCubit() : super(MapsCubitInitial());
  void getAddress() async {
    Response data =await RemoteDataSource().getData(url:AppConst.getAddressUrl );
  var mapsModel  =MapsModel.fromJson(data.data);
    var location =data.data["results"][0];
  print('data now ${location}');
  for( var m in mapsModel.results ){
   print('MAP IS ${m.formattedAddress}');

  }
   print('Hellooooo');
  }
}
