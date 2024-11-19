// En activity_data.dart
class ActivityData {
  final String title;
  final String description;
  final List<String> videoUrls;

  ActivityData({
    required this.title,
    required this.description,
    required this.videoUrls,
  });

  // Método para crear una instancia de ActivityData desde un JSON
  factory ActivityData.fromJson(Map<String, dynamic> json) {
    var videoList = json['videoUrls'] as List;
    List<String> videos = videoList.map((i) => i.toString()).toList();
    
    return ActivityData(
      title: json['title'],
      description: json['description'],
      videoUrls: videos,
    );
  }
}
