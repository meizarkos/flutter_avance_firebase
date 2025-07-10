final class Post {
  final String? id;
  final String? title;
  final String? content;
  final int? timestamp;

  const Post({
    this.id,
    this.title,
    this.content,
    this.timestamp,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json['id'] as String?,
      title: json['title'] as String?,
      content: json['content'] as String?,
      timestamp: json['timestamp'] as int?,
    );
  }
}