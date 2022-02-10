import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/cubit/states.dart';
import 'package:shop_app/models/categories_model.dart';
import 'package:shop_app/models/change_favorites_model.dart';
import 'package:shop_app/models/favorites_model.dart';
import 'package:shop_app/models/home_model.dart';
import 'package:shop_app/models/login_model/login_model.dart';
import 'package:shop_app/modules/catagories_screen.dart';
import 'package:shop_app/modules/favorites_screen.dart';
import 'package:shop_app/modules/home_screen.dart';
import 'package:shop_app/modules/login_screen/login_screen.dart';
import 'package:shop_app/modules/setting_screen.dart';
import 'package:shop_app/shared/network/endpiont.dart';
import 'package:shop_app/shared/network/remote/cach_helper.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';

class  ShopCubit extends Cubit<ShopStates>{
  ShopCubit() : super(ShopInitialState());

  static ShopCubit get(context)=>BlocProvider.of(context);

  int currentIndex = 0;

  List<Widget>screen=[

     const HomeScreen(),
     const CategoriesScreen(),
     const FavoritesScreen(),
      SettingScreen(),

  ];

  void changeBottomNav(int index){

    currentIndex = index;
    emit(ChangeShopBottomState());


  }
  HomeModel? homeModel;

  Map<int , bool> favorites = {};

  void getHomeData(){
    emit(ShopHomeLoadingState());

    DioHelper.getData(
        url: Home,
      token:token,
    ).then((value){
      homeModel = HomeModel.fromJson(value.data);
     // print(homeModel!.data!.banners[0].image);
      print(token);

      homeModel!.data!.products.forEach((element) {
        favorites.addAll({
          element.id! : element.inFavorite!,
        });
      //  print(favorites.toString());
      });
      emit(ShopHomeDataSuccessState());


    }).catchError((error){
      emit(ShopHomeDataErrorState());

    });


  }



  CategoriesModel? categoriesModel;

  void getCategoriesData(){

    DioHelper.getData(
        url: Categories_Data,
        token: token,
    ).then((value){
      categoriesModel = CategoriesModel.fromJson(value.data);
      emit(ShopCategoriesSuccessState());
    }).catchError((error){
      emit(ShopCategoriesErrorState());
    });

  }



  ChangeFavoritesModel? changeFavoritesModel;

  void changeFavorites(int productId){

    favorites[productId] = !favorites[productId]!;
    emit(ShopChangeFavoritesSuccessState());

    DioHelper.postData(
        url: FAVORITES,
        token: token,
        data:{
          'product_id' : productId,
        }
    ).then((value){
      changeFavoritesModel = ChangeFavoritesModel.fromJson(value.data);

      if(!favoritesModel!.status!) {
        favorites[productId] = !favorites[productId]!;
      }else{
        getFavoritesData();
      }

      emit(ShopFavoritesSuccessState());

    }).catchError((error){
      favorites[productId] = !favorites[productId]!;
      emit(ShopFavoritesErrorState());
    });

  }




  FavoritesModel? favoritesModel;

  void getFavoritesData(){
     emit(ShopLoadingGetFavoriteState());
    DioHelper.getData(
      url: FAVORITES,
      token: token,
    ).then((value){
     favoritesModel = FavoritesModel.fromJson(value.data);
     //print(value.data.toString());
      emit(ShopGetFavoritesSuccessState());
    }).catchError((error){
      emit(ShopGetFavoritesErrorState());
    });

  }

  LoginModel? userModel;

  void getUserProfile(){
    emit(ShopLoadingUserDataState());
    DioHelper.getData(
        url: PROFILE,
        token: token,
    ).then((value) {
      userModel = LoginModel.fromJson(value.data);
      print(userModel!.data!.name);
      emit(ShopGetUserDataSuccessState());
    }).catchError((error){
      emit(ShopGetUserDataErrorState());
    });

  }

  void logOut(context){
    CacheHelper.sharedPreferences.remove('token');
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context)=>LoginScreen()),
            (route) => false);

  }


LoginModel? updateModel;
  void updateProfile({
    required String name,
    required String email,
    required String phone,

  }){
    emit(LoadingUpdateProfileState());
    DioHelper.putData(
        url: UPDATE_PROFILE,
        token: token,
        data:{
          'name': name,
          'email':email,
          'phone':phone,
        }
    ).then((value){
      updateModel = LoginModel.fromJson(value.data);
      emit(UpdateProfileSuccessState(updateModel!));
    }).catchError((error){
      emit(UpdateProfileErrorState(error));

    });


  }


  HomeModel? productModel;
  void productsDescription(){
    emit(LoadingDescriptionState());
    DioHelper.getData(
      url:Home,
      token: token,
    ).then((value){
      productModel = HomeModel.fromJson(value.data);
      emit(SuccessDescriptionState());

    }).catchError((error){
      emit(ErrorDescriptionState());
    });

  }


  void favoritesDescription(){
    emit(LoadingDescriptionState());
    DioHelper.getData(
      url:FAVORITES,
      token: token,
    ).then((value){
      productModel = HomeModel.fromJson(value.data);
      emit(SuccessDescriptionState());

    }).catchError((error){
      emit(ErrorDescriptionState());
    });

  }




}