import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/login_model/login_model.dart';
import 'package:shop_app/modules/register_screen/cubit/states.dart';
import 'package:shop_app/shared/network/endpiont.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';

class RegisterCubit extends Cubit<RegisterStates>{
  RegisterCubit() : super(InitialRegisterState());

 static RegisterCubit get(context)=>BlocProvider.of(context);
  IconData suffixIcon =  Icons.visibility;
  bool obscureText= true;

  LoginModel? registerModel;
  void eyeChange() {
    obscureText = !obscureText;
    suffixIcon = obscureText ? Icons.visibility : Icons.visibility_off;
    emit(EyeChangesSuccessState());
  }

  void shopRegister({
    required String name,
    required String email,
    required String phone,
    required String password,
}){
    emit(LoadingRegisterState());
    DioHelper.postData(
        url: REGISTER,
        data:{
          'name' : name,
          'email': email,
          'phone': phone,
          'password':password,
        }
    ).then((value){
      registerModel = LoginModel.fromJson(value.data);
      emit(RegisterSuccessState(registerModel!));
    }).catchError((error){
      emit(RegisterErrorState());
    });

  }

}