import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/contacts_model.dart';
import 'package:shop_app/modules/account_screen.dart';
import 'package:shop_app/modules/fqa_screen.dart';
import 'package:shop_app/modules/notifications_screen.dart';
import 'package:shop_app/modules/web_view_screen.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/cubit/cubit.dart';
import 'package:shop_app/shared/cubit/states.dart';
import 'package:shop_app/shared/styles/colors.dart';

class ProfileScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state){},
      builder: (context, state){
        return 
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Column(
              children: 
              [
                CircleAvatar(
                  radius: 50.0,
                  backgroundImage: NetworkImage('${AppCubit.get(context).proModel.data.image}'),
                  child: AppCubit.get(context).proModel.data.image==null ? 
                  Text('${AppCubit.get(context).proModel.data.name[01]}'):
                  null,
                ),
                SizedBox(
                  height: 25.0,
                ),
                itemBuilder(
                  title: 'My Account', 
                  icon: Icons.person_outlined,
                  onTap: (){
                    navigateTo(context: context, Widget:AccountScreen());
                  }
                ),
                divider(),
                itemBuilder(
                  title: 'Notifications', 
                  icon: Icons.notifications_outlined,
                  onTap: (){
                    navigateTo(
                      context: context, 
                      Widget: NotificationsScreen(),
                    );
                  },
                ),
                divider(),
                itemBuilder(
                  title: 'FQAs', 
                  icon: Icons.help_outline_outlined,
                  onTap: (){navigateTo(context: context, Widget: FQAsScreen());}
                ),
                divider(),
                itemBuilder(
                  title: 'Log Out', 
                  icon: Icons.logout_outlined,
                  onTap: (){
                    AppCubit.get(context).signOut(context);
                  },
                ),
                divider(),
                Stack(
                  children: [
                    Container(
                      height: 50.0,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: defaultColor,
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                    ),
                    Container(
                      height: 50.0,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index)=>contactItem(AppCubit.get(context).contactsModel,index,context), 
                        separatorBuilder: (context, index)=>SizedBox(width: 5.0,), 
                        itemCount: AppCubit.get(context).contactsModel.data.data.length,
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
  Widget itemBuilder({
    required String title,
    required IconData icon,
    Function()?  onTap,
  }){
    return
     InkWell(
       onTap: onTap,
       child: Container(
        height: 75.0,
        width: double.infinity,
        padding: EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: defaultColor,
            ),
            SizedBox(
              width: 5.0,
            ),
            Text(
              '${title}',
            ),
            Spacer(),
            Icon(
              Icons.arrow_forward_ios,
            ),
          ],
        ),
         ),
     ); 
  }
  Widget divider(){
    return 
    SizedBox(
      height: 10.0,
    );
  }
  Widget contactItem(ContactsModel model,index,context){
    return 
    IconButton(
      icon: Image(
        image: NetworkImage(
          '${model.data.data[index].image}',
        ),
      ),
      onPressed: (){
        navigateTo(
          context: context, 
          Widget: WebViewScreen(model.data.data[index].value),
        );
      },
    );
  }
}