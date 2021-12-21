import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/cubit/cubit.dart';
import 'package:shop_app/shared/cubit/states.dart';

class RegisterScreen extends StatelessWidget {
  var nameController =TextEditingController();
  var emailController =TextEditingController();
  var phoneController =TextEditingController();
  var passwordController =TextEditingController();
  var formKey =GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state){
        if (state is RegisterSuccessState) {
          if (AppCubit.get(context).registerStatus) {
            toast(
              msg: AppCubit.get(context).registerMsg, 
              state: ToastStates.SUCCESS,
            );
            AppCubit.get(context).loginPostData(email: emailController.text, password: passwordController.text);
          }else {
            toast(
              msg: AppCubit.get(context).registerMsg, 
              state: ToastStates.ERROR,
            );
          }
        }
      },
      builder:(context, state)=> Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IconButton(
                  onPressed: (){
                    Navigator.pop(context);
                  }, 
                  icon: Icon(
                    Icons.arrow_back_ios,
                    color: Colors.grey,
                  ),
                  padding: EdgeInsets.only(left: 20.0),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: 
                      [
                        Text(
                          'REGISTER',
                          style: TextStyle(
                            fontSize: 24.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Text(
                          'Complete your details',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 16.0,
                          ),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Row(
                          children: [
                            underLine(
                              width: 120.0,
                            ),
                            SizedBox(
                              width: 5.0,
                            ),
                            underLine(
                              width: 30.0
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 30.0,
                        ),
                        defaultTextForm(
                          context: context,
                          keyboardType: TextInputType.name, 
                          preIcon: Icons.person_outline, 
                          hint: 'Name', 
                          controller: nameController, 
                          validate: (value){
                            if (value!.isEmpty) {
                              return 'Please enter your name';
                            }
                            return null;
                          }
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        defaultTextForm(
                          context: context,
                          keyboardType: TextInputType.emailAddress, 
                          preIcon: Icons.email_outlined, 
                          hint: 'Email', 
                          controller: emailController, 
                          validate: (value){
                            if (value!.isEmpty) {
                              return 'Please enter your email';
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        defaultTextForm(
                          context: context,
                          keyboardType: TextInputType.phone, 
                          preIcon: Icons.phone_android_outlined, 
                          hint: 'Phone', 
                          controller: phoneController, 
                          validate: (value){
                            if (value!.isEmpty) {
                              return 'Please enter your phone';
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        defaultTextForm(
                          context: context,
                          isPassword: true,
                          keyboardType: TextInputType.visiblePassword, 
                          preIcon: Icons.lock_outline, 
                          sufIcon: AppCubit.get(context).isPass ? Icons.visibility_outlined :
                          Icons.visibility_off_outlined,
                          suffixOnPressed: (){
                            AppCubit.get(context).showPass();
                          },
                          hint: 'Password', 
                          controller: passwordController, 
                          validate: (value){
                            if (value!.isEmpty) {
                              return 'Please enter your password';
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        defaultTextForm(
                          isPassword: true,
                          hint: 'Confirm password',
                          context: context, 
                          keyboardType: TextInputType.visiblePassword, 
                          preIcon: Icons.lock_outline, 
                          sufIcon: AppCubit.get(context).isPass ? Icons.visibility_outlined :
                          Icons.visibility_off_outlined,
                          suffixOnPressed: (){
                            AppCubit.get(context).showPass();
                          },
                          controller: passwordController, 
                          validate: (value){
                            if (value!.isEmpty) {
                              return 'Please enter your password';
                            }return null;
                          },
                        ),
                        SizedBox(
                          height: 25.0,
                        ),
                        defaultButton(
                          text: 'register', 
                          onPressed: (){
                            if (formKey.currentState!.validate()) {
                              AppCubit.get(context).register(
                                name: nameController.text, 
                                email: emailController.text, 
                                phone: phoneController.text, 
                                password: passwordController.text,
                              );
                            }
                          },
                        ),
                        
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}