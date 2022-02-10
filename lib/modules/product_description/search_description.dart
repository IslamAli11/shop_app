 import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/models/search_model.dart';

class SearchDescriptionScreen extends StatelessWidget {
  late ProductDataModel productDataModel;
   SearchDescriptionScreen({Key? key , required this.productDataModel}) : super(key: key);

   @override
   Widget build(BuildContext context) {
     return Scaffold(
       appBar: AppBar(),
       body:  SingleChildScrollView(
         child: Padding(
           padding: const EdgeInsets.all(20.0),
           child: Column(
             crossAxisAlignment: CrossAxisAlignment.start,
             children:  [
               Stack(
                 alignment: AlignmentDirectional.bottomStart,
                 children: [
                   Container(
                     width: double.infinity,
                     height: 200,
                     child: Image(
                       width: 200,
                       height: 200,
                       image:NetworkImage( productDataModel.image!),

                     ),
                   ),
                   // if (productDataModel.discount != 0)
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
                 height: 10.0,
               ),
               Row(
                 crossAxisAlignment: CrossAxisAlignment.start,
                 children: [
                   Text(
                     'Price : ${productDataModel.price.toString()}',
                     style: const TextStyle(
                       fontWeight: FontWeight.bold,
                       fontSize: 20.0,
                     ),
                   ),


                 ],
               ),
               const SizedBox(
                 height: 15.0,
               ),
               Text(
                 productDataModel.description!,

                 style: const TextStyle(
                     fontSize: 20.0
                 ),
               ),
             ],
           ),
         ),
       ),
     );
   }
 }
