 import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/shop_layout.dart';
import 'package:shop_app/modules/register_screen/cubit/cubit.dart';
import 'package:shop_app/modules/register_screen/cubit/states.dart';
import 'package:shop_app/shared/component/component.dart';
import 'package:shop_app/shared/network/endpiont.dart';
import 'package:shop_app/shared/network/remote/cach_helper.dart';

class RegisterScreen extends StatelessWidget {
    RegisterScreen({Key? key}) : super(key: key);
    var formKey = GlobalKey<FormState>();
   var nameController = TextEditingController();
   var emailController = TextEditingController();
   var passwordController = TextEditingController();
   var phoneController = TextEditingController();


   @override
   Widget build(BuildContext context) {
     return Scaffold(
       appBar: AppBar(),
       body: Center(
         child: BlocProvider(
           create: (context)=>RegisterCubit(),
           child: BlocConsumer<RegisterCubit , RegisterStates>(
             listener: (context, state){
               if(state is RegisterSuccessState){
                 if(state.registerModel.status!){
                   CacheHelper.saveData(
                       key:'token',
                       value:state.registerModel.data!.token
                   ).then((value) {
                     token = state.registerModel.data!.token;
                     Navigator.pushAndRemoveUntil(
                         context,
                         MaterialPageRoute(builder:(context)=>const ShopLayout()),
                             (route) => false);
                   });

                 }else
                   {
                     print(state.registerModel.message);
                   }



               }
             },
             builder: (context, state){
               return  Padding(
                 padding: const EdgeInsets.all(20.0),
                 child: SingleChildScrollView(
                   child: Form(
                     key: formKey,
                     child: Column(
                       crossAxisAlignment: CrossAxisAlignment.start,
                       children:  [
                         const Text(
                           'REGISTER',
                           style: TextStyle(
                             fontSize: 30.0,
                             fontWeight: FontWeight.bold,
                             color: Colors.blue,
                           ),
                         ),
                         const SizedBox(
                           height: 30.0,
                         ),
                         defaultTextFormField(
                             controller: nameController,
                             label: 'Name',
                             validate: (String? value){

                               if(value!.isEmpty){
                                 return 'name must\'nt be empty';
                               }
                             },

                             keyboardType: TextInputType.name,
                             prefix: Icons.person
                         ),
                         const SizedBox(
                           height: 15.0,
                         ),

                         defaultTextFormField(
                             controller: emailController,
                             label: 'Email',
                             validate: (String? value){

                               if(value!.isEmpty){
                                 return 'Email must\'nt be empty';
                               }
                             },

                             keyboardType: TextInputType.emailAddress,
                             prefix: Icons.email
                         ),
                         const SizedBox(
                           height: 15.0,
                         ),

                         defaultTextFormField(
                             controller: passwordController,
                             label: 'Password',
                             validate: (String? value){

                               if(value!.isEmpty){
                                 return 'Password must\'nt be empty';
                               }
                             },

                             keyboardType: TextInputType.visiblePassword,
                             prefix: Icons.lock,
                            suffix: RegisterCubit.get(context).suffixIcon,
                           obscureText: RegisterCubit.get(context).obscureText,
                           onPressIcon:(){
                               RegisterCubit.get(context).eyeChange();
                             }
                         ),
                         const SizedBox(
                           height: 15.0,
                         ),

                         defaultTextFormField(
                             controller: phoneController,
                             label: 'Phone',
                             validate: (String? value){

                               if(value!.isEmpty){
                                 return 'Phone must\'nt be empty';
                               }
                             },

                             keyboardType: TextInputType.phone,
                             prefix: Icons.phone
                         ),
                         const SizedBox(
                           height: 15.0,
                         ),
                         defaultMaterialButton(
                           onPress:(){
                           if(formKey.currentState!.validate()){
                             RegisterCubit.get(context).shopRegister(
                                 name: nameController.text,
                                 email: emailController.text,
                                 phone: phoneController.text,
                                password: phoneController.text,
                             );

                           }

                           },
                           text: 'REGISTER',
                           color: Colors.blue,
                         ),


                       ],
                     ),
                   ),
                 ),
               );
             },

           ),
         ),
       ),
     );
   }
 }
