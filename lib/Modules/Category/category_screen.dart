import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app_win/Layout/Cubit/cubit.dart';
import 'package:shop_app_win/Layout/Cubit/states.dart';

class CategoryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopLayoutCubit, ShopLayoutStates>(
      listener: (BuildContext context, state) {},
      builder: (BuildContext context, Object? state) {
        var cubit = ShopLayoutCubit.get(context);
        //var itemData = cubit.categoryModel!.data!.data;
        return Container(
          height: 100,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: cubit.categoryModel!.data!.data!.length,
            itemBuilder: (context, int index) {
              return (cubit.categoryModel!.data!.data == null) ? Center(child: CircularProgressIndicator(),) :buildItem(
                  image:
                      cubit.categoryModel!.data!.data![index].image.toString(),
                  nameItem:
                      cubit.categoryModel!.data!.data![index].name.toString());
            },
          ),
        );
      },
    );
  }

  Widget buildItem({
    String? image,
    String? nameItem,
  }) =>
      Container(
        width: 100,
        height: 100,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(15.0)),
        padding: EdgeInsetsDirectional.only(start: 5, end: 5),
        child: Stack(
          alignment: AlignmentDirectional.bottomCenter,
          children: [
            Container(
              height: 100,
              width: 100,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.0),
                  image: DecorationImage(
                    image: NetworkImage(image!),
                    fit: BoxFit.cover,
                  )),
              child: Image(
                image: NetworkImage(image),
                height: 100,
                width: 100,
                fit: BoxFit.cover,
              ),
            ),
            Container(
              color: Colors.black.withOpacity(0.8),
              width: double.infinity,
              child: Text(
                nameItem!,
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      );
//   return Scaffold(
//     body: Column(
//       children: [],
//     ),
//   );
// }
}
