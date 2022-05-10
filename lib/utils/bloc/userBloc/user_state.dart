part of 'user_bloc.dart';

abstract class UserState {}

class UserInitial extends UserState {}

class UserLoadingState extends UserState {}

class UserLoadedState extends UserState {
  UserModel userModel;
  UserLoadedState({required this.userModel});
}

class UserCitiesLoadedState extends UserState {
  final List<CityModel> cities;
  UserCitiesLoadedState({required this.cities});
}

class UserErrorState extends UserState {}