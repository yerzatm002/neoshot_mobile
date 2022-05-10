import 'package:neoshot_mobile/utils/model/city_model.dart';

class UserModel {
  final int id;
  final String username;
  final String email;
  final String instagram;
  final String image;
  final CityModel city;

  UserModel({
    required this.city,
    required this.image,
    required this.id,
    required this.username,
    required this.email,
    required this.instagram});

  factory UserModel.fromJson(json) => UserModel(
      id: json['id'] ?? 1,
      username: json['username'] ?? "USERNAME",
      email: json['email'] ?? "EMAIL",
      instagram: json['instagram'] ?? "instagram",
      image: json['image'] ?? 'https://afitat-bol.com/wp-content/uploads/2021/03/default-user-avatar.jpg',
      // city: CityModel.fromJson(json['cityDto'])
      city: CityModel(id: 1, name: "Nur-Sultan")
  );
}