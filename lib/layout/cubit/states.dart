 import 'package:shop_app/models/login_model/login_model.dart';

abstract class ShopStates{}

 class ShopInitialState extends ShopStates{}

 class ChangeShopBottomState extends ShopStates{}

 class  ShopHomeLoadingState extends ShopStates{}

 class ShopHomeDataSuccessState extends ShopStates{}

 class ShopHomeDataErrorState extends ShopStates{}

 class ShopCategoriesSuccessState extends ShopStates{}

 class ShopCategoriesErrorState extends ShopStates{}

 class ShopFavoritesSuccessState extends ShopStates{}

 class ShopFavoritesErrorState extends ShopStates{}

 class ShopChangeFavoritesSuccessState extends ShopStates{}


 class ShopLoadingGetFavoriteState extends ShopStates{}
 class ShopGetFavoritesSuccessState extends ShopStates{}

 class ShopGetFavoritesErrorState extends ShopStates{}


 class ShopLoadingUserDataState extends ShopStates{}
 class ShopGetUserDataSuccessState extends ShopStates{}

 class ShopGetUserDataErrorState extends ShopStates{}


 class LoadingUpdateProfileState extends ShopStates{}

 class UpdateProfileSuccessState extends ShopStates{
  final LoginModel loginModel;

  UpdateProfileSuccessState(this.loginModel);

 }

 class UpdateProfileErrorState extends ShopStates{

  final String error;

  UpdateProfileErrorState(this.error);
 }



 class InitialDescriptionState extends ShopStates{}
 class LoadingDescriptionState extends ShopStates{}
 class SuccessDescriptionState extends ShopStates{}
 class ErrorDescriptionState extends ShopStates{}