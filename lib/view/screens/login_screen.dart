import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:uber/helper/widget/defualt_button.dart';
import 'package:uber/helper/widget/text_form_field.dart';

import '../../core/routes/app_routes.dart';
import '../../helper/widget/toast.dart';
import '../../view_model.dart/cubit/auth_cubit/auth_cubit.dart';
import '../../view_model.dart/cubit/auth_cubit/auth_states.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  var fromKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: SingleChildScrollView(
            child: BlocConsumer<AuthCubit, UberStates>(
              listener: (context, state) {
                if (state is ErrorUberState) {
        // AppToast.errorBar(message:state.error);

                  // snackBar(context,
                  //     backgroundColor: Colors.red,
                  //     title: state.error,
                  //     textColor: Colors.white);
                }
                // TODO: implement listener
              },
              builder: (context, state) {
                return Form(
                  key: fromKey,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(
                          height: 30,
                        ),
                        Image.asset('assets/images/logo.png'),
                        const Text(
                          "Login as a Rider",
                          style: TextStyle(
                              fontFamily: 'Bolt Semibold',
                              color: Colors.black,
                              fontSize: 20),
                        ),
                        TextFormFieldWidget(
                          controller: emailController,
                          hintText: ' Email',
                          validator: (v) {
                            if (v!.isEmpty) {
                              return 'Please Enter email';
                            }
                            if (!v.validateEmail()) {
                              return 'Enter a Valid Email';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormFieldWidget(
                          controller: passwordController,
                          hintText: 'Password',
                          validator: (v) {
                            if (v!.isEmpty) {
                              return 'Enter password';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        state is LoadingUberState
                            ? const Center(
                                child: CircularProgressIndicator(
                                  // backgroundColor: Colors.amber,
                                  color: Colors.amber,
                                ),
                              )
                            : DefaultButton(
                                buttonText: 'Login',
                                function: () {
                                  if (fromKey.currentState!.validate()) {
                                    context.read<AuthCubit>().signIn(
                                        email: emailController.text.trim(),
                                        password:
                                            passwordController.text.trim(),
                                        context: context);
                                  }
                                },
                              ),
                        const SizedBox(
                          height: 20,
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              AppRoutes.signUp,
                              arguments: 'Test'
                            );
                          },
                          child: RichText(
                            text: const TextSpan(
                              text: 'Do not have any account? ',
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.black,
                                fontFamily: 'Bolt Semibold',
                              ),
                              children: [
                                TextSpan(
                                  text: "Register Here",
                                  style: TextStyle(
                                      fontFamily: 'Bolt Semibold',
                                      color: Colors.black,
                                      fontSize: 15),
                                ),
                              ],
                            ),
                          ),
                        )
                      ]),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
