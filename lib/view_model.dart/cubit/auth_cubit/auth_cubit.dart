import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:uber/view_model.dart/cubit/auth_cubit/auth_states.dart';

import '../../../core/routes/app_routes.dart';
import '../../../helper/widget/toast.dart';

class AuthCubit extends Cubit<UberStates> {
  AuthCubit() : super(InitialUberState());
  AuthCubit get(context) => BlocProvider.of(context);

  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  var userRef = FirebaseDatabase.instance.ref().child('Users');
  void registerANewUser(
      {required String name,
      required String email,
      required String password,
      required String phone,
      context}) async {
    try {
      var firebaseUserAuth = await firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      Map userData = {"Name": name, "Email": email, "Phone": phone};
      userRef.child(firebaseUserAuth.user!.uid).set(userData);

      if (firebaseUserAuth.user != null) {

        Navigator.pushNamed(
          context,
          AppRoutes.mapScreen,
        );
        
        AppToast.successBar(message: 'Login successfully');
      } else {
        AppToast.errorBar(message: 'The email not successful');
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        AppToast.errorBar(message: 'The password provided is too weak.');
      }

      if (e.code == 'email-already-in-use') {
        AppToast.errorBar(
            message: 'The account already exists for that email.');
      }
    } catch (e) {
      AppToast.errorBar(message: 'There is an Error $e');

      print(e);
    }
  }

  void signIn(
      {required String email, required String password, context}) async {
    emit(LoadingUberState());
    try {
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      if (credential.user != null) {
        Navigator.pushNamed(
          context,
          AppRoutes.mapScreen,
        );
        AppToast.successBar(message: 'Login successfully');
        print('${credential.user!.email}');
        print('${credential.additionalUserInfo!.profile}');
        print('${credential.additionalUserInfo!.username}');
        emit(SuccessUberState());
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        AppToast.errorBar(message: 'No user found for that email.');
        print('No user found for that email.');
      }
      if (e.message == 'wrong-password') {
        AppToast.errorBar(message: 'Wrong password provided for that user.');
      }
      emit(ErrorUberState(error: e.message.toString()));
    } catch (e) {
      AppToast.errorBar(message: 'There is an Error $e');

      print('from ####### ${e}');
    }
  }
}
