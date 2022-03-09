import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app_win/Layout/Cubit/cubit.dart';
import 'package:shop_app_win/Layout/Cubit/states.dart';
import 'package:shop_app_win/Modules/Home/description_screen.dart';
import 'package:shop_app_win/Modules/Widgets/custom_text.dart';
import 'package:shop_app_win/Shared/component.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_grid_view.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';

class Products extends StatelessWidget {
  const Products({Key? key}) : super(key: key);

  @override
  Widget build(context) {
    return BlocConsumer<ShopLayoutCubit, ShopLayoutStates>(
      listener: (context, state)
      {
        if(state is ShopSuccessChangeFavoritesState)
        {
          if(state.model.status == false)
          {
            showToast(text: state.model.message.toString(),
                state: ToastStates.ERROR);
          } else if (state.model.status == true)
          {
            showToast(text: state.model.message.toString(),
                state: ToastStates.SUCCESS);
          }
        }
      },
      builder: (context, state) {
        var cubit = ShopLayoutCubit.get(context);
        var itemData = cubit.homeModel!.data!.products;
        return StaggeredGridView.countBuilder(
          physics: BouncingScrollPhysics(),
          shrinkWrap: true,
          crossAxisCount: 2,
          itemCount: cubit.homeModel!.data!.products!.length,
          itemBuilder: (context, int index) => Card(
            elevation: 5,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InkWell(
                  onTap: () {
                    navigateTo(
                        context,
                        DescriptionScreen(
                          description: itemData![index].description.toString(),
                          image: itemData[index].image.toString(),
                          discount: itemData[index].discount,
                          old_price: itemData[index].old_price,
                          price: itemData[index].price,
                        ));
                  },
                  child: Stack(
                    alignment: AlignmentDirectional.bottomStart,
                    children: [
                      Image.network(
                        itemData![index].image.toString(),
                        height: 200,
                      ),
                      if (cubit.homeModel!.data!.products![index].discount != 0)
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
                Padding(
                  padding: const EdgeInsets.only(
                      bottom: 5, right: 5.0, left: 5.0, top: 5.0),
                  child: Column(
                    children: [
                      CustomText(
                        text: itemData[index].name.toString(),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              CustomText(
                                text: cubit
                                    .homeModel!.data!.products![index].price
                                    .toString(),
                                color: Colors.blue,
                              ),
                              if (cubit.homeModel!.data!.products![index]
                                  .discount !=
                                  0)
                                Column(
                                  children: [
                                    CustomText(
                                      text: 'discount',
                                      fontSize: 14,
                                      color: Colors.grey,
                                    ),
                                    CustomText(
                                      text: cubit.homeModel!.data!
                                          .products![index].discount
                                          .toString(),
                                      color: Colors.grey,
                                      fontSize: 14,
                                    ),
                                  ],
                                ),
                              if (cubit.homeModel!.data!.products![index]
                                  .discount !=
                                  0)
                                CustomText(
                                  text: cubit.homeModel!.data!.products![index]
                                      .old_price
                                      .toString(),
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
                                color: (cubit.favorites[itemData[index].id] == true)? Colors.red: Colors.grey),
                            onPressed: () {
                              cubit.ChangeFavorites(itemData[index].id);
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          staggeredTileBuilder: (int index) => new StaggeredTile.fit(1),
          mainAxisSpacing: 1.0,
          crossAxisSpacing: 1.0,
        );
      },
    );
  }
}
