import 'package:neoshot_mobile/utils/model/user_model.dart';
import 'package:neoshot_mobile/utils/services/user_service.dart';

class UserRepository {

  final UserService _userService = UserService();

  Future<UserModel> get getLoggedUser => _userService.getLoggedUser();

}