import 'activity_data.dart';

class TopicData {
  final String title;
  final List<ActivityData> activities;

  TopicData({required this.title, required this.activities});

  factory TopicData.fromJson(Map<String, dynamic> json) {
    return TopicData(
      title: json['title'],
      activities: (json['activities'] as List)
          .map((activity) => ActivityData.fromJson(activity))
          .toList(),
    );
  }
}
