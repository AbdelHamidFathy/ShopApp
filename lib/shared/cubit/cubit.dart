import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/add_delete_favorite_model.dart';
import 'package:shop_app/models/cart_model.dart';
import 'package:shop_app/models/categories_model.dart';
import 'package:shop_app/models/contacts_model.dart';
import 'package:shop_app/models/favorites_model.dart';
import 'package:shop_app/models/fqa_model.dart';
import 'package:shop_app/models/home_model.dart';
import 'package:shop_app/models/login_model.dart';
import 'package:shop_app/models/notifications_model.dart';
import 'package:shop_app/models/profile_model.dart';
import 'package:shop_app/models/search_model.dart';
import 'package:shop_app/modules/categories_screen.dart';
import 'package:shop_app/modules/favorite_screen.dart';
import 'package:shop_app/modules/home_screen.dart';
import 'package:shop_app/modules/login_screen.dart';
import 'package:shop_app/modules/profile_screen.dart';
import 'package:shop_app/network/end_points.dart';
import 'package:shop_app/network/local/cache_helper.dart';
import 'package:shop_app/network/remote/dio_helper.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shared/cubit/states.dart';

class AppCubit extends Cubit<AppStates>{
  AppCubit() :super(InitialState());

  static AppCubit get(context)=>BlocProvider.of(context);

  bool isPass =true;
  late LoginModel model;
  late HomeModel homeModel;
  void loginPostData({
    required String email,
    required String password,
  }){
    emit(LoginLoadingState());
    DioHelper.postData(
      url: Login, 
      data: {
        'email':email,
        'password':password,
      },
    ).then((value) {
      model= LoginModel.fromJson(value.data);
      print(model.messaage);
      emit(LoginSuccessState(model));
    }).catchError((error){
      print(error.toString());
      emit(LoginErrorState(error.toString()));
    });
  }
  late bool forgetStatus;
  late String forgetMsg;
  void forgetPassPostData({
    required String email,
  }){
    DioHelper.postData(
      url: verfiyEmail, 
      data: {
        'email':email,
      },
    ).then((value) {
      forgetMsg=value.data['message'];
      forgetStatus=value.data['status'];
      emit(ForgetPasswordState());
    });
  }
  late bool resetStatus;
  late String resetMsg;
  void resetPassPostData({
    required String email,
    required String code,
    required String password,
  }){
    DioHelper.postData(
      url: resetPassword, 
      data: {
        'email':email,
        'code':code,
        'password':password,
      },
    ).then((value){
      resetStatus=value.data['status'];
      resetMsg=value.data['message'];
      emit(ResetPasswordState());
    });
  }
  late LoginModel registerModel;
  late String registerMsg;
  late bool registerStatus;
  void register({
    required String name,
    required String email,
    required String phone,
    required String password,
  }){
    emit(RegisterLoadingState());
    DioHelper.postData(
      url: Register, 
      data: {
        'name':name,
        'email':email,
        'phone':phone,
        'password':password,
      },
    ).then((value) {
      emit(RegisterSuccessState());
      registerMsg=value.data['message'];
      registerStatus=value.data['status'];
    }).catchError((error){
      print(error.toString());
    });
  }

  void closeOnboard(){
    CacheHelper.saveData(key: 'onBoarding', value: false);
    emit(OnBoardingClosedState());
  }
  int currentIndex=0;

  List<Widget> screens=
  [
    HomeScreen(),
    CategoriesScreen(),
    FavoriteScreen(),
    ProfileScreen(),
  ];
  void changeBottomNavBarItem(index){
    currentIndex=index;
    emit(ChangeBottomNavBarItemState());
  }

