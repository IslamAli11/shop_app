import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/cubit/cubit.dart';
import 'package:shop_app/layout/cubit/states.dart';
import 'package:shop_app/shared/component/component.dart';

class SettingScreen extends StatelessWidget {
   SettingScreen({Key? key}) : super(key: key);

  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

      ),
      body: BlocConsumer<ShopCubit , ShopStates>(
        listener: (context , state){},
        builder: (context , index){
         var cubit= ShopCubit.get(context).userModel!.data;
         nameController.text = cubit!.name!;
         emailController.text = cubit.email!;
         phoneController.text = cubit.phone!;

          return BlocConsumer<ShopCubit , ShopStates>(
            listener: (context , state){},
            builder: (context , state){
              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      if(state is LoadingUpdateProfileState)
                        const LinearProgressIndicator(),
                      const SizedBox(
                        height: 15.0,
                      ),
                      defaultTextFormField(
                        controller: nameController,
                        label: 'Name',
                        validate:(String? value){
                          if(value!.isEmpty){
                            return 'name must\'t be empty';

                          }
                          return null;

                        },

                        keyboardType: TextInputType.name,
                        prefix:Icons.person,
                      ),
                      const SizedBox(
                        height: 15.0,
                      ),
                      defaultTextFormField(
                        controller: emailController,
                        label: 'Email',
                        validate:(String? value){
                          if(value!.isEmpty){
                            return 'Email must\'t be empty';

                          }
                          return null;

                        },

                        keyboardType: TextInputType.emailAddress,
                        prefix:Icons.email,
                      ),
                      const SizedBox(
                        height: 15.0,
                      ),
                      defaultTextFormField(
                        controller: phoneController,
                        label: 'Phone',
                        validate:(String? value){
                          if(value!.isEmpty){
                            return 'Phone must\'t be empty';

                          }
                          return null;

                        },

                        keyboardType: TextInputType.phone,
                        prefix:Icons.phone,
                      ),
                      const SizedBox(
                        height: 15.0,
                      ),
                      defaultMaterialButton(
                          onPress:(){
                            ShopCubit.get(context).updateProfile(
                                name: nameController.text,
                                email: emailController.text,
                                phone: phoneController.text,
                            );
                          },
                        color: Colors.blue,
                        text: 'UPDATE',
                      ),
                      const SizedBox(
                        height: 15.0,
                      ),
                      defaultMaterialButton(
                        onPress:(){
                    ShopCubit.get(context).logOut(context);

                        },
                        color: Colors.blue,
                        text : 'LogOut',

                      ),

                    ],
                  ),
                ),
              );
            },

          );
        },

      ),
    );
  }
}
