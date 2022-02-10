import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/cubit/cubit.dart';
import 'package:shop_app/layout/cubit/states.dart';
import 'package:shop_app/modules/product_description/favorites_description.dart';
import 'package:shop_app/modules/product_description/product_description_screen.dart';

Widget defaultTextFormField({
  required TextEditingController controller,
  required String label,
  required String? Function(String?)? validate,
  String? Function(String?)? onTap,
  required TextInputType keyboardType,
  bool obscureText = false,
  required IconData prefix,
  IconData? suffix,
  Function? onPressIcon,
}) =>
    TextFormField(
      decoration: InputDecoration(
        prefixIcon: Icon(prefix),
        suffixIcon: IconButton(
          icon: Icon(suffix),
          onPressed: () {
            onPressIcon!();
          },
        ),
        labelText: label,
        border: const OutlineInputBorder(),
      ),
      controller: controller,
      validator: validate,
      onFieldSubmitted: onTap,
      keyboardType: keyboardType,
      obscureText: obscureText,
    );

Widget defaultMaterialButton({
  required Function onPress,
  Color? color,
  String? text,
  double radius = 10.0,
}) =>
    Container(
      height: 40.0,
      width: double.infinity,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(radius),
      ),
      child: MaterialButton(
        onPressed: () => onPress(),
        child: Text(
          text!,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20.0,
          ),
        ),
      ),
    );

Widget myDivider() => Padding(
      padding: const EdgeInsets.only(left: 15.0),
      child: Container(
        width: double.infinity,
        height: 1.0,
        color: Colors.grey[300],
      ),
    );

Widget buildFavItem(model, context) => BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return InkWell(
          onTap: () {
            ShopCubit.get(context).favoritesDescription();
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => FavoritesDescriptionScreen(
                          productsModel: model,
                        )));
          },
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Container(
              height: 120.0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Stack(
                    alignment: AlignmentDirectional.bottomStart,
                    children: [
                      Image(
                          width: 120.0,
                          height: 120.0,
                          image: NetworkImage(model.image!)),
                      if (model.discount != 0)
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 5.0),
                          color: Colors.red,
                          child: const Text(
                            'DISCOUNT',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(
                    width: 10.0,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          model.name!,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const Spacer(),
                        Row(
                          children: [
                            Text(
                              model.price!.toString(),
                            ),

                            const SizedBox(
                              width: 5.0,
                            ),

                            // Text(

                            //   model.oldPrice.toString(),

                            //   style: const TextStyle(

                            //       color: Colors.grey,

                            //       decoration: TextDecoration.lineThrough

                            //   ),

                            // ),

                            const Spacer(),

                            IconButton(
                              onPressed: () {
                                ShopCubit.get(context)
                                    .changeFavorites(model.id);
                              },
                              icon: ShopCubit.get(context).favorites[model.id]!
                                  ? const CircleAvatar(
                                      backgroundColor: Colors.red,
                                      child: Icon(
                                        Icons.favorite_border_rounded,
                                        color: Colors.white,
                                        size: 16.0,
                                      ),
                                    )
                                  : const CircleAvatar(
                                      backgroundColor: Colors.grey,
                                      child: Icon(
                                        Icons.favorite_border_rounded,
                                        color: Colors.white,
                                        size: 16.0,
                                      ),
                                    ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
