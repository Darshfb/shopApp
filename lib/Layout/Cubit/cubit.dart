import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app_win/Layout/Cubit/states.dart';
import 'package:shop_app_win/Models/Category/category_model.dart';
import 'package:shop_app_win/Models/Favorites/change_favorite_model.dart';
import 'package:shop_app_win/Models/Favorites/favorite_model.dart';
import 'package:shop_app_win/Models/Home/home_model.dart';
import 'package:shop_app_win/Modules/Category/category_screen.dart';
import 'package:shop_app_win/Modules/Favorite/favorite_screen.dart';
import 'package:shop_app_win/Modules/Home/home_screen.dart';
import 'package:shop_app_win/Modules/settings/settings_screen.dart';
import 'package:shop_app_win/Shared/cache_helper.dart';
import 'package:shop_app_win/Shared/dio_helper.dart';
import 'package:shop_app_win/Shared/Constants/endpoints.dart';

class ShopLayoutCubit extends Cubit<ShopLayoutStates> {
  ShopLayoutCubit() : super(ShopLayoutInitialStates());

  static ShopLayoutCubit get(context) => BlocProvider.of(context);

  String TOKEN = '${CacheHelper.getData(key: 'token')}';
  List<Widget> screens = [
    FavoriteScreen(),
    HomeScreen(),
    CategoryScreen(),
    SettingsScreen()
  ];

  int index = 1;

  void bottomNavigationBar(value) {
    index = value;
    emit(ShopBottomNavigationBarStates());
  }

  HomeModel? homeModel;
  Map<int, bool> favorites = {};
  Map<int, bool> cart = {};

  void getHomeData() {
    emit(ShopLoadingHomeDataState());
    DioHelper.getData(
      url: HOME,
      token: '${CacheHelper.getData(key: 'token')}',
    ).then((value) async {
      homeModel = HomeModel.fromJson(value.data);
      // print('status >>>>>> ${homeModel!.status}');
      // print('............... token is ${CacheHelper.getData(key: 'token')}');
      // printWrapped(value.data.toString());
      //print('Home Model is ${value.data}');
      homeModel!.data!.products!.forEach((element) {
        favorites.addAll({element.id!: element.in_favorites});
      });
      homeModel!.data!.products!.forEach((element) {
        cart.addAll({element.id!: element.in_cart});
      });
      print(TOKEN);
      //  print(favorites.toString());
      emit(ShopSuccessHomeDataState());
    }).catchError((error) {
      emit(ShopErrorHomeDataState(error));
      //  print('******* Error when get home Data ${error.toString()}');
    });
  }

  CategoryModel? categoryModel;

  void getCategoryData() {
    DioHelper.getData(
      url: CATEGORIES,
    ).then((value) async {
      emit(ShopSuccessCategoryState());
      categoryModel = await CategoryModel.fromJson(value.data);
      // print('................. ${categoryModel!.status.toString()}');
      // print(
      //     '................. ${categoryModel!.data!.data![0].name.toString()}');
    }).catchError((error) {
      emit(ShopErrorCategoryState(error));
      // print('>>>>>>>>>>>>>> Category Error is ${error.toString()}');
    });
  }

  ChangeFavoritesModel? changeFavoritesModel;

  void ChangeFavorites(int? productId) {
    favorites[productId!] = !favorites[productId]!;
    emit(ShopChangeFavoritesState());
    DioHelper.postData(url: FAVORITES, token: TOKEN, data: {
      'product_id': productId,
    }).then((value) async {
      //print(value.data);
      changeFavoritesModel = await ChangeFavoritesModel.fromJson(value.data);
      if (changeFavoritesModel!.status == false) {
        favorites[productId] = !favorites[productId]!;
      } else {
        getFavorite();
      }
      emit(ShopSuccessChangeFavoritesState(changeFavoritesModel!));
    }).catchError((error) {
      favorites[productId] = !favorites[productId]!;

      emit(ShopErrorChangeFavoritesState(error));
    });
  }

  FavoritesModel? favoritesModel;

  void getFavorite() {
    emit(ShopLoadingFavoriteState());
    DioHelper.getData(
      url: FAVORITES,
      token: TOKEN,
    ).then((value) async {
      favoritesModel = await FavoritesModel.fromJson(value.data);
      print('favoiteData = ${value.data}');
      emit(ShopSuccessFavoriteState());
      print('hhhhhhhhhhhhhhhhhhhhh ${favoritesModel!.data!.data.length}');
    }).catchError((error) {
      print('sssssssssssss $error');
      emit(ShopErrorFavoriteState(error));
    });
  }
}
