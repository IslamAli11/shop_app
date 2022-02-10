 import 'package:shop_app/models/login_model/login_model.dart';

class RegisterStates{}

 class InitialRegisterState extends RegisterStates{}

 class LoadingRegisterState extends RegisterStates{}
 class RegisterSuccessState extends RegisterStates{
  final LoginModel registerModel;
  RegisterSuccessState(this.registerModel);
 }
 class RegisterErrorState extends RegisterStates{}
class EyeChangesSuccessState extends RegisterStates{}