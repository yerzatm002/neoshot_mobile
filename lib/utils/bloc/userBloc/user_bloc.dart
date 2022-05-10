import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neoshot_mobile/utils/model/city_model.dart';
import 'package:neoshot_mobile/utils/model/user_model.dart';
import 'package:neoshot_mobile/utils/repositories/user_repository.dart';
import 'package:neoshot_mobile/utils/services/user_service.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {

  final UserRepository userRepository;
  UserBloc({required this.userRepository}) : super(UserInitial()) {
    on<UserEvent>((event, emit) async {
      if(event is UserLoadEvent) {
        emit(UserLoadingState());
        try {
          UserModel _userModel = await userRepository.getLoggedUser;
          return emit(UserLoadedState(userModel: _userModel));
        } catch(e) {
          debugPrint("GetLoggedUserInfo exception: " + e.toString());
          // FlutterSecureStorage storage = const FlutterSecureStorage();
          // storage.delete(key: 'token');
          // if(e.toString() == "FormatException: Unexpected end of input (at character 1)") {
          //   FlutterSecureStorage storage = const FlutterSecureStorage();
          //   storage.delete(key: 'token');
          //   WidgetsBinding.instance!
          //       .addPostFrameCallback((_) => main());
          // }
          return emit(UserErrorState());
        }
      }
      // if(event is UserLoadCitiesEvent) {
      //   emit(UserLoadingState());
      //   try {
      //     List<CityModel> _cities = await provider.getCities();
      //     return emit(UserCitiesLoadedState(cities: _cities));
      //   } catch(e) {
      //     debugPrint("GetLoggedUserInfo exception: " + e.toString());
      //     return emit(UserErrorState());
      //   }
      // }
    });
  }
}

