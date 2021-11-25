import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/categories_model.dart';
import 'package:shop_app/shared/cubit/cubit.dart';
import 'package:shop_app/shared/cubit/states.dart';
import 'package:shop_app/shared/styles/colors.dart';

class CategoriesScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state){},
      builder: (context, state){
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0,horizontal: 5.0),
          child: ConditionalBuilder(
            condition: AppCubit.get(context).catModel!=null, 
            builder: (context)=>categoriesBuilder(AppCubit.get(context).catModel), 
            fallback: (context)=>Center(child: CircularProgressIndicator(color: defaultColor,),),
          ),
        );
      },
    );
  }
  Widget categoriesBuilder(CategoriesModel model){
    return 
    GridView.count(
      crossAxisCount: 2,
      children: List.generate(
        model.data.data.length, 
        (index) => catItemBuilder(model, index),
      ),
    );
  }
  Widget catItemBuilder(CategoriesModel model,index){
    return
    Padding(
      padding: const EdgeInsets.all(5.0),
      child: Container(
        height: 150.0,
        width: 130.0,
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30.0),
        ),
        child: Column(
          children: [
            Image(
              height: 130.0,
              width: double.infinity,
              image: NetworkImage('${model.data.data[index].image}'),
            ),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Text(
                '${model.data.data[index].name}',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 14.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}