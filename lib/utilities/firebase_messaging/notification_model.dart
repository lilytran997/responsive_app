class NotificationModel {
  final String title;
  final String body;

  NotificationModel({this.title, this.body});

  factory NotificationModel.fromJson(Map<String, dynamic> json) =>
      NotificationModel(
        title: json['notification']['title'],
        body: json['notification']['body'],
      );
}

