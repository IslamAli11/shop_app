import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/cubit/cubit.dart';
import 'package:shop_app/layout/cubit/states.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:shop_app/models/categories_model.dart';
import 'package:shop_app/models/home_model.dart';
import 'package:shop_app/modules/product_description/product_description_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return ConditionalBuilder(
          condition: ShopCubit.get(context).homeModel != null &&
              ShopCubit.get(context).categoriesModel != null,
          builder: (context) => productBuilder(
              ShopCubit.get(context).homeModel!,
              ShopCubit.get(context).categoriesModel!,
              context),
          fallback: (context) =>
              const Center(child: CircularProgressIndicator()),
        );
      },
    );
  }

  Widget productBuilder(
          HomeModel model, CategoriesModel categoriesModel, context) =>
      SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CarouselSlider(
              items: model.data!.banners
                  .map(
                    (e) => Image(
                      image: NetworkImage(e.image!),
                      width: double.infinity,
                      //fit: BoxFit.cover,
                    ),
                  )
                  .toList(),
              options: CarouselOptions(
                initialPage: 0,
                height: 250,
                enableInfiniteScroll: true,
                autoPlay: true,
                reverse: false,
                scrollDirection: Axis.horizontal,
                autoPlayAnimationDuration: const Duration(
                  seconds: 1,
                ),
                autoPlayInterval: const Duration(
                  seconds: 3,
                ),
                autoPlayCurve: Curves.fastOutSlowIn,
                viewportFraction: 1.0,
              ),
            ),
            const SizedBox(
              height: 5.0,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              child: Text(
                'Categories',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25.0,
                ),
              ),
            ),
            const SizedBox(
              height: 15.0,
            ),
            Container(
              height: 100.0,
              child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) => buildCategoriesItem(
                      categoriesModel.data!.data[index], context),
                  separatorBuilder: (context, index) => const SizedBox(
                        width: 5.0,
                      ),
                  itemCount: categoriesModel.data!.data.length),
            ),
            const SizedBox(
              height: 15.0,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              child: Text(
                'Products',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25.0,
                ),
              ),
            ),
            const SizedBox(
              height: 10.0,
            ),
            Container(
              color: Colors.grey[300],
              child: GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                childAspectRatio: 1 / 1.7,
                crossAxisSpacing: 1.0,
                mainAxisSpacing: 1.0,
                children: List.generate(
                    model.data!.products.length,
                    (index) =>
                        buildProductItem(model.data!.products[index], context)),
              ),
            ),
          ],
        ),
      );

  Widget buildCategoriesItem(model, context) => Padding(
        padding: const EdgeInsets.only(left: 10.0),
        child: Stack(
          alignment: AlignmentDirectional.bottomCenter,
          children: [
            Image(
              height: 100.0,
              width: 100.0,
              fit: BoxFit.cover,
              image: NetworkImage(model.image!),
            ),
            Container(
                width: 100.0,
                color: Colors.black.withOpacity(.8),
                child: Text(
                  model.name!,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                )),
          ],
        ),
      );

  Widget buildProductItem(ProductModel model, context) =>
      BlocConsumer<ShopCubit, ShopStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return InkWell(
            onTap: () {
              ShopCubit.get(context).productsDescription();
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => DescriptionScreen(
                          productModel: model,
                        )),
              );
            },
            child: Container(
              padding: const EdgeInsets.all(10.0),
              color: Colors.white,
              child: Stack(
                alignment: AlignmentDirectional.topEnd,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image(
                        image: NetworkImage(model.image!),
                        width: double.infinity,
                        height: 200,
                      ),
                      Text(
                        model.name!,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                      Row(
                        children: [
                          Text(
                            '${model.price}',
                            style: const TextStyle(color: Colors.blue),
                          ),
                          const SizedBox(
                            width: 5.0,
                          ),
                          if (model.discount != 0)
                            Text(
                              '${model.oldPrice}',
                              style: const TextStyle(
                                color: Colors.grey,
                                decoration: TextDecoration.lineThrough,
                              ),
                            ),
                          const Spacer(),
                          IconButton(
                              onPressed: () {
                                ShopCubit.get(context)
                                    .changeFavorites(model.id!);
                                print(model.id);
                              },
                              icon: CircleAvatar(
                                  backgroundColor: ShopCubit.get(context)
                                          .favorites[model.id]!
                                      ? Colors.red
                                      : Colors.grey[350],
                                  child: const Icon(
                                    Icons.favorite_border_rounded,
                                    size: 18.0,
                                    color: Colors.white,
                                  )))
                        ],
                      ),
                    ],
                  ),
                  if (model.discount != 0)
                    Container(
                      color: Colors.red,
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: const Text(
                        'DISCOUNT',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          );
        },
      );
}
