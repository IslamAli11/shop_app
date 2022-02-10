import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/cubit/cubit.dart';
import 'package:shop_app/layout/cubit/states.dart';
import 'package:shop_app/models/search_model.dart';
import 'package:shop_app/models/search_model.dart';
import 'package:shop_app/modules/product_description/search_description.dart';
import 'package:shop_app/modules/search/cubit/cubit.dart';
import 'package:shop_app/modules/search/cubit/states.dart';
import 'package:shop_app/shared/component/component.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({Key? key}) : super(key: key);
  var textController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocProvider(
        create: (context) => SearchCubit(),
        child: BlocConsumer<SearchCubit, SearchStates>(
          listener: (context, state) {},
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    defaultTextFormField(
                      controller: textController,
                      label: ' Search',
                      validate: (String? value) {
                        if (value!.isEmpty) {
                          return 'Search must\'t be empty';
                        }
                      },
                      onTap: (String? text) {
                        SearchCubit.get(context).searchData(text);
                      },
                      keyboardType: TextInputType.text,
                      prefix: Icons.search_outlined,
                    ),
                    const SizedBox(
                      height: 15.0,
                    ),
                    if (state is LoadingSearchState)
                      const LinearProgressIndicator(),
                    if (state is SuccessSearchState)
                      Expanded(
                        child: ListView.separated(
                          physics: const BouncingScrollPhysics(),
                          itemBuilder: (context, index) => buildSearchFavItem(
                              SearchCubit.get(context).model!.data!.data[index],
                              context),
                          separatorBuilder: (context, index) => myDivider(),
                          itemCount:
                              SearchCubit.get(context).model!.data!.data.length,
                        ),
                      ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
  Widget buildSearchFavItem( model, context) => BlocConsumer<ShopCubit, ShopStates>(
    listener: (context, state) {},
    builder: (context, state) {
      return InkWell(
        onTap: () {
          ShopCubit.get(context).favoritesDescription();
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => SearchDescriptionScreen(productDataModel:model)));
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
                    // if (model.discount !=0)
                    //   Container(
                    //     padding: const EdgeInsets.symmetric(horizontal: 5.0),
                    //     color: Colors.red,
                    //     child: const Text(
                    //       'DISCOUNT',
                    //       style: TextStyle(
                    //         color: Colors.white,
                    //       ),
                    //     ),
                    //   ),
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
                                  .changeFavorites(model.id!);
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
}
