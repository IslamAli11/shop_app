
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/cubit/cubit.dart';
import 'package:shop_app/layout/shop_layout.dart';
import 'package:shop_app/modules/login_screen/login_screen.dart';
import 'package:shop_app/modules/onboarding_screen/onboarding_screen.dart';
import 'package:shop_app/shared/bloc_observer.dart';
import 'package:shop_app/shared/network/endpiont.dart';
import 'package:shop_app/shared/network/remote/cach_helper.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';
import 'package:shop_app/shared/theme_data/app_them.dart';




void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.init();
  await CacheHelper.init();
 Widget? widget;
 bool? onBoarding = CacheHelper.getData(key: 'onBoarding');
 token = CacheHelper.getData(key: 'token');
 print(onBoarding);
  if (onBoarding !=null) {
    if (token !=null) {
      widget = const ShopLayout();
    } else {
      widget = LoginScreen();
    }
  } else {
    widget = const BoardingScreen();
  }
  BlocOverrides.runZoned(
        () {
          runApp(MyApp(
           widget: widget,

          ));

        },
    blocObserver: MyBlocObserver(),
  );

}

class MyApp extends StatelessWidget {
    final Widget? widget;
    const MyApp({Key? key,required this.widget  }) : super(key: key);



  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return  MultiBlocProvider(
      providers: [
        BlocProvider(create:(context)=>ShopCubit()
          ..getHomeData()..getCategoriesData()..getFavoritesData()..getUserProfile()
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: lightTheme,



        home:widget ,
      ),
    );
  }
}




