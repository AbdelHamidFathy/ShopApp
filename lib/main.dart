import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/home_layout.dart';
import 'package:shop_app/modules/login_screen.dart';
import 'package:shop_app/modules/splash_screen.dart';
import 'package:shop_app/network/local/cache_helper.dart';
import 'package:shop_app/network/remote/dio_helper.dart';
import 'package:shop_app/shared/bloc_observer.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shared/cubit/cubit.dart';
import 'package:shop_app/shared/cubit/states.dart';
import 'package:shop_app/shared/styles/themes.dart';
import 'modules/onboarding_screen.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.init();
  DioHelper.init();
  Bloc.observer = MyBlocObserver();
  bool? onboard=CacheHelper.getData(key: 'onBoarding');
  bool? isDark=CacheHelper.getData(key: 'isDark');
  token=CacheHelper.getData(key: 'token');
  print(token);
  Widget widget;
  if (onboard!=null) {
    if (token!=null) {
      widget= HomeLayout();
    }else widget= LoginScreen(); 
  }else widget= OnboardingScreen();
  runApp(MyApp(
    onboard: onboard,
    isDark: isDark,
    screen: widget,
  ));
}

class MyApp extends StatelessWidget {
  bool? onboard;
  bool? isDark;
  Widget screen;
  MyApp({
    required this.onboard,
    required this.isDark,
    required this.screen,
    });

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context)=>AppCubit()..getHomeData()..getCategoriesData()
      ..getNotificationsData()..getFavorites()..getContacts()
      ..getProfile()..getFQA()..getCart(),
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state){},
        builder: (context, state){
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            home: SplashScreen(screen),
            theme: lightTheme,
          );
        }, 
      ),
    );
  }
}
