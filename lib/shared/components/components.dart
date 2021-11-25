import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/shared/cubit/cubit.dart';
import 'package:shop_app/shared/styles/colors.dart';

Widget defaultTextForm({
  required context,
  required TextInputType keyboardType,
  bool isPassword=false,
  required IconData preIcon,
  IconData? sufIcon,
  String? hint,
  String? label,
  required TextEditingController controller,
  required String? Function(String?)? validate,
  Function(String)? onSubmitted,
  Function(String)? onChanged,
  Function()? suffixOnPressed
}){
  return TextFormField(
    style: TextStyle(
      color: AppCubit.get(context).isDark ? Colors.white : Colors.black,
    ),
    onFieldSubmitted: onSubmitted,
    onChanged: onChanged,
    validator: validate,
    controller: controller,
    cursorColor: defaultColor,
    keyboardType:keyboardType,
    obscureText: isPassword,
    decoration: InputDecoration(
      fillColor: Colors.white,
      filled: true,
      suffixIcon: IconButton(
        icon: Icon(sufIcon,color: Colors.grey),
        onPressed: suffixOnPressed,
      ),
      prefixIcon: Icon(preIcon, color: Colors.grey,),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.transparent,),
        borderRadius: BorderRadius.all(Radius.circular(15.0)),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.transparent,),
        borderRadius: BorderRadius.all(Radius.circular(15.0)),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.transparent,),
        borderRadius: BorderRadius.all(Radius.circular(15.0)),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.transparent, ),
        borderRadius: BorderRadius.all(Radius.circular(15.0)),
      ),
      hintText: hint,
      labelText: label,
      labelStyle: TextStyle(
        color: defaultColor,
      ),
      hintStyle: TextStyle(
        color: Colors.grey,
      ),
    ),
  );
}
Widget defaultTextButton({
  required String text,
  required Function()? onPressed,
}){
  return TextButton(
    onPressed: onPressed, 
    child: Text(
      '${text}',
      style: TextStyle(
        color: defaultColor,
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}
void navigateTo({
  required context,
  required Widget,
}){
  Navigator.push(
    context, 
    MaterialPageRoute(
      builder: (context)=>Widget,
    ),
  );
}
void navigateAndFinish({
  required context,
  required Widget,
}){
  Navigator.pushAndRemoveUntil(
    context, 
    MaterialPageRoute(builder: (context)=>Widget), 
    (route) => false,
  );
}

Widget defaultButton({
  required String text,
  required Function()? onPressed,
}){
  return Container(
    height: 50.0,
    width: double.infinity,
    decoration: BoxDecoration(
      color: defaultColor,
      borderRadius: BorderRadius.circular(15.0),
    ),
    child: MaterialButton(
      height: 50.0,
      onPressed: onPressed,
      child: Text(
        '${text}'.toUpperCase(),
        style: TextStyle(
          color: Colors.white,
        ),
      ), 
    ),
  );
}
void toast({
  required String msg,
  required ToastStates state,
}){
  Fluttertoast.showToast(
    msg: msg,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 5,
    backgroundColor: chooseToastColor(state),
    textColor: Colors.white,
    fontSize: 16.0,
  );
}
enum ToastStates { SUCCESS, ERROR, WARNING }

Color chooseToastColor(ToastStates state){
  Color color;
  switch (state) {
    case ToastStates.SUCCESS:
      color=Colors.green;
      break;
    case ToastStates.ERROR:
      color=Colors.red;
      break;
    case ToastStates.WARNING:
      color=Colors.amber;
      break;
  }
  return color;
}
Widget underLine({
  required double width,
}){
  return
  Container(
    height: 5.0,
    width: width,
    decoration: BoxDecoration(
      color: defaultColor,
      borderRadius: BorderRadius.circular(30.0),
    ),
  );
}
Widget back(context){
  return IconButton(
    onPressed: (){
      Navigator.pop(context);
    }, 
    icon: Icon(
      Icons.arrow_back_ios,
      color: Colors.grey,
    ),
  );
}