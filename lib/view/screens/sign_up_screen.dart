import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:uber/helper/widget/defualt_button.dart';
import 'package:uber/helper/widget/text_form_field.dart';

import '../../view_model.dart/cubit/auth_cubit/auth_cubit.dart';
import '../../view_model.dart/cubit/auth_cubit/auth_states.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key });

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
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
                         Text(
                          "Register as a Rider ",
                          style: TextStyle(
                              fontFamily: 'Bolt Semibold',
                              color: Colors.black,
                              fontSize: 20),
                        ),
                        TextFormFieldWidget(
                          controller: nameController,
                          hintText: 'Name',
                          validator: (v) {
                            if (v!.isEmpty) {
                              return 'Please Enter Name';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormFieldWidget(
                          controller: emailController,
                          hintText: 'Email',
                          validator: (v) {
                            if (v!.isEmpty) {
                              return 'Enter Email';
                            }
                             if (!v.validateEmail()) {
                              return 'Please Enter Phone';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormFieldWidget(
                          controller: phoneController,
                          hintText: ' Phone',
                          validator: (v) {
                            if (v!.isEmpty) {
                              return 'Please Enter Phone';
                            }
                             if (!v.validatePhone()) {
                              return 'Please Enter Phone';
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
                        DefaultButton(
                          buttonText: 'Create Account',
                          function: () {
                            if (fromKey.currentState!.validate()) {
                              context.read<AuthCubit>().registerANewUser(
                                  name: nameController.text,
                                  email: emailController.text,
                                  password: passwordController.text,
                                  phone: phoneController.text,
                                  context: context);
                            }
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        InkWell(
                          onTap: () {},
                          child: RichText(
                            text: const TextSpan(
                              text: 'Already have an account? ',
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.black,
                                fontFamily: 'Bolt Semibold',
                              ),
                              children: [
                                TextSpan(
                                  text: "Login Here",
                                  style: TextStyle(
                                      fontFamily: 'Bolt Semibold',
                                      color: Colors.black,
                                      fontSize: 15),
                                ),
                              ],
                            ),
                          ),
                        ),
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
