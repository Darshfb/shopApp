import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app_win/Layout/Cubit/cubit.dart';
import 'package:shop_app_win/Layout/Cubit/states.dart';
import 'package:shop_app_win/Modules/Widgets/custom_text.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({Key? key}) : super(key: key);

  @override
  Widget build(context) {
    return BlocConsumer<ShopLayoutCubit, ShopLayoutStates>(
      listener: (context, state) {},
      builder: (context, state) {
        // var ShopLayoutCubit.get(context) = ShopLayoutCubit.get(context);
        return ConditionalBuilder(
          condition: ShopLayoutCubit.get(context).favoritesModel != null,
          fallback: (BuildContext context) => Center(child: CircularProgressIndicator(),),
          builder: (BuildContext context) => ListView.builder(
            physics: BouncingScrollPhysics(),
            scrollDirection: Axis.vertical,
            itemCount: ShopLayoutCubit.get(context).favoritesModel!.data!.data.length,
            itemBuilder: (context, int index) {
              return  Card(
                      elevation: 20.0,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0)),
                      child: Container(
                        height: 130.0,
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 15.0),
                              child: Stack(
                                alignment: AlignmentDirectional.bottomCenter,
                                children: [
                                  Image.network(
                                    ShopLayoutCubit.get(context)
                                        .favoritesModel!
                                        .data!
                                        .data[index]
                                        .product!
                                        .image
                                        .toString(),
                                    fit: BoxFit.cover,
                                    width: 100,
                                    height: 100,
                                  ),
                                  if (ShopLayoutCubit.get(context).homeModel!.data!.products![index].discount != 0)
                                    Container(
                                      padding: EdgeInsets.symmetric(horizontal: 5.0),
                                      color: Colors.red,
                                      child: Text(
                                        'DICOUNT',
                                        style:
                                        TextStyle(color: Colors.white, fontSize: 10),
                                      ),
                                    )
                                ],
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    CustomText(
                                      text: ShopLayoutCubit.get(context).favoritesModel!
                                          .data!.data[index].product!.name.toString(),
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            CustomText(
                                              text: ShopLayoutCubit.get(context)
                                                  .favoritesModel!
                                                  .data!
                                                  .data[index]
                                                  .product!
                                                  .price
                                                  .toString(),
                                              color: Colors.blue,
                                            ),
                                            if (ShopLayoutCubit.get(context).homeModel!.data!.products![index].discount != 0)
                                              Column(
                                                children: [
                                                  CustomText(
                                                    text: 'Discount',
                                                    fontSize: 14,
                                                    color: Colors.grey,
                                                  ),
                                                  CustomText(
                                                    text: ShopLayoutCubit.get(
                                                            context)
                                                        .favoritesModel!
                                                        .data!
                                                        .data[index]
                                                        .product!
                                                        .discount
                                                        .toString(),
                                                    color: Colors.grey,
                                                    fontSize: 14,
                                                  ),
                                                ],
                                              ),
                                            if (ShopLayoutCubit.get(context)
                                                    .homeModel!
                                                    .data!
                                                    .products![index]
                                                    .discount !=
                                                0)
                                              CustomText(
                                                text: ShopLayoutCubit.get(context)
                                                    .favoritesModel!
                                                    .data!
                                                    .data[index]
                                                    .product!
                                                    .old_price
                                                    .toString(),
                                                textDecoration:
                                                    TextDecoration.lineThrough,
                                                color: Colors.grey,
                                              ),
                                          ]),
                                    ),
                                    IconButton(
                                      padding: EdgeInsets.zero,
                                      iconSize: 18,
                                      icon: Icon(Icons.favorite,
                                          color: (ShopLayoutCubit.get(context)
                                            .favorites[ShopLayoutCubit.get(context)
                                              .favoritesModel!
                                              .data!
                                              .data[index]
                                              .product!
                                            .id] == true)? Colors.red: Colors.grey),
                                      onPressed: () {
                                        ShopLayoutCubit.get(context).ChangeFavorites(ShopLayoutCubit.get(context)
                                            .favoritesModel!
                                            .data!
                                            .data[index]
                                            .product!
                                            .id);
                                      },
                                    ),

                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
            },
          ),
        );

      },
    );
  }

  Widget buildFavItem({
    String? image,
    String? name,
    dynamic price,
    dynamic oldPrice,
    dynamic discount,
  }) =>
      Card(
        elevation: 20.0,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        child: Container(
          height: 130.0,
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 15.0),
                child: Stack(
                  alignment: AlignmentDirectional.bottomCenter,
                  children: [
                    Image.network(
                      image.toString(),
                      fit: BoxFit.cover,
                      width: 100,
                      height: 100,
                    ),
                    // if (ShopLayoutCubit.get(context).homeModel!.data!.products![index].discount != 0)
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 5.0),
                      color: Colors.red,
                      child: Text(
                        'DICOUNT',
                        style: TextStyle(color: Colors.white, fontSize: 10),
                      ),
                    )
                  ],
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      CustomText(
                        text: name,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              CustomText(
                                text: price!,
                                color: Colors.blue,
                              ),
                              // if (ShopLayoutCubit.get(context).homeModel!.data!.products![index].discount != 0)
                              Column(
                                children: [
                                  CustomText(
                                    text: 'Discount',
                                    fontSize: 14,
                                    color: Colors.grey,
                                  ),
                                  CustomText(
                                    text: discount,
                                    color: Colors.grey,
                                    fontSize: 14,
                                  ),
                                ],
                              ),
                              // if (ShopLayoutCubit.get(context).homeModel!.data!.products![index]
                              //     .discount !=
                              //     0)
                              CustomText(
                                text: oldPrice,
                                textDecoration: TextDecoration.lineThrough,
                                color: Colors.grey,
                              ),
                            ]),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          IconButton(
                              padding: EdgeInsets.zero,
                              iconSize: 18,
                              onPressed: () {},
                              icon: Icon(
                                Icons.shopping_cart_outlined,
                                color: Colors.red,
                              )),
                          IconButton(
                            padding: EdgeInsets.zero,
                            iconSize: 18,
                            icon: Icon(Icons.favorite,
                                color:
                                    // color: (ShopLayoutCubit.get(context).favorites[itemData[index].id] == true)? Colors.red:
                                    Colors.grey),
                            onPressed: () {
                              //ShopLayoutCubit.get(context).ChangeFavorites(itemData[index].id);
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
}
