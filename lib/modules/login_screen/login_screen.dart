
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/layout/shop_layout.dart';
import 'package:shop_app/modules/login_screen/cubit/login_screen_cubit.dart';
import 'package:shop_app/modules/login_screen/cubit/login_states.dart';
import 'package:shop_app/modules/register_screen/register_screen.dart';
import 'package:shop_app/shared/component/component.dart';
import 'package:shop_app/shared/network/endpiont.dart';
import 'package:shop_app/shared/network/remote/cach_helper.dart';


class LoginScreen extends StatelessWidget {

    LoginScreen({Key? key}) : super(key: key);
    var emailController= TextEditingController();
    var passwordController= TextEditingController();
    var locationController = TextEditingController();
    var keyboardType= TextInputType;
    var formKey = GlobalKey<FormState>();


    @override
    Widget build(BuildContext context) {
      return BlocProvider(
        create: (BuildContext context)=>ShopLoginCubit(),
        child: BlocConsumer<ShopLoginCubit , ShopLoginStates>(
         listener: (context , state){
           if(state is ShopLoginSuccessState){
            if(state.loginModel.status!){
              print(state.loginModel.status);
              print(state.loginModel.data!.token!);

              CacheHelper.saveData(
                  key: 'token',
                  value:state.loginModel.data!.token!).then((value){
                    token = state.loginModel.data!.token!;
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder:(context)=>const ShopLayout()),
                        (route) => false
                );

              });


              Fluttertoast.showToast(
                  msg: state.loginModel.message!,
                  toastLength: Toast.LENGTH_LONG,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 5,
                  backgroundColor: Colors.green,
                  textColor: Colors.white,
                  fontSize: 16.0
              );

            }
              else
            {
              print(state.loginModel.message!);
              Fluttertoast.showToast(
                  msg:state.loginModel.message!,
                  toastLength: Toast.LENGTH_LONG,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 5,
                  backgroundColor: Colors.red,
                  textColor: Colors.white,
                  fontSize: 16.0
              );

            }
           }

         },
          builder: (context , state){
           return  Scaffold(
             appBar: AppBar(

             ),
             body: Center(
               child: Padding(
                 padding: const EdgeInsets.all(20.0),
                 child: SingleChildScrollView(
                   child: Form(
                     key: formKey,
                     child: Column(
                       crossAxisAlignment: CrossAxisAlignment.start,
                       children:  [
                         if(state is ShopLoginLoadingState)
                           const LinearProgressIndicator(),
                         const SizedBox(
                           height: 20.0,
                         ),
                         const Text(
                           'Login',
                           style: TextStyle(
                             fontSize: 35.0,
                             fontWeight: FontWeight.bold,
                           ),

                         ),
                         const SizedBox(
                           height: 30.0,
                         ),
                         defaultTextFormField(
                           controller: emailController,
                           label: 'email',
                           validate:(String? value){
                             if(value!.isEmpty) {
                               return 'please Enter your Email';
                             }
                             else {
                               return null;
                             }

                           },

                           keyboardType:TextInputType.emailAddress,
                           prefix:Icons.email,
                         ),
                         const SizedBox(
                           height: 15.0,
                         ),
                         defaultTextFormField(
                           label: 'Password',
                           prefix: Icons.lock,
                           controller: passwordController,
                           keyboardType: TextInputType.visiblePassword,
                           validate: (String? value){
                             if(value!.isEmpty){
                               return 'please Enter your password';
                             }
                             return null;
                           },
                           obscureText:ShopLoginCubit.get(context).obscureText,
                           suffix:ShopLoginCubit.get(context).suffixIcon,
                           onPressIcon: (){
                             ShopLoginCubit.get(context).eyeChange();


                           }
                         ),

                         const SizedBox(
                           height: 15.0,
                         ),
                         defaultMaterialButton(
                           onPress:(){
                             if(formKey.currentState!.validate()){
                               ShopLoginCubit.get(context).shopLogin(
                                   email: emailController.text,
                                  password: passwordController.text,

                               );

                             }

                           },
                           color: Colors.blue,
                           text: 'LOGIN',

                         ),

                         Row(
                           mainAxisAlignment: MainAxisAlignment.center,
                           children: [
                             const Text('Don\'t have an account?'),
                             TextButton(
                               onPressed:(){
                                 Navigator.push(context,
                                   MaterialPageRoute(
                                       builder:(context)=> RegisterScreen()),
                                 );
                               },
                               child:const Text('REGISTER NOW'),
                             ),
                           ],
                         ),

                       ],
                     ),
                   ),
                 ),
               ),
             ),
           );
          },
        ),
      );

    }

}

