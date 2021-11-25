import 'package:flutter/cupertino.dart';
import 'package:shop_app/models/add_delete_favorite_model.dart';
import 'package:shop_app/models/login_model.dart';
import 'package:shop_app/shared/cubit/cubit.dart';

abstract class AppStates{}

class InitialState extends AppStates{}

class LoginLoadingState extends AppStates{}

class LoginSuccessState extends AppStates{
  LoginModel model;
  LoginSuccessState(this.model);
}

class LoginErrorState extends AppStates{
  final String error;
  LoginErrorState(this.error);
}

class RegisterLoadingState extends AppStates{}

class RegisterSuccessState extends AppStates{
  /* LoginModel model;
  RegisterSuccessState(this.model); */
}

class RegisterErrorState extends AppStates{
  final String error;
  RegisterErrorState(this.error);
}

class ForgetPasswordState extends AppStates{}

class ResetPasswordState extends AppStates{}

class OnBoardingClosedState extends AppStates{}

class ChangeThemeState extends AppStates {}

class ChangeBottomNavBarItemState extends AppStates {}

class LoadingHomeDataState extends AppStates{}

class SuccessHomeDataState extends AppStates{}

class ErrorHomeDataState extends AppStates{}

class LoadingCategoriesDataState extends AppStates{}

class SuccessCategoriesDataState extends AppStates{}

class ErrorCategoriesDataState extends AppStates{}

class LoadingNotificationsState extends AppStates{}

class SuccessNotificationsState extends AppStates{}

class ErrorNotificationsState extends AppStates{}

class LoadingFavoritesState extends AppStates{}

class SuccessFavoritesState extends AppStates{}

class ErrorFavoritesState extends AppStates{
  String error;
  ErrorFavoritesState(this.error);
}

class SuccessChangeFavoriteState extends AppStates{
  AddDeleteFavorite model;
  SuccessChangeFavoriteState(this.model);
}

class ErrorChangeFavoriteState extends AppStates{}

class ChangeFavoriteState extends AppStates{}

class SuccessGetProfileState extends AppStates{}

class ErrorGetProfileState extends AppStates{}

class LoadingUpdateProfileState extends AppStates{}

class SuccessUpdateProfileState extends AppStates{}

class ErrorUpdateProfileState extends AppStates{}

class LoadingSearchState extends AppStates{}

class SuccessSearchState extends AppStates{}

class ErrorSearchState extends AppStates{}

class ShowPassState extends AppStates{}

class SuccessContactsState extends AppStates{}

class ErrorContactsState extends AppStates{}

class SuccessFQAsState extends AppStates{}

class ErrorFQAsState extends AppStates{}

class SuccessCartState extends AppStates{}

class ErrorCartState extends AppStates{}

class SuccessADCartState extends AppStates{}

class ErrorADCartState extends AppStates{}
