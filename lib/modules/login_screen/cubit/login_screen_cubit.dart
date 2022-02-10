 import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/login_model/login_model.dart';
import 'package:shop_app/modules/login_screen/cubit/login_states.dart';
import 'package:shop_app/shared/network/endpiont.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';

class ShopLoginCubit extends Cubit<ShopLoginStates>{
  ShopLoginCubit() : super(ShopLoginInitialState());
  static ShopLoginCubit get(context) =>BlocProvider.of(context);
  IconData suffixIcon =  Icons.visibility;
  bool obscureText= true;
 LoginModel? loginModel;
void eyeChange(){
  obscureText = !obscureText;
  suffixIcon = obscureText?Icons.visibility:Icons.visibility_off;
  emit(ShopEyeChangeState());

}
  void shopLogin({

    required String email,
    required String password,

}){

    emit(ShopLoginLoadingState());

    DioHelper.postData(
        url:'login',
         data: {
           "email": email,
           "password" : password,



         },
    ).then((value){
     loginModel= LoginModel.fromJson(value.data);
   print(value.data.toString());
   print(loginModel!.data!.token);
      emit(ShopLoginSuccessState(loginModel!));

    }).catchError((error){
      print('error heeer  ${error.toString()}');
      emit(ShopLoginErrorState(error.toString()));

    });
  }



}