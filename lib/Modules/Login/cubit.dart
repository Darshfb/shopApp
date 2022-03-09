import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app_win/Models/ShopLogin/shop_model.dart';
import 'package:shop_app_win/Modules/Login/states.dart';
import 'package:shop_app_win/Shared/dio_helper.dart';
import 'package:shop_app_win/Shared/Constants/endpoints.dart';

class ShopLoginCubit extends Cubit<ShopLoginStates> {
  ShopLoginCubit() : super(ShopLoginInitialStates());
    static ShopLoginCubit get(context) => BlocProvider.of(context);

  ShopLoginModel? shopLogin;
  void userLogin({required String email, required String password}) {
    emit(ShopLoginLoadingStates());
    DioHelper.postData(
        url: LOGIN,
        data: {
          'email': email,
          'password': password
        })
        .then((value) {
      print(value.data);
      shopLogin = ShopLoginModel.fromJson(value.data);
      emit(ShopLoginSuccessStates(shopLogin));
    }).catchError((error) {
      emit(ShopLoginErrorStates(error));
      print('1111111111111 $error');
    });
  }

  bool? obscure = true;
  IconData suffix = Icons.visibility_outlined;
  void changePasswordVisibility()
  {
    obscure = !obscure!;
    suffix = (obscure!) ? Icons.visibility_outlined :Icons.visibility_off_outlined ;
  emit(ShopLoginVisibilityStates());
  }
}
