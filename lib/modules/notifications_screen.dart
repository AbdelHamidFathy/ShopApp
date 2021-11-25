import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/notifications_model.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/cubit/cubit.dart';
import 'package:shop_app/shared/cubit/states.dart';
import 'package:shop_app/shared/styles/colors.dart';

class NotificationsScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state){},
      builder: (context, state){
        return Scaffold(
          appBar: AppBar(
            leading: back(context),
            title: Text(
              'Notifications',
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(10.0),
            child: ConditionalBuilder(
              condition: AppCubit.get(context).notModel!=null, 
              builder: (context)=>notificationsBuilder(AppCubit.get(context).notModel), 
              fallback: (context)=>Center(child: CircularProgressIndicator(color: defaultColor,),)
            ),
          ),
        );
      }, 
    );
  }
  Widget notificationsBuilder(NotificationsModel model){
    return
    ListView.separated(
      physics: BouncingScrollPhysics(),
      itemBuilder: (context, index)=>notItemBuilder(model,index), 
      separatorBuilder: (context, index)=>SizedBox(height: 5.0), 
      itemCount: model.notData.data.length,
    );
  }
  Widget notItemBuilder(NotificationsModel model, index){
    return
    Container(
      height: 80,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15.0)
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 5.0,bottom: 5.0,left: 10.0,right: 10.0,),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.notifications,
                  color: Colors.grey,
                  size: 18.0,
                ),
                SizedBox(
                  width: 5.0,
                ),
                Text(
                  '${model.notData.data[index].title}',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 12.0,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10.0,
            ),
            Text(
              '${model.notData.data[index].message}',
              style: TextStyle(
                color: Colors.black,
                fontSize: 14.0,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}