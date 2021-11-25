import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/cubit/cubit.dart';
import 'package:shop_app/shared/cubit/states.dart';
import 'package:shop_app/shared/styles/colors.dart';

class AccountScreen extends StatelessWidget {
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();
  var passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  var passKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state){
        if (state is SuccessUpdateProfileState) {
          if (AppCubit.get(context).updateStatus) {
            toast(
              msg: AppCubit.get(context).updateMsg, 
              state: ToastStates.SUCCESS,
            );
          }else{
            toast(
              msg: AppCubit.get(context).updateMsg, 
              state: ToastStates.ERROR,
            );
          }
        }
      },
      builder: (context, state){
        nameController.text=AppCubit.get(context).proModel.data.name;
        emailController.text=AppCubit.get(context).proModel.data.email;
        phoneController.text=AppCubit.get(context).proModel.data.phone;
        return ConditionalBuilder(
          condition: AppCubit.get(context).proModel!=null,
          builder:(context)=> Scaffold(
            appBar: AppBar(
              leading: back(context),
              backgroundColor: defaultColor,
              title: Text(
                'Prolfile',
              ),
            ),
            body: Column(
              children: [
                if(state is LoadingUpdateProfileState)
                LinearProgressIndicator(
                  color: defaultColor,
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Form(
                        key: formKey,
                        child: Column(
                          children: [
                            CircleAvatar(
                              radius: 50.0,
                              backgroundImage: NetworkImage(
                                '${AppCubit.get(context).proModel.data.image}',
                              ),
                            ),
                            SizedBox(
                              height: 40.0,
                            ),
                            defaultTextForm(
                              context: context, 
                              keyboardType: TextInputType.name, 
                              preIcon: Icons.person_outline,  
                              controller: nameController,
                              label: 'Name', 
                              validate: (value){
                                if (value!.isEmpty) {
                                  return 'Name can\'t be empty';
                                }return null;
                              },
                            ),
                            SizedBox(
                              height: 20.0,
                            ),
                            defaultTextForm(
                              context: context, 
                              keyboardType: TextInputType.emailAddress, 
                              preIcon: Icons.email_outlined,  
                              controller: emailController,
                              label: 'Email address', 
                              validate: (value){
                                if (value!.isEmpty) {
                                  return 'Email address can\'t be empty';
                                }return null;
                              },
                            ),
                            SizedBox(
                              height: 20.0,
                            ),
                            defaultTextForm(
                              context: context, 
                              keyboardType: TextInputType.phone, 
                              preIcon: Icons.phone_outlined,  
                              controller: phoneController,
                              label: 'Phone Number', 
                              validate: (value){
                                if (value!.isEmpty) {
                                  return 'Phone number can\'t be empty';
                                }return null;
                              },
                            ),
                            /* Spacer(), */
                            SizedBox(
                              height: 40.0,
                            ),
                            defaultButton(
                              text: 'update your information', 
                              onPressed: (){
                                if(formKey.currentState!.validate()) {
                                  showDialog(
                                  context: context, 
                                  builder: (context){
                                    return AlertDialog(
                                      title: Text(
                                        'Plaese enter your password'
                                      ),
                                      content: Container(
                                        color: Colors.white,
                                        height: 150.0,
                                        width: double.infinity,
                                        child: Form(
                                          key: passKey,
                                          child: Column(
                                            children: [
                                              defaultTextForm(
                                                onSubmitted: (value){
                                                  if (passKey.currentState!.validate()) {
                                                    AppCubit.get(context).updateProfile(
                                                      name: nameController.text, 
                                                      email: emailController.text, 
                                                      phone: phoneController.text, 
                                                      password: passwordController.text,
                                                    );
                                                    passwordController.clear();
                                                    Navigator.pop(context);
                                                  }
                                                },
                                                isPassword: true,
                                                context: context, 
                                                keyboardType: TextInputType.visiblePassword, 
                                                preIcon: Icons.password_outlined, 
                                                controller: passwordController, 
                                                validate: (value){
                                                  if (value!.isEmpty) {
                                                    return 'Please enter your password';
                                                  }return null;
                                                },
                                              ),
                                              Spacer(),
                                              defaultButton(
                                                text: 'confirm', 
                                                onPressed: (){
                                                  if (passKey.currentState!.validate()) {
                                                    AppCubit.get(context).updateProfile(
                                                      name: nameController.text, 
                                                      email: emailController.text, 
                                                      phone: phoneController.text, 
                                                      password: passwordController.text,
                                                    );
                                                    passwordController.clear();
                                                    Navigator.pop(context);
                                                  }
                                                },
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                );
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          fallback: (context)=>Center(child: CircularProgressIndicator(color: defaultColor,),),
        );
      },
    );
  }
}