  void getHomeData(){
    emit(LoadingHomeDataState());
    DioHelper.getData(
      url: Home, 
      token: token,
    ).then((value) {
      homeModel=HomeModel.fromJson(value.data);
      homeModel.data.products.forEach((element) { 
        favorites.addAll({element.id:element.inFavorite});
      });
      emit(SuccessHomeDataState());
    }).catchError((error){
      emit(ErrorHomeDataState());
      print(error.toString());
    });
  }
  late CategoriesModel catModel;
  void getCategoriesData(){
    emit(LoadingCategoriesDataState());
    DioHelper.getData(
      url: Categories,
    ).then((value) {
      catModel=CategoriesModel.fromJson(value.data);
      emit(SuccessCategoriesDataState());
    }).catchError((error){
      emit(ErrorCategoriesDataState());
      print(error.toString());
    });
  }
  late NotificationsModel notModel;
  void getNotificationsData(){
    emit(LoadingNotificationsState());
    DioHelper.getData(
      url: Notifications
    ).then((value) {
      notModel=NotificationsModel.fromJson(value.data);
      emit(SuccessNotificationsState());
    }).catchError((error){
      print(error.toString());
      emit(ErrorNotificationsState());
    });
  }
  late FavoritesModel favModel;
  void getFavorites(){
    emit(LoadingFavoritesState());
    DioHelper.getData(
      url:Favorites,
      token: token, 
    ).then((value){
      favModel=FavoritesModel.fromJson(value.data);
      emit(SuccessFavoritesState());
    }).catchError((error){
      emit(ErrorFavoritesState(error));
      print(error.toString());
    });
  }
  AddDeleteFavorite? adFavModel;
  Map<int, bool>favorites={};
  void changeFavorite({
    required dynamic id,

  }){
    favorites[id]=!favorites[id]!;
    emit(ChangeFavoriteState());
    DioHelper.postData(
      url: Favorites, 
      data: {
        'product_id': id,
      },
      token: token,
    ).then((value) {
      adFavModel=AddDeleteFavorite.fromJson(value.data);
      if (!adFavModel!.status) {
        favorites[id]=!favorites[id]!;
      }
      else {
        getFavorites();
      }
      emit(SuccessChangeFavoriteState(adFavModel!));
      
    }).catchError((error){
      favorites[id]=!favorites[id]!;
      print(error.toString());
      emit(ErrorChangeFavoriteState());
    });
  }
  late ProfileModel proModel;
  void getProfile(){
    DioHelper.getData(
      url: Profile,
      token: token,
    ).then((value) {
      proModel=ProfileModel.fromJson(value.data);
      emit(SuccessGetProfileState());
    }).catchError((error){
      print(error.toString());
      emit(ErrorGetProfileState());
    });
  }
  late String updateMsg;
  late bool updateStatus;
  void updateProfile({
    required String name,
    required String email,
    required String phone,
    required String password,
  }){
    emit(LoadingUpdateProfileState());
    DioHelper.putData(
      token: token,
      url: UpdateProfile, 
      data: {
        "name":name,
        "phone":phone,
        "email":email,
        "password":password,
      }, 
    ).then((value) {
      proModel=ProfileModel.fromJson(value.data);
      updateMsg=value.data['message'];
      updateStatus=value.data['status'];
      emit(SuccessUpdateProfileState());
    }).catchError((error){
      print(error.toString());
      emit(ErrorUpdateProfileState());
    });
  }
  late SearchModel searchModel;
  void productSearch({
    required String text,
  }){
    emit(LoadingSearchState());
    DioHelper.postData(
      token: token,
      url: Search, 
      data: {
        'text':text,
      },
    ).then((value) {
      searchModel=SearchModel.fromJson(value.data);
      emit(SuccessSearchState());
    }).catchError((error){
      print(error.toString());
      emit(ErrorSearchState());
    });
  }
  void showPass(){
    isPass=!isPass;
    emit(ShowPassState());
  }
  late ContactsModel contactsModel;
  void getContacts(){
    DioHelper.getData(
      url: Contacts, 
    ).then((value) {
      contactsModel=ContactsModel.fromJson(value.data);
      emit(SuccessContactsState());
    }).catchError((error){
      emit(ErrorContactsState());
      print(error.toString());
    });
  }
  late FQAsModel fqaModel;
  void getFQA(){
    DioHelper.getData(
      url: FQAs,
    ).then((value) {
      fqaModel=FQAsModel.fromJson(value.data);
      emit(SuccessFQAsState());
    }).catchError((error){
      print(error.toString());
      emit(ErrorFQAsState());
    });
  }
  late CartModel cartModel;
  void getCart(){
    DioHelper.getData
    (url: Cart,
    token: token,
    ).then((value) {
      cartModel=CartModel.fromJson(value.data);
      emit(SuccessCartState());
    }).catchError((error){
      print(error.toString());
      emit(ErrorCartState());
    });
  }
  late String cartMsg;
  void adCart({
    required dynamic id,
  }){
    DioHelper.postData(
      token: token,
      url: Cart, 
      data: {'product_id':id},
    ).then((value) {
      cartMsg=value.data['message'];
      print(cartMsg);
      getCart();
      emit(SuccessADCartState());
    }).catchError((error){
      print(error.toString());
      emit(ErrorADCartState());
    });
  }
  void signOut(context){
    CacheHelper.removeData(key: 'token').then((value) {
      navigateAndFinish(context: context, Widget: LoginScreen());
    });
  }
}