import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/fqa_model.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/cubit/cubit.dart';
import 'package:shop_app/shared/cubit/states.dart';

class FQAsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state){},
      builder:(context, state)=> Scaffold(
        appBar: AppBar(
          leading: back(context),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: ListView.separated(
            itemBuilder: (context, index)=>fQAItem(AppCubit.get(context).fqaModel, index), 
            separatorBuilder: (context, index)=>SizedBox(height: 5.0,), 
            itemCount: AppCubit.get(context).fqaModel.data.data.length,
          ),
        ),
      ),
    );
  }
  Widget fQAItem(FQAsModel model, index){
    return 
    Container(
      padding: EdgeInsets.all(7.5),
      width: double.infinity,
      height: 75.0,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${model.data.data[index].question}',
            style: TextStyle(
              fontSize: 14.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 5.0,
          ),
          Text(
            '${model.data.data[index].answer}',
            style: TextStyle(
              fontSize: 14.0,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}