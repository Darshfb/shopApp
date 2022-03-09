import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app_win/Layout/Cubit/cubit.dart';
import 'package:shop_app_win/Layout/Cubit/states.dart';
import 'package:shop_app_win/Modules/Cart/cart_screen.dart';
import 'package:shop_app_win/Modules/Login/login_screen.dart';
import 'package:shop_app_win/Modules/Search/search_screen.dart';
import 'package:shop_app_win/Modules/Widgets/custom_text.dart';
import 'package:shop_app_win/Shared/cache_helper.dart';
import 'package:shop_app_win/Shared/component.dart';

class ShopLayout extends StatelessWidget {
  const ShopLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopLayoutCubit, ShopLayoutStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = ShopLayoutCubit.get(context);
        return Scaffold(
            appBar: AppBar(
              title: Text(
                'Salla',
                style: TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 24,
                ),
              ),
              actions: [
                IconButton(
                    onPressed: () {
                      navigateTo(context, SearchScreen());
                    },
                    icon: Icon(Icons.search)),
              ],
            ),
            body: cubit.screens[cubit.index],
            bottomNavigationBar: BottomAppBar(
              shape: CircularNotchedRectangle(),
              notchMargin: 0.01,
              clipBehavior: Clip.antiAlias,
              child: BottomNavigationBar(
                  currentIndex: cubit.index,
                  onTap: (value) {
                    cubit.bottomNavigationBar(value);
                  },
                  type: BottomNavigationBarType.fixed,
                  items: [
                    BottomNavigationBarItem(
                        icon: Icon(Icons.favorite_border), label: 'Favorite'),
                    BottomNavigationBarItem(
                        icon: Icon(Icons.home_outlined), label: 'Home'),
                    BottomNavigationBarItem(
                        icon: Icon(Icons.category_outlined), label: 'Category'),
                    BottomNavigationBarItem(
                        icon: Icon(Icons.settings), label: 'Settings'),
                  ]),
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.miniCenterDocked,
            floatingActionButton: Container(
              height: 50,
              margin: const EdgeInsets.only(bottom: 10),
              child: FloatingActionButton(
                backgroundColor: Colors.grey.shade100,
                onPressed: () {
                  navigateTo(context, CartScreen());
                },
                child: Icon(
                  Icons.shopping_cart_outlined,
                  color: Colors.black,
                ),
              ),
            ));
      },
    );
  }
}
