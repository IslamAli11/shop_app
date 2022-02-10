import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/cubit/cubit.dart';
import 'package:shop_app/layout/cubit/states.dart';
import 'package:shop_app/models/home_model.dart';


class DescriptionScreen extends StatelessWidget {
 late ProductModel? productModel;


    DescriptionScreen({Key? key,required this.productModel }) : super(key: key);

  @override
  Widget build(BuildContext context , ) {
    return BlocConsumer<ShopCubit , ShopStates>(
      listener: (context, state){},
      builder: (context, state){

        return Scaffold(
          appBar: AppBar(),
          body:  SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children:  [
                  Container(
                    width: 200,
                    height: 200,
                    child: Image(
                      width: 200,
                      height: 200,
                      image:NetworkImage(productModel!.image!),

                    ),
                  ),
                  const SizedBox(
                    height: 15.0,
                  ),
                  Text(
                      productModel!.description!,

                    style: const TextStyle(
                      fontSize: 20.0
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },

    );
  }
}
