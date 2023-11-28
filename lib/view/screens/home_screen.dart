import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart' as prefix;
import 'package:uber/core/const/app_const.dart';
import 'package:uber/view/screens/search_location_card.dart';

import '../../core/routes/network/dio/remote_data_source.dart';
import '../../view_model.dart/cubit/maps_cubit/maps_cubit.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => MapScreenState();
}

class MapScreenState extends State<MapScreen> {
  @override
  void initState() {
    // getData();
    getPermission();
    super.initState();
  }

  // getData() async {
  //   Response data =
  //       await RemoteDataSource().getData(url: AppConst.getAddressUrl);
  //   print('data now ${data.data}');
  //   print('Hellooooo');
  // }

  double bottomPaddingMap = 0.0;
  Position? currentPosition;
  GoogleMapController? googleMapController;
  void locationPosition() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    LatLng latLng = LatLng(position.altitude, position.longitude);
    CameraPosition cameraPosition = CameraPosition(
      target: latLng,
      zoom: 14.4746,
    );
    googleMapController!
        .animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
  }

  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  static const CameraPosition _kLake = CameraPosition(
      bearing: 12.8334901395799,
      target: LatLng(37.43296265331129, -122.08832357078792),
      tilt: 150,
      zoom: 10);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<MapsCubit, MapsCubitState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          return Stack(
            alignment: Alignment.bottomCenter,
            children: [
              GoogleMap(
                padding: EdgeInsets.only(bottom: bottomPaddingMap),
                mapType: MapType.hybrid,
                initialCameraPosition: _kGooglePlex,
                myLocationEnabled: true,
                tiltGesturesEnabled: true,
                compassEnabled: true,
                scrollGesturesEnabled: false,
                zoomControlsEnabled: true,
                onMapCreated: (GoogleMapController controller) {
                  _controller.complete(controller);
                  setState(() {
                    bottomPaddingMap = 330;
                  });
                  googleMapController = controller;
                  locationPosition();
                },
              ),
              const Positioned(
                  top: 450,
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: SearchLocationsCard()),
            ],
          );
        },
      ),
      // floatingActionButton: FloatingActionButton.extended(
      //   onPressed: _goToTheLake,
      //   label: const Text('To the lake!'),
      //   icon: const Icon(Icons.directions_boat),
      // ),
    );
  }

  Future<void> _goToTheLake() async {
    final GoogleMapController controller = await _controller.future;
    await controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
  }
}

void getPermission() async {
  prefix.Location location = new prefix.Location();

  bool _serviceEnabled;
  prefix.PermissionStatus _permissionGranted;
  prefix.LocationData _locationData;

  _serviceEnabled = await location.serviceEnabled();
  if (!_serviceEnabled) {
    _serviceEnabled = await location.requestService();
    if (!_serviceEnabled) {
      return;
    }
  }

  _permissionGranted = await location.hasPermission();
  if (_permissionGranted == prefix.PermissionStatus.denied) {
    _permissionGranted = await location.requestPermission();
    if (_permissionGranted != prefix.PermissionStatus.granted) {
      return;
    }
  }

  _locationData = await location.getLocation();
}
