 import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/cubit/cubit.dart';
import 'package:shop_app/layout/cubit/states.dart';
import 'package:shop_app/modules/search/search_screen.dart';

class ShopLayout extends StatelessWidget {
   const ShopLayout({Key? key}) : super(key: key);

   @override
   Widget build(BuildContext context) {
     return BlocConsumer<ShopCubit , ShopStates>(
       listener:(context , state){},
       builder: (context , state){

         var cubit = ShopCubit.get(context);

         return Scaffold(

           appBar:  AppBar(
             title: Row(
               children: const [
                 Icon(
                     Icons.shop_outlined,
                   color: Colors.redAccent,
                   size: 30.0,

                 ) ,
                 SizedBox(
                   width: 10.0,
                 ),
                 Text('E mark'),
               ],
             ),
            actions: [
              CircleAvatar(
                backgroundColor: Colors.grey[300],
                child: IconButton(
                  onPressed: (){
                    Navigator.push(
                        context,
                        MaterialPageRoute(builder:(context)=> SearchScreen()));
                  },
                  icon: const Icon(
                      Icons.search,
                    color: Colors.black,
                  ),
                ),
              ),
            ],
           ),
           body: cubit.screen[cubit.currentIndex],
           bottomNavigationBar: BottomNavigationBar(
             currentIndex: cubit.currentIndex,
             onTap: (int index){
               cubit.changeBottomNav(index);
             },
             items: const [
               BottomNavigationBarItem(
                   icon:Icon(Icons.home),
                 label: 'Home',
               ),
               BottomNavigationBarItem(
                   icon:Icon(Icons.apps),
                 label: 'Categories',
               ),
               BottomNavigationBarItem(
                   icon: Icon(Icons.favorite),
                 label: 'Favorites',
               ),
               BottomNavigationBarItem(
                   icon: Icon(Icons.settings),
                 label: 'Setting',
               ),

             ],
           ),
         );
       },

     );
   }
 }
