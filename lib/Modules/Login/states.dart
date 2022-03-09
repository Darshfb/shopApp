import 'package:shop_app_win/Models/ShopLogin/shop_model.dart';

abstract class ShopLoginStates {}

class ShopLoginInitialStates extends ShopLoginStates {}

class ShopLoginLoadingStates extends ShopLoginStates {}

class ShopLoginSuccessStates extends ShopLoginStates {
  ShopLoginModel? model;

  ShopLoginSuccessStates(this.model);
}

class ShopLoginErrorStates extends ShopLoginStates {
  final String error;

  ShopLoginErrorStates(this.error);
}

class ShopLoginVisibilityStates extends ShopLoginStates {}
