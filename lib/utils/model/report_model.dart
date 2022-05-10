
class ReportModel{
  final int id;
  final String fromUser;
  final String text;

  ReportModel({
    required this.id,
    required this.fromUser,
    required this.text,
  });

  factory ReportModel.fromJson(json) {
    return ReportModel(
      id: json['id'] ?? 1,
      fromUser: json['from'] ?? "USERNAME",
      text: json['text'] ?? 'nothing'
    );
  }

}

