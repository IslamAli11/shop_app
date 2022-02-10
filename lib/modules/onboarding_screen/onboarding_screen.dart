

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/modules/login_screen/login_screen.dart';
import 'package:shop_app/shared/network/remote/cach_helper.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
 class OnBoardingModel {
    String image;
   String title;
   String body;
  OnBoardingModel({
     required this.image,
    required this.title,
    required this.body,
});

}
 class BoardingScreen extends StatefulWidget {
   const BoardingScreen({Key? key}) : super(key: key);

  @override
  State<BoardingScreen> createState() => _BoardingScreenState();
}

class _BoardingScreenState extends State<BoardingScreen> {
  List<OnBoardingModel> boarding=[
    OnBoardingModel(
        image:'images/boarding2.png',
        title: 'Boarding title one',
        body:'Boarding body one'
    ),
    OnBoardingModel(
        image:'images/boarding2.png',
        title: 'Boarding title two',
        body:'Boarding body two'
    ),
    OnBoardingModel(
        image:'images/boarding2.png',
        title: 'Boarding title three',
        body:'Boarding title three'
    ),
  ];
  bool islast = false;

  var boardingController= PageController();

  Function?  onSubmit(){
    CacheHelper.saveData(key: 'onBoarding', value:true).then((value){

      if(value!=null){
        Navigator.pushAndRemoveUntil(
            context,MaterialPageRoute(
          builder: (context)=>LoginScreen(),
        ),
                (route) => false);
      }

    });


  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
       // elevation: 0.0,
       // backgroundColor: Colors.white,
        actions: [
          TextButton(

          onPressed: onSubmit,

            child:const Text('SKIP', style: TextStyle(
              fontSize: 20.0,
            ),
            ),),
        ],
      ),
      body:Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                onPageChanged: (int index){
                  if(index==boarding.length-1)
                    {
                      setState(() {
                        islast=true;
                      });

                    }else
                      {
                        setState(() {
                          islast=false;
                        });

                      }

                },
                controller: boardingController,
                itemBuilder: (context , index)=>buildBoardingItem(boarding[index]),
                itemCount:boarding.length,
              ),
            ),
            Row(
              children:  [
                SmoothPageIndicator(
                  controller: boardingController,
                  count:  boarding.length,
                  axisDirection: Axis.horizontal,
                  effect:  const SlideEffect(

                      spacing:  5.0,
                      radius:  9.0,
                      dotWidth:  30.0,
                      dotHeight:  16.0,
                      paintStyle:  PaintingStyle.stroke,
                      strokeWidth:  1.5,
                    //  dotColor:  Colors.white,
                      activeDotColor:  Colors.blue,

                  ),
                ),
                const Spacer(),
                FloatingActionButton(
                    onPressed: (){
                      if(islast){
                        onSubmit();

                      }else
                        {
                          boardingController.nextPage(
                              duration:const Duration(
                                milliseconds: 750,
                              ),
                              curve:Curves.fastLinearToSlowEaseIn
                          );
                        }


                    },
                  child: const Icon(
                    Icons.arrow_forward_ios,
                  ),

                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildBoardingItem(OnBoardingModel model)=>Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children:  [
      Expanded(
        child: Image(
          //fit: BoxFit.cover,
          image: AssetImage(model.image),

        ),
      ),
      Text(
        model.title,
        style: const TextStyle(
          fontSize: 24.0,
          fontWeight: FontWeight.bold,
        ),

      ),
      const SizedBox(
        height: 10.0,
      ),
      Text(
        model.body,
        style: const TextStyle(
          fontSize: 16.0,
        ),
      ),
    ],
  );
}
