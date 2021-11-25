import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/modules/login_screen.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/cubit/cubit.dart';
import 'package:shop_app/shared/cubit/states.dart';

class ResetPasswordScreen extends StatelessWidget {
  var emailController = TextEditingController();
  var codeConteroller = TextEditingController();
  var newPasswordController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state){
        if (state is ResetPasswordState) {
          if (!AppCubit.get(context).resetStatus) {
            toast(
              msg: AppCubit.get(context).resetMsg, 
              state: ToastStates.ERROR,
            );
          }
        }
      },
      builder: (contxet, state){
        return Scaffold(
          body: SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: formKey,
                  child: Column(
                    children: 
                    [
                      Text(
                        'Reset password',
                        style: TextStyle(
                          fontSize:32.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 25.0,
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
                        keyboardType: TextInputType.emailAddress, 
                        preIcon: Icons.password, 
                        hint: 'Code', 
                        controller: codeConteroller, 
                        validate: (value){
                          if (value!.isEmpty) {
                            return 'Please enter the code of 4 digits';
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
                        keyboardType: TextInputType.emailAddress, 
                        preIcon: Icons.lock_outlined, 
                        hint: 'New password', 
                        controller: newPasswordController, 
                        validate: (value){
                          if (value!.isEmpty) {
                            return 'Please enter your new password';
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 40.0,
                      ),
                      defaultButton(
                        text: 'continue', 
                        onPressed: (){
                          if (formKey.currentState!.validate()) {
                            AppCubit.get(context).resetPassPostData(
                              email: emailController.text, 
                              code: codeConteroller.text, 
                              password: newPasswordController.text,
                            );
                            if (AppCubit.get(context).resetStatus) {
                            Navigator.pushAndRemoveUntil(
                            context, 
                            MaterialPageRoute(builder: (context)=>LoginScreen()), 
                            (route) => false,
                            ); 
                            }
                          }
                        },
                      ),
                    ],
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