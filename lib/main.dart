import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app_win/Layout/Cubit/cubit.dart';
import 'package:shop_app_win/Layout/ShopLayout/shop_layout.dart';
import 'package:shop_app_win/Modules/Login/cubit.dart';
import 'package:shop_app_win/Modules/Login/login_screen.dart';
import 'package:shop_app_win/Shared/Constants/const.dart';
import 'package:shop_app_win/Shared/Style/themes.dart';
import 'package:shop_app_win/Shared/Constants/bloc_ovserver.dart';
import 'package:shop_app_win/Shared/cache_helper.dart';
import 'package:shop_app_win/Shared/dio_helper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DioHelper.init();
  await CacheHelper.init();
  //token = CacheHelper.getData(key: 'token');
  print(
      '...................TOKEN IS ...................... ${CacheHelper.getData(key: 'token')}');
  BlocOverrides.runZoned(
    () {
      ShopLoginCubit();
    },
    blocObserver: MyBlocObserver(),
  );
  Widget widget;

  if (token != null) {
    widget = ShopLayout();
  } else {
    widget = LoginScreen();
  }
  runApp(MyApp(
    startwidget: widget,
  ));
}

class MyApp extends StatelessWidget {
  final Widget? startwidget;

  MyApp({this.startwidget});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => ShopLayoutCubit()..getHomeData()..getCategoryData()..getFavorite()),
      ],
      child: MaterialApp(
        title: 'Salla App',
        theme: lightTheme,
        darkTheme: darkTheme,
        home: startwidget,
      ),
    );
  }
}
