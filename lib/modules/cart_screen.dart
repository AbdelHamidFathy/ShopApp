import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/cart_model.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/cubit/cubit.dart';
import 'package:shop_app/shared/cubit/states.dart';
import 'package:shop_app/shared/styles/colors.dart';

class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state){},
      builder:(context, state)=> Scaffold(
        appBar: AppBar(
          leading: back(context),
          title: Text('Cart'),
        ),
        body: ConditionalBuilder(
          condition: AppCubit.get(context).cartModel.data.total!=0,
          builder:(context)=> Column(
            children: [
              Container(
                width: double.infinity,
                color: Colors.white,
                padding: EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text('Total'),
                        Spacer(),
                        Text(
                          'EGP ${AppCubit.get(context).cartModel.data.total}',
                          style: TextStyle(
                            color: defaultColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    defaultButton(
                      text: 'complete your order', 
                      onPressed: (){},
                    ),
                  ],
                ),
              ), 
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: ListView.separated(
                    itemBuilder: (context, index)=>cartItemBuilder(AppCubit.get(context).cartModel, index, context), 
                    separatorBuilder: (context, state)=>SizedBox(height: 10.0,), 
                    itemCount: AppCubit.get(context).cartModel.data.cartItems.length,
                  ),
                ),
              ),
            ],
          ),
          fallback: (context)=>Center(child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.shopping_cart_rounded,
                color: Colors.grey,
                size: 100.0,
              ),
              SizedBox(
                height: 5.0,
              ),
              Text(
                'You have no items in the cart',
                style: TextStyle(
                  fontSize: 24.0,
                  color: Colors.grey,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
            ),
          ),
        ),
      ),
    );
  }
  Widget cartItemBuilder(CartModel model,index,context,){
    return
    Container(
      padding: EdgeInsets.all(10.0),
      height: 170.0,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30.0),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: [
          Row(
            children: [
              Image(
                height: 100.0,
                width: 100.0,
                image: NetworkImage('${model.data.cartItems[index].product.image}'),
              ),
              Expanded(
                child: Container(
                  height: 90.0,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${model.data.cartItems[index].product.name}',
                        style:  TextStyle(
                          color: Colors.black,
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Spacer(),
                      Text(
                        'EGP ${model.data.cartItems[index].product.price}',
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Container(
            color: Colors.grey,
            height: 0.5,
            width: double.infinity,
          ),
          Row(
            children: [
              IconButton(
                onPressed: (){
                  AppCubit.get(context).changeFavorite(id: model.data.cartItems[index].product.id);
                }, 
                icon: AppCubit.get(context).favorites[model.data.cartItems[index].product.id]!?
                Icon(Icons.favorite, color: Colors.red,):
                Icon(Icons.favorite_border_outlined, color: Colors.black,),
              ),
              Spacer(),
              MaterialButton(
                child: Row(
                  children: [
                    Icon(
                      Icons.delete,
                      color: defaultColor,
                    ),
                    Text(
                      'Remove',
                      style: TextStyle(
                        color: defaultColor,
                      ),
                    ),
                  ],
                ), 
                onPressed: (){
                  AppCubit.get(context).adCart(id: AppCubit.get(context).cartModel.data.cartItems[index].product.id);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}