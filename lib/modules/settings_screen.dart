import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/network/local/cache_helper.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/cubit/cubit.dart';
import 'package:shop_app/shared/cubit/states.dart';
import 'package:shop_app/shared/styles/colors.dart';

import 'login_screen.dart';

class SettingsScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state){},
      builder: (context, state){
        return Scaffold(
          appBar: AppBar(
            leading: back(context),
            title: Text(
              'Settings',
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: 
              [
                Row(
                  children: 
                  [
                    Text(
                      'App Theme',
                    ),
                    Spacer(),
                    IconButton(
                      onPressed:(){
                        AppCubit.get(context).changeTheme();
                      }, 
                      icon: Icon(
                        Icons.palette_outlined,
                        color: defaultColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}