import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shop_app_win/Modules/Login/login_screen.dart';
import 'package:shop_app_win/Shared/cache_helper.dart';
import 'package:shop_app_win/Shared/component.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Log out'),
          IconButton(onPressed: ()
          {
            CacheHelper.clearData(key: 'token').then((value)
            {
              navigateTo(context, LoginScreen());
            });
          }, icon: Icon(Icons.add)),
        ],
      ),
    ));
  }
}
