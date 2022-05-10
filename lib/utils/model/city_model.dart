import 'package:json_annotation/json_annotation.dart';

part 'city_model.g.dart';

@JsonSerializable()
class CityModel {

  final int id;
  final String name;

  CityModel({required this.id, required this.name});

  factory CityModel.fromJson(Map<String,dynamic> json) => _$CityModelFromJson(json);

  @override
  String toString() {
    return 'CityModel{id: $id, name: $name}';
  }

  Map<String, dynamic> toJson() => _$CityModelToJson(this);



}