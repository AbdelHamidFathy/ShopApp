import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/home_layout.dart';
import 'package:shop_app/modules/register_screen.dart';
import 'package:shop_app/network/local/cache_helper.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shared/cubit/cubit.dart';
import 'package:shop_app/shared/cubit/states.dart';
import 'package:shop_app/shared/styles/colors.dart';

import 'forget_password_screen.dart';

class LoginScreen extends StatelessWidget {
  var formKey=GlobalKey<FormState>();
  var emailController =TextEditingController();
  var passwordController=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state){
        if (state is LoginSuccessState) {
          if (state.model.status) {
            CacheHelper.saveData(key: 'token', value: state.model.data.token).then((value) {
              if(value){
                token=state.model.data.token;
                AppCubit.get(context).getFavorites();
                AppCubit.get(context).getProfile();
                navigateAndFinish(context: context, Widget: HomeLayout());
              }
            });
          }
          else{
            toast(
              msg: state.model.messaage, 
              state: ToastStates.ERROR,
            );
          }
        }
      },
      builder: (context, state){
        return Scaffold(
          body: SafeArea(
            child: Center(
              child: SingleChildScrollView(
                child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children:
                [
                  Text(
                    'LOGIN',
                    style: TextStyle(
                      fontSize: 36.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Text(
                    'Login to your account',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 18.0,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      underLine(width: 140.0),
                      SizedBox(
                        width: 5.0,
                      ),
                      underLine(width: 30),
                    ],
                  ),
                  SizedBox(
                    height: 30.0,
                  ),
                  defaultTextForm(
                    context: context,
                    controller: emailController,
                    validate: (value){
                      if (value!.isEmpty) {
                        return 'Please enter your email';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.emailAddress, 
                    preIcon: Icons.email_outlined, 
                    hint: 'Email',
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  defaultTextForm(
                    context: context,
                    onSubmitted: (value){
                      if (formKey.currentState!.validate()) {
                        AppCubit.get(context).loginPostData(
                          email: emailController.text, 
                          password: passwordController.text,
                        );
                      }
                    },
                    controller: passwordController,
                    validate: (value){
                      if (value!.isEmpty) {
                        return 'Please enter your password';
                      }
                      return null;
                    },
                    sufIcon:AppCubit.get(context).isPass? Icons.visibility_outlined : 
                    Icons.visibility_off_outlined,
                    suffixOnPressed: (){
                      AppCubit.get(context).showPass();
                    },
                    isPassword: AppCubit.get(context).isPass,
                    keyboardType: TextInputType.visiblePassword, 
                    preIcon: Icons.lock_outlined, 
                    hint: 'Password',
                  ),
                  SizedBox(
                    height: 25.0,
                  ),
                  ConditionalBuilder(
                    condition: state is! LoginLoadingState, 
                    builder: (context)=>
                    defaultButton(
                      text: 'login', 
                      onPressed: (){
                        if (formKey.currentState!.validate()) {
                          AppCubit.get(context).loginPostData(
                            email: emailController.text, 
                            password: passwordController.text,
                          );
                        }
                      },
                    ), 
                    fallback: (context)=>Center(child: CircularProgressIndicator(color: defaultColor,)),
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  Row(
                    children: 
                    [
                      Spacer(),
                      defaultTextButton(
                        text: 'Forget password?', 
                        onPressed: (){
                          navigateTo(
                            context: context,
                            Widget: ForgetPasswordScreen(),
                          );
                        },
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 50.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children:
                    [
                      defaultTextButton(
                        text: 'register'.toUpperCase(), 
                        onPressed: (){
                          navigateTo(context: context ,Widget: RegisterScreen());
                        },
                      ),
                      Text(
                        'If you don\'t have an account',
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              ),
                  ),
              ),
            ),
          ),
          );
      },
    );
  }
}