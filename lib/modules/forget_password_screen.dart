import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/modules/register_screen.dart';
import 'package:shop_app/modules/reset_password_screen.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/cubit/cubit.dart';
import 'package:shop_app/shared/cubit/states.dart';

class ForgetPasswordScreen extends StatelessWidget {
  var emailController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state){
        if (state is ForgetPasswordState) {
          if (!AppCubit.get(context).forgetStatus) {
            toast(
              msg: AppCubit.get(context).forgetMsg, 
              state: ToastStates.ERROR,
            );
          }
        }
      },
      builder: (context, state){
      return Scaffold(
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
                        children:
                        [
                          Text(
                            'Forget password',
                            style: TextStyle(
                              fontSize: 32.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          Text(
                            'Please enter your email and we will send to you a code to retrieve your account',
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 18.0,
                            ),
                          ),
                          SizedBox(
                            height: 80.0,
                          ),
                          Container(
                            height: 300.0,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
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
                                    height: 50.0,
                                  ),
                                  defaultButton(
                                    text: 'continue', 
                                    onPressed: (){
                                      if(formKey.currentState!.validate()){
                                        AppCubit.get(context).forgetPassPostData(email: emailController.text);
                                        if (AppCubit.get(context).forgetStatus) {
                                         navigateAndFinish(context: context, Widget: ResetPasswordScreen()); 
                                        }
                                      }
                                    }
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 25.0,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children:
                            [
                              Text(
                                'Don\'t have an account',
                                style: TextStyle(
                                  color: Colors.grey,
                                ),
                              ),
                              defaultTextButton(
                                text: 'sign up'.toUpperCase(), 
                                onPressed: (){
                                  navigateTo(context: context ,Widget: RegisterScreen());
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
            ),
        ),
        );
      },
    );
  }
}