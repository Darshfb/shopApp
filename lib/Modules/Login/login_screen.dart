import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app_win/Layout/ShopLayout/shop_layout.dart';
import 'package:shop_app_win/Modules/Login/cubit.dart';
import 'package:shop_app_win/Modules/Login/states.dart';
import 'package:shop_app_win/Modules/Widgets/custom_button.dart';
import 'package:shop_app_win/Modules/Widgets/custom_text.dart';
import 'package:shop_app_win/Modules/Widgets/custom_text_form_field.dart';
import 'package:shop_app_win/Modules/Widgets/text_button.dart';
import 'package:shop_app_win/Modules/register/register_screen.dart';
import 'package:shop_app_win/Shared/Style/const_color.dart';
import 'package:shop_app_win/Shared/cache_helper.dart';
import 'package:shop_app_win/Shared/component.dart';

class LoginScreen extends StatelessWidget {
  TextEditingController EmailController = TextEditingController();
  TextEditingController PasswordController = TextEditingController();
  var _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => ShopLoginCubit(),
      child: BlocConsumer<ShopLoginCubit, ShopLoginStates>(
        listener: (context, state) {
          if (state is ShopLoginSuccessStates) {
            if (state.model!.status!) {
              CacheHelper.saveData(
                      key: 'token', value: state.model!.data!.token)
                  .then((value) {
                navigateAndFinish(context, ShopLayout());
                print('>>>>>>>>>>> ${CacheHelper.getData(key: 'token')}');
              });
              showToast(
                  text: state.model!.message.toString(),
                  state: ToastStates.SUCCESS);
            } else {
              showToast(
                  text: state.model!.message.toString(),
                  state: ToastStates.ERROR);
              print(state.model!.message.toString());
            }
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
            ),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'LOGIN',
                          style: Theme.of(context)
                              .textTheme
                              .headline4!
                              .copyWith(color: Colors.black),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Text(
                          'Login now to browse our hot offers',
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1!
                              .copyWith(color: Colors.grey),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Container(
                          child: defaultTextFormField(
                            lableText: 'Email Address',
                            hintText: 'Enter your Email',
                            textInputType: TextInputType.emailAddress,
                            obscureText: false,
                            controller: EmailController,
                            validator: (String? value) {
                              if (value!.isEmpty) {
                                return 'please Enter your email address';
                              }
                            },
                            prefixIcon: Icons.email_outlined,
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Container(
                          child: defaultTextFormField(
                            lableText: 'Password',
                            hintText: 'Enter your password',
                            textInputType: TextInputType.visiblePassword,
                            controller: PasswordController,
                            onSubmit: (value) {
                              if (_formKey.currentState!.validate()) {
                                ShopLoginCubit.get(context).userLogin(
                                    email: EmailController.text,
                                    password: PasswordController.text);
                              }
                            },
                            validator: (String? value) {
                              if (value!.isEmpty) {
                                return 'please Enter your password';
                              }
                            },
                            prefixIcon: Icons.lock_outline,
                            obscureText: ShopLoginCubit.get(context).obscure,
                            suffixIcon: ShopLoginCubit.get(context).suffix,
                            suffixPressed: () {
                              ShopLoginCubit.get(context)
                                  .changePasswordVisibility();
                            },
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        ConditionalBuilder(
                          condition: state is! ShopLoginLoadingStates,
                          builder: (context) => CustomButton(
                            onPressed: () {
                              // _formKey.currentState!.save();
                              if (_formKey.currentState!.validate()) {
                                ShopLoginCubit.get(context).userLogin(
                                    email: EmailController.text,
                                    password: PasswordController.text);
                              }
                            },
                            backgroundColor: defaultColor,
                            minWidth: double.infinity,
                            child: CustomText(
                              text: 'login'.toUpperCase(),
                            ),
                          ),
                          fallback: (context) => const Center(
                            child: CircularProgressIndicator(),
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          children: [
                            Text('Don\'t have an account'),
                            defaultTextButton(
                              text: 'register',
                              onPressed: () {
                                Navigator.push(context, MaterialPageRoute(
                                    builder: (BuildContext context) {
                                  return RegisterScreen();
                                }));
                              },
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
