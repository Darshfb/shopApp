import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app_win/Layout/Cubit/cubit.dart';
import 'package:shop_app_win/Layout/Cubit/states.dart';
import 'package:shop_app_win/Modules/Category/category_screen.dart';
import 'package:shop_app_win/Modules/Home/products.dart';
import 'package:shop_app_win/Modules/Home/slider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopLayoutCubit, ShopLayoutStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = ShopLayoutCubit.get(context);
          return Center(
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: ConditionalBuilder(
                  condition: cubit.homeModel != null,
                  builder: (context) => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SliderBanner(),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Categories',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                      CategoryScreen(),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'New Products',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                      Products(),
                    ],
                  ),
                  fallback: (context) => Center(
                        child: CupertinoActivityIndicator(
                       //   color: Colors.red,
                          radius: 36,
                        ),
                      )),
            ),
          );
        });
  }


  Widget buildItems({
    String? image,
    String? item,
  }) => Container(
    width: 100,
    height: 100,
    padding: EdgeInsetsDirectional.only(start: 5, end: 5),
    child: Stack(
      alignment: AlignmentDirectional.bottomCenter,
      children: [
        Image(
          image: NetworkImage(
              image!),
          height: 100,
          width: 100,
          fit: BoxFit.cover,
        ),
        Container(
          color: Colors.black.withOpacity(0.8),
          width: double.infinity,
          child: Text(
            item!,
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(color: Colors.white),
          ),
        ),
      ],
    ),
  );
}
