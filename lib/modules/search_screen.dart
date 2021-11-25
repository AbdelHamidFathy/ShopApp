import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/search_model.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/cubit/cubit.dart';
import 'package:shop_app/shared/cubit/states.dart';
import 'package:shop_app/shared/styles/colors.dart';

class SearchScreen extends StatelessWidget {
  var searchController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (contxet, state){},
      builder: (contxet, state){
        return Scaffold(
          appBar: AppBar(
            leading: back(context),
            title: Text(
              'Search',
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Form(
              key: formKey,
              child: Column(
                children: 
                [
                  defaultTextForm(
                    hint: 'Type a product you want',
                    context: context, 
                    keyboardType: TextInputType.text, 
                    preIcon: Icons.search_outlined, 
                    controller: searchController, 
                    validate: (value){
                      if (value!.isEmpty){
                        return '';
                      }return null;
                    },
                    onChanged: (value){
                      AppCubit.get(context).productSearch(text: value);
                    }
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  if(state is LoadingSearchState)
                  LinearProgressIndicator(color: defaultColor,),
                  SizedBox(
                    height: 10.0,
                  ),
                  if(state is SuccessSearchState && formKey.currentState!.validate())
                  Expanded(child: searchBuilder(AppCubit.get(context).searchModel)),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
  Widget searchBuilder(SearchModel model){
    return
    ListView.separated(
      itemBuilder: (context, index)=>searchItemBuilder(model, index,context), 
      separatorBuilder: (context, index)=>SizedBox(height: 10.0,), 
      itemCount: model.data.data.length,
    );
  }
  Widget searchItemBuilder(SearchModel model,index,context,){
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
            image: NetworkImage('${model.data.data[index].image}'),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${model.data.data[index].name}',
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
                      'EGP ${model.data.data[index].price}',
                    ),
                    Spacer(),
                    IconButton(
                      onPressed: (){
                        AppCubit.get(context).changeFavorite(id: model.data.data[index].id);
                      }, 
                      icon: AppCubit.get(context).favorites[model.data.data[index].id]!?
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