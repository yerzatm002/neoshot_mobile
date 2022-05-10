import 'dart:convert';

// To parse this JSON data, do
//
//     final postModel = postModelFromJson(jsonString);

import 'dart:convert';

PostModel postModelFromJson(String str) => PostModel.fromJson(json.decode(str));

String postModelToJson(PostModel data) => json.encode(data.toJson());

class PostModel {
  PostModel({
    required this.content,
    required this.pageable,
    required this.totalElements,
    required this.totalPages,
    required this.last,
    required this.sort,
    required this.first,
    required this.number,
    required this.numberOfElements,
    required this.size,
    required this.empty,
  });

  List<Post> content;
  Pageable pageable;
  int totalElements;
  int totalPages;
  bool last;
  Sort sort;
  bool first;
  int number;
  int numberOfElements;
  int size;
  bool empty;

  factory PostModel.fromJson(Map<String, dynamic> json) => PostModel(
    content: List<Post>.from(json["content"].map((x) => Post.fromJson(x))),
    pageable: Pageable.fromJson(json["pageable"]),
    totalElements: json["totalElements"],
    totalPages: json["totalPages"],
    last: json["last"],
    sort: Sort.fromJson(json["sort"]),
    first: json["first"],
    number: json["number"],
    numberOfElements: json["numberOfElements"],
    size: json["size"],
    empty: json["empty"],
  );

  Map<String, dynamic> toJson() => {
    "content": List<dynamic>.from(content.map((x) => x.toJson())),
    "pageable": pageable.toJson(),
    "totalElements": totalElements,
    "totalPages": totalPages,
    "last": last,
    "sort": sort.toJson(),
    "first": first,
    "number": number,
    "numberOfElements": numberOfElements,
    "size": size,
    "empty": empty,
  };
}

class Post {
  Post({
    required this.id,
    required this.fimage,
    required this.simage,
    required this.timage,
    required this.description,
    required this.tags,
    required this.reaction,
    required this.createdDate,
    required this.username,
    required this.userId,
    required this.userPhoto,
  });

  int id;
  String fimage;
  dynamic simage;
  dynamic timage;
  String description;
  List<String> tags;
  int reaction;
  DateTime createdDate;
  String username;
  int userId;
  String userPhoto;

  factory Post.fromJson(Map<String, dynamic> json) => Post(
    id: json["id"],
    fimage: json["fimage"],
    simage: json["simage"],
    timage: json["timage"],
    description: json["description"],
    tags: List<String>.from(json["tags"].map((x) => x)),
    reaction: json["reaction"],
    createdDate: DateTime.parse(json["createdDate"]),
    username: json["username"],
    userId: json["userId"],
    userPhoto: json["userPhoto"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "fimage": fimage,
    "simage": simage,
    "timage": timage,
    "description": description,
    "tags": List<dynamic>.from(tags.map((x) => x)),
    "reaction": reaction,
    "createdDate": "${createdDate.year.toString().padLeft(4, '0')}-${createdDate.month.toString().padLeft(2, '0')}-${createdDate.day.toString().padLeft(2, '0')}",
    "username": username,
    "userId": userId,
    "userPhoto": userPhoto,
  };
}

class Pageable {
  Pageable({
    required this.sort,
    required this.pageNumber,
    required this.pageSize,
    required this.offset,
    required this.paged,
    required this.unpaged,
  });

  Sort sort;
  int pageNumber;
  int pageSize;
  int offset;
  bool paged;
  bool unpaged;

  factory Pageable.fromJson(Map<String, dynamic> json) => Pageable(
    sort: Sort.fromJson(json["sort"]),
    pageNumber: json["pageNumber"],
    pageSize: json["pageSize"],
    offset: json["offset"],
    paged: json["paged"],
    unpaged: json["unpaged"],
  );

  Map<String, dynamic> toJson() => {
    "sort": sort.toJson(),
    "pageNumber": pageNumber,
    "pageSize": pageSize,
    "offset": offset,
    "paged": paged,
    "unpaged": unpaged,
  };
}

class Sort {
  Sort({
    required this.unsorted,
    required this.sorted,
    required this.empty,
  });

  bool unsorted;
  bool sorted;
  bool empty;

  factory Sort.fromJson(Map<String, dynamic> json) => Sort(
    unsorted: json["unsorted"],
    sorted: json["sorted"],
    empty: json["empty"],
  );

  Map<String, dynamic> toJson() => {
    "unsorted": unsorted,
    "sorted": sorted,
    "empty": empty,
  };
}


// class PostModel{
//   final int id;
//   final String firstImage;
//   final String secondImage;
//   final String thirdImage;
//   final String description;
//   final List<String> tags;
//   final String username;
//   final int userId;
//   final String userPhoto;
//
//   PostModel({
//     required this.firstImage,
//     required this.secondImage,
//     required this.id,
//     required this.username,
//     required this.thirdImage,
//     required this.description,
//     required this.tags,
//     required this.userId,
//     required this.userPhoto,
//   });
//
//   factory PostModel.fromJson(json) {
//     return PostModel(
//         id: json['id'] ?? 1,
//         username: json['username'] ?? "USERNAME",
//         userId: json['userId'] ?? 1,
//         userPhoto: json['userPhoto'] ?? "https://afitat-bol.com/wp-content/uploads/2021/03/default-user-avatar.jpg",
//         firstImage: json['fimage'] ?? 'https://afitat-bol.com/wp-content/uploads/2021/03/default-user-avatar.jpg',
//         secondImage: json['simage'] ?? 'https://afitat-bol.com/wp-content/uploads/2021/03/default-user-avatar.jpg',
//         thirdImage: json['timage'] ?? 'https://afitat-bol.com/wp-content/uploads/2021/03/default-user-avatar.jpg',
//         description: json['description'] ?? 'nothing',
//         tags: (jsonDecode(json['tags']) as List<dynamic>).cast<String>(),
//     );
//   }
// }