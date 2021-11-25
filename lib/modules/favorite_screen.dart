import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/favorites_model.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/cubit/cubit.dart';
import 'package:shop_app/shared/cubit/states.dart';
import 'package:shop_app/shared/styles/colors.dart';

class FavoriteScreen extends StatelessWidget {    

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state){
        if (state is SuccessChangeFavoriteState) {
          toast(
            msg: state.model.message, 
            state: ToastStates.SUCCESS,
          );
        }else if (state is ErrorChangeFavoriteState) {
          toast(
            msg: 'Not Authorized', 
            state: ToastStates.ERROR,
          );
        }
      },
      builder: (context, state){
        return Padding(
          padding: const EdgeInsets.all(10.0),
          child: ConditionalBuilder(
            condition: AppCubit.get(context).adFavModel!=null, 
            builder: (context)=>favoriteBuilder(AppCubit.get(context).favModel), 
            fallback: (context)=>Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.favorite,
                  color: Colors.grey,
                  size: 100.0,
                ),
                SizedBox(
                  height: 5.0,
                ),
                Text(
                  'You have no items in favorites',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
  Widget favoriteBuilder(FavoritesModel model){
    return
    ListView.separated(
      itemBuilder: (context, index)=>favItemBuilder(model, index,context), 
      separatorBuilder: (context, index)=>SizedBox(height: 10.0,), 
      itemCount: model.data.data.length,
    );
  }
  Widget favItemBuilder(FavoritesModel model,index,context,){
    return
    Container(
      padding: EdgeInsets.all(10.0),
      height: 106.0,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30.0),
      ),
      clipBehavior: Clip.antiAlias,
      child: Row(
        children: [
          Image(
            height: 100.0,
            width: 100.0,
            image: NetworkImage('${model.data.data[index].product.image}'),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${model.data.data[index].product.name}',
                  style:  TextStyle(
                    color: Colors.black,
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                Spacer(),
                Row(
                  children: [
                    Text(
                      'EGP ${model.data.data[index].product.price}',
                    ),
                    Spacer(),
                    IconButton(
                  onPressed: (){
                      AppCubit.get(context).changeFavorite(id: model.data.data[index].product.id);
                  }, 
                  icon: AppCubit.get(context).favorites[model.data.data[index].product.id]!?
                  Icon(Icons.favorite, color: Colors.red,):
                  Icon(Icons.favorite_border_outlined, color: Colors.black,),
                ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}