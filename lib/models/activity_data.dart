class ActivityData {
  final String title;
  final String description;
  final List<String> equations;
  final List<String>? content;

  ActivityData({
    required this.title,
    required this.description,
    required this.equations,
    this.content,
  });

  factory ActivityData.fromJson(Map<String, dynamic> json) {
    return ActivityData(
      title: json['title'] as String,
      description: json['description'] as String,
      equations: (json['equations'] as List<dynamic>).map((e) => e as String).toList(),
      content: json['content'] != null
          ? (json['content'] as List<dynamic>).map((e) => e as String).toList()
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'equations': equations,
      if (content != null) 'content': content,
    };
  }
}
