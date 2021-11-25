import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/modules/cart_screen.dart';
import 'package:shop_app/modules/search_screen.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/cubit/cubit.dart';
import 'package:shop_app/shared/cubit/states.dart';
import 'package:shop_app/shared/styles/colors.dart';

class HomeLayout extends StatefulWidget {
  @override
  State<HomeLayout> createState() => _HomeLayoutState();
}

class _HomeLayoutState extends State<HomeLayout> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state){},
      builder:(context, state){
        var cubit=AppCubit.get(context);
        return Scaffold(
        appBar: AppBar(
          title: searchField(),
          actions: [
            cartButton(),
          ],
        ),
        body: cubit.screens[cubit.currentIndex],
        bottomNavigationBar: bottomNavigationBar(),
      );
    });
  }
  Widget bottomNavigationBar() {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Container(
        height: 0.5,
        width: double.infinity,
        color: Colors.grey[300],
      ),
      BottomNavigationBar(
        type: BottomNavigationBarType.shifting,
        currentIndex: AppCubit.get(context).currentIndex,
        onTap: (index){
          AppCubit.get(context).changeBottomNavBarItem(index);
        },
        backgroundColor: Colors.white,
        items: [
          BottomNavigationBarItem(
            label: 'Home',
            icon: Icon(
              Icons.home_outlined,
            ),
          ),
          BottomNavigationBarItem(
            label: 'Categories',
            icon: Icon(
              Icons.list_alt_outlined,
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.favorite_border_outlined,
            ), 
            label: 'Favorites',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person_outlined,
            ),
            label: 'Profile',
          ),
        ],
        elevation: 0,
        unselectedItemColor: Colors.black,
        selectedItemColor: defaultColor,
      ),
    ],
  );
}
  Widget searchField(){
    return
    Container(
      height: 40.0,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.0),
        color: Colors.grey[200],
      ),
      child: TextFormField(
        onTap: (){
          navigateTo(context: context, Widget: SearchScreen());
        },
        showCursor: false,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(
            horizontal: 10.0,
            vertical: 5.0,
          ),
          border: InputBorder.none,
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          hintText: 'Search',
          prefixIcon: Icon(Icons.search,color: Colors.grey,),
        ),
      ),
    );
  }
  Widget cartButton(){
    return IconButton(
      onPressed: (){
        navigateTo(context: context, Widget: CartScreen());
      },
      icon: Icon(
        Icons.shopping_bag_outlined,
        color: Colors.grey,
      ),
    );
  }
}
