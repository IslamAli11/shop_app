import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/cubit/cubit.dart';
import 'package:shop_app/layout/cubit/states.dart';
import 'package:shop_app/models/categories_model.dart';
import 'package:shop_app/shared/component/component.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocConsumer<ShopCubit, ShopStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return ListView.separated(
              itemBuilder: (context, index) => buildCatItem(
                  ShopCubit.get(context).categoriesModel!.data!.data[index]),
              separatorBuilder: (context, index) => myDivider(),
              itemCount:
                  ShopCubit.get(context).categoriesModel!.data!.data.length);
        },
      ),
    );
  }

  Widget buildCatItem(Data data) => Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            Image(
              image: NetworkImage(data.image!),
              width: 100.0,
              height: 100.0,
              fit: BoxFit.cover,
            ),
            const SizedBox(
              width: 20.0,
            ),
            Expanded(
              child: Text(
                data.name!,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                ),
              ),
            ),
            const Spacer(),
            const Icon(Icons.arrow_forward_ios),
          ],
        ),
      );
}
