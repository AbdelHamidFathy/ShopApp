import 'dart:ui';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_view_dot_indicator/page_view_dot_indicator.dart';
import 'package:shop_app/models/home_model.dart';
import 'package:shop_app/modules/full_screen_image_screen.dart';
import 'package:shop_app/modules/product_description_screen.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/cubit/cubit.dart';
import 'package:shop_app/shared/cubit/states.dart';
import 'package:shop_app/shared/styles/colors.dart';

class ProductDetails extends StatefulWidget {
  HomeModel data;
  int index;

  ProductDetails(
    this.data,
    this.index,
    );

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  int currentIndex=0;

  @override
  Widget build(BuildContext context) {
    List<String>images=widget.data.data.products[widget.index].images;
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state){
        if (state is SuccessADCartState) {
          toast(
            msg: AppCubit.get(context).cartMsg, 
            state: ToastStates.SUCCESS,
          );
        }
      },
      builder: (context, State)=> Scaffold(
        appBar: AppBar(
          leading: back(context),
          title: Text(
            'Details',
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(5.0),
                color: Colors.white,
                child: Text(
                  '${widget.data.data.products[widget.index].name}',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 3,
                ),
              ),
              SizedBox(
                height: 5.0,
              ),
              CarouselSlider(
                items: images
                  .map((e) 
                    => GestureDetector(
                      child: Hero(
                        tag: 'imageHero',
                        child: Image(
                        image: NetworkImage('${e}'), 
                        width: double.infinity,
                        fit: BoxFit.cover,
                        ),
                      ),
                      onTap: (){
                        navigateTo(context: context, Widget: FullScreenImage(e));
                    },
                    ),
                ).toList(),
                options: CarouselOptions(
                  enableInfiniteScroll: false,
                  height: 290,
                  viewportFraction: 1,
                  onPageChanged: (index, reason){
                    setState(() {
                      currentIndex=index;
                    });
                  }
                ),
              ),
              SizedBox(
                height: 5.0,
              ),
              PageViewDotIndicator(
                currentItem: currentIndex, 
                count: widget.data.data.products[widget.index].images.length, 
                unselectedColor: Colors.white, 
                selectedColor: defaultColor,
              ),
              SizedBox(
                height: 5.0,
              ),
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(5.0),
                color: Colors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Price : EGP${widget.data.data.products[widget.index].price}',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    if(widget.data.data.products[widget.index].discount!=0)
                    SizedBox(
                      height: 5.0,
                    ),
                    if(widget.data.data.products[widget.index].discount!=0)
                    Text(
                      'List price : EGP${widget.data.data.products[widget.index].oldPrice}',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                        decoration: TextDecoration.lineThrough,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 5.0,
              ),
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(5.0),
                color: Colors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InkWell(
                      onTap: (){
                        navigateTo(
                          context: context, 
                          Widget: ProductDescription(widget.data.data.products[widget.index].description)
                        );
                      },
                      child: Row(
                        children: [
                          Text(
                            'Description',
                            style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold, 
                            ),
                          ),
                          Spacer(),
                          Icon(
                            Icons.arrow_forward_ios_outlined,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                    Container(
                      width: double.infinity,
                      height: 0.5,
                      color: Colors.grey,
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                    Text(
                      '${widget.data.data.products[widget.index].description}',
                      maxLines: 6,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              Spacer(),
              defaultButton(
                text: 'add to cart', 
                onPressed: (){
                  AppCubit.get(context).adCart(id: widget.data.data.products[widget.index].id);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}