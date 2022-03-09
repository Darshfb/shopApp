import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app_win/Layout/Cubit/cubit.dart';
import 'package:shop_app_win/Layout/Cubit/states.dart';

class SliderBanner extends StatelessWidget {
  const SliderBanner({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopLayoutCubit, ShopLayoutStates>(
      listener: (BuildContext context, state) {},
      builder: (context, state) {
        var cubit = ShopLayoutCubit.get(context);
        var itemData = cubit.homeModel!.data!.banners!;
        return ConditionalBuilder(
            condition: state is ! ShopLoadingHomeDataState,
            builder: (context) => CarouselSlider.builder(
              itemCount: cubit.homeModel!.data!.banners!.length,
              options: CarouselOptions(
                height: MediaQuery.of(context).size.height / 3,
                viewportFraction: 1,
                initialPage: 0,
                enableInfiniteScroll: true,
                reverse: false,
                autoPlay: true,
                autoPlayInterval: Duration(seconds: 3),
                autoPlayAnimationDuration: Duration(milliseconds: 800),
                autoPlayCurve: Curves.fastOutSlowIn,
                enlargeCenterPage: true,
                scrollDirection: Axis.horizontal,
              ),
              itemBuilder: (BuildContext context, int index, int realIndex) {
                return FadeInImage.assetNetwork(
                  placeholder: 'assets/images/loading.gif',
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  image: itemData[index].image.toString(),
                );
              },
            ),
            fallback: (context)=> Center(child: CircularProgressIndicator(),));
      },

    );
  }
}
