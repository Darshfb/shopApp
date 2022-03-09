import 'package:shop_app_win/Models/Favorites/change_favorite_model.dart';

abstract class ShopLayoutStates {}

class ShopLayoutInitialStates extends ShopLayoutStates {}

class ShopBottomNavigationBarStates extends ShopLayoutStates {}

class ShopLoadingHomeDataState extends ShopLayoutStates {}

class ShopSuccessHomeDataState extends ShopLayoutStates {}

class ShopErrorHomeDataState extends ShopLayoutStates {
  final dynamic error;
  ShopErrorHomeDataState(this.error);
}

class ShopLoadingCategoryState extends ShopLayoutStates {}

class ShopSuccessCategoryState extends ShopLayoutStates {}

class ShopErrorCategoryState extends ShopLayoutStates {
  final dynamic error;

  ShopErrorCategoryState(this.error);
}

class ShopChangeFavoritesState extends ShopLayoutStates {}

class ShopSuccessChangeFavoritesState extends ShopLayoutStates {
  final ChangeFavoritesModel model;

  ShopSuccessChangeFavoritesState(this.model);
}

class ShopErrorChangeFavoritesState extends ShopLayoutStates {
  final dynamic error;

  ShopErrorChangeFavoritesState(this.error);
}

class ShopLoadingFavoriteState extends ShopLayoutStates {}

class ShopSuccessFavoriteState extends ShopLayoutStates {}

class ShopErrorFavoriteState extends ShopLayoutStates {
  final dynamic error;

  ShopErrorFavoriteState(this.error);
}