import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_view_dot_indicator/page_view_dot_indicator.dart';
import 'package:shop_app/models/categories_model.dart';
import 'package:shop_app/models/home_model.dart';
import 'package:shop_app/modules/product_details_screen.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/cubit/cubit.dart';
import 'package:shop_app/shared/cubit/states.dart';
import 'package:shop_app/shared/styles/colors.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int postion=0;
  bool inFavorite=false;
  @override
  void initState() {
    super.initState();
    if(AppCubit.get(context).homeModel==null)
    AppCubit.get(context).getHomeData();

  }
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
        return ConditionalBuilder(
          condition: AppCubit.get(context).homeModel!=null && AppCubit.get(context).catModel!=null,
          builder: (context)=>homeBuilder(AppCubit.get(context).homeModel,), 
          fallback: (context)=>Center(child: CircularProgressIndicator(color: defaultColor,),),
        );
      },
    );
  }

  Widget homeBuilder(HomeModel model,){
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          caroulBuilder(model),
          SizedBox(
            height: 5.0,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5.0),
            child: Text(
              'Shop by category',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
          SizedBox(
            height: 5.0,
          ),
          categoriesBuilder(AppCubit.get(context).catModel),
          SizedBox(
            height: 5.0,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5.0),
            child: Text(
              'Popular products',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
          SizedBox(
            height: 5.0,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5.0),
            child: GridView.count(
              mainAxisSpacing: 5.0,
              crossAxisSpacing: 5.0,
              childAspectRatio: 0.77,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              children: List.generate(
                model.data.products.length, 
                (index) {
                  return productsBuilder(model, index);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
  Widget productsBuilder(HomeModel model, index){
    return
    Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.0),
        color: Colors.white,
      ),
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: 
          [
            InkWell(
              onTap: (){
                navigateTo(context: context, Widget: ProductDetails(model, index));
              },
              child: Stack(
                children: [
                  Image(
                    height: 150,
                    width: 150,
                    image: NetworkImage('${model.data.products[index].image}'),
                  ),
                  if(model.data.products[index].discount!=0)
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 5,horizontal: 5),
                    decoration: BoxDecoration(
                      color: Colors.red.withOpacity(0.8),
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    child: Text(
                      '-${model.data.products[index].discount}%',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
            Text(
              '${model.data.products[index].name}',
              maxLines: 1,
              style: TextStyle(
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'EGP ${model.data.products[index].price}',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    if(model.data.products[index].discount!=0)
                    Text(
                      'EGP ${model.data.products[index].oldPrice}',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 12.0,
                        decoration: TextDecoration.lineThrough,
                      ),
                    ),
                  ],
                ),
                Spacer(),
                IconButton(
                  onPressed: (){
                    setState(() {
                      AppCubit.get(context).changeFavorite(id: model.data.products[index].id);                      
                    });          
                  }, 
                  icon: AppCubit.get(context).favorites[model.data.products[index].id]!?
                  Icon(Icons.favorite, color: Colors.red,):
                  Icon(Icons.favorite_border_outlined, color: Colors.black,),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
  Widget caroulBuilder(HomeModel model){
    return
    Container(
      color: Colors.white,
      height: 200,
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.only(top:6.0),
        child: Column(
          children: 
          [
            CarouselSlider(
              items: model.data.banners
                .map((e) 
                  => Padding(
                    padding: const EdgeInsets.only(left: 6.0,bottom: 4.0,),
                    child: Container(
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      child: Image(
                        image: NetworkImage('${e.image}'), 
                        width: double.infinity,
                        fit: BoxFit.cover,
                        ),
                    ),
                  ),
              ).toList(),
              options: CarouselOptions(
                height: 175.0,
                autoPlay: true,
                viewportFraction: 0.9,
                onPageChanged: (index, reason){
                  setState(() {
                    postion=index;
                  });
                }
              ),
            ),
            PageViewDotIndicator(
              size: Size(30, 10),
              margin: const EdgeInsets.symmetric(horizontal: 0),
              currentItem: postion, 
              count: model.data.banners.length, 
              unselectedColor: Colors.grey.shade300, 
              selectedColor: defaultColor,
            ),
          ],
        ),
      ),
    );
  }
  Widget categoriesBuilder(CategoriesModel model){
    return 
    Container(
      height: 131.0,
      width: double.infinity,
      color: Colors.white,
      child: ListView.separated(
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index)=>catItem(model, index), 
        separatorBuilder: (context, index)=>SizedBox(width: 5.0,), 
        itemCount: model.data.data.length,
      ),
    );
  }
  Widget catItem(CategoriesModel model, index){
    return
    Padding(
      padding: const EdgeInsets.all(5.0,),
      child: Column(
        children: 
        [
          Container(
            /* decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [BoxShadow(blurRadius: 11, color: Colors.red, spreadRadius: 5)],
            ), */
            child: CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage('${model.data.data[index].image}'),
            ),
          ),
          SizedBox(
            height: 5.0,
          ),
          Text(
            '${model.data.data[index].name}',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}