import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:shop_app/layout/cubit/cubit.dart';
import 'package:shop_app/layout/cubit/states.dart';
import 'package:shop_app/shared/component/component.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocConsumer<ShopCubit , ShopStates>(
        listener: (context , state){},
        builder: (context , state){
          return Conditional.single(
            context: context,
            conditionBuilder: (context)=>state is! ShopLoadingGetFavoriteState,
            widgetBuilder: (context) =>ShopCubit.get(context).favoritesModel!.data!.data.length == 0
                ? const Center(child:Text('You don\'t have item',),)
                : ListView.separated(
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) =>
                  buildFavItem(ShopCubit.get(context).favoritesModel!.data!.data[index].products,context),
              separatorBuilder: (context, index) => myDivider(),
                  itemCount: ShopCubit.get(context).favoritesModel!.data!.data.length,
              ),
              fallbackBuilder:(context)=>const Center(child: CircularProgressIndicator()),
          );
        },
      ),
    );

  }


}